--1.一般CPU占用高是由排序、SQL解析、执行计划突变、全表扫描、会话阻塞等，可能的原因较多，需要抽丝剥茧，逐步定位根因；
--2.分析方法主要由主机top/topas占CPU高的进程查询相应SQL、会话增长趋势、阻塞分析、ASH/AWR报告分析、SQL执行时间/执行计划变化等；
--3.需要询问客户业务场景，业务上有没有变更，例如开发功能变更、业务使用量增加等，是当前突发的，还是持续了一段时间的问题

--找到占用系统资源特别大的Oracle的Session及执行的SQL语句(根据进程号查找)
select a.username,a.machine,a.program,a.sid,a.serial#,a.status,c.piece,c.sql_text from v$session a, v$process b,v$sqltext c
where b.spid=&pid and b.addr=a.paddr and a.sql_address=c.address(+) order by c.piece;
--根据sid查找session的执行语句
select sid,sql_text from v$session s,v$sql q
where sid = &sid and (q.sql_id=s.sql_id or q.sql_id = s.prev_sql_id);
--通过查询V$SYSMETRIC_HISTORY视图（记录了上一小时里每1分钟的指标信息，上3分钟里每15s的指标信息），可以得出每分钟内会话数的增长趋势
select begin_time,trunc(value) 
from V$SYSMETRIC_HISTORY 
where metric_name='Average Active Sessions' 
and group_id=2 order by begin_time;

--等待事件阻情况
SELECT t.SQL_ID,t.EVENT,COUNT(*) 
from v$active_session_history t
WHERE t.SAMPLE_TIME >= to_date('2018-09-13 08:30:00', 'yyyy-mm-dd hh24:mi:ss')
   and sample_time < to_date('2018-09-13 11:00:00', 'yyyy-mm-dd hh24:mi:ss')
GROUP BY t.SQL_ID,t.EVENT ORDER BY 3 DESC;
--等待事件发生的时间趋势
SELECT TRUNC(sqmple_time,'mi'),COUNT(1) from v$active_session_history t
WHERE t.SAMPLE_TIME >= to_date('2018-09-13 08:30:00', 'yyyy-mm-dd hh24:mi:ss')
   and sample_time < to_date('2018-09-13 11:00:00', 'yyyy-mm-dd hh24:mi:ss')
   AND t.EVENT='enq: TX - row lock contention'
   GROUP BY trunc(t.SAMPLE_TIME,'mi')
   ORDER BY 1;
--需要进一步分析，通过分析等待事件链根源：
with ash as (select /*+ materialize*/ * from   v$active_session_history t
 where sample_time >=
       to_date('2018-09-13 08:30:00', 'yyyy-mm-dd hh24:mi:ss')
   and sample_time <
       to_date('2018-09-13 11:00:00', 'yyyy-mm-dd hh24:mi:ss')),
   chains as (
   select session_id, level lvl,
          sys_connect_by_path(session_id||' '|| sql_id || ' '||event, ' -> ' ) path,
          connect_by_isleaf isleaf
     from ash
    start with event in ( 'enq: TX - row lock contention')
    connect by nocycle ( prior blocking_session = session_id
    and prior blocking_session_serial# = session_serial# and prior sample_id = sample_id))
 select lpad(round (ratio_to_report(count(*)) over () * 100 )||'%', 5,' ' ) "%This",
        count(*) samples,
        path
   from chains
  where isleaf = 1
  group by path
  order by samples desc ;
--AWR整体分析
--查看SQL执行计划历史情况
SELECT s.inst_id,
s.EXECUTIONS,
ROUND(s.ELAPSED_TIME/s.EXECUTIONS,2) elapsed_avg,
ROUND(s.BUFFER_GETS/s.EXECUTIONS,2) buffer_avg,
ROUND(s.DISK_READS/s.EXECUTIONS,2) disk_avg,
ROUND(s.ROWS_PROCESSED/s.ELAPSED_TIME,2) rows_arg,
s.CHILD_NUMBER,
s.PLAN_HASH_VALUE,
s.SQL_PROFILE,
s.LAST_ACTIVE_TIME,
s.LAST_LOAD_TIME
 from gv$sql s
WHERE s.SQL_ID='&sqlid'
AND s.executions>0;
--查看表最后一次分析时间
SELECT owner,table_name,last_analyzed from Dba_Tab_Statistics WHERE last_analyzed IS NOT NULL ORDER BY 3 DESC;
--查询自动统计信息收集信息
SELECT * from dba_autotask_window_clients;
SELECT w.window_name,w.repeat_interval,w.duration,w.enabled 
from Dba_Autotask_Window_Clients c,dba_scheduler_windows w
WHERE c.WINDOW_NAME=w.window_name AND c.OPTIMIZER_STATS='ENABLED';
--大于10%的改变量的表实际没有及时收集到统计信息，重新收集后dba_tab_modifications重新计算
select table_owner,
       table_name,
       (inserts + updates + deletes) all_update_num,
       (inserts + updates + deletes) /
       nvl((select num_rows
             from dba_tables
            where owner = a.table_owner
              and table_name = a.table_name
              and num_rows <> 0),
           1) * 100 flag
  from dba_tab_modifications a
 where a.table_owner in ('用户名')
 order by (inserts + updates + deletes) desc;
--考虑锁定num_rows很大，last_analyzed收集信息较旧的表
select t.table_owner,
       t.table_name,
       t.partition_name,
       t.num_rows,
       t.last_analyzed
  from dba_tab_partitions t
 where t.table_owner = 'P2BEMADM'
 order by t.num_rows desc;
--大于10%的改变量的表实际没有及时收集到统计信息
select table_owner,
       table_name,
       (inserts + updates + deletes) all_update_num,
       (inserts + updates + deletes) /
       nvl((select num_rows
             from dba_tables
            where owner = a.table_owner
              and table_name = a.table_name
              and num_rows <> 0),
           1) * 100 flag
  from dba_tab_modifications a
 where a.table_owner in ('P2BEMADM')
 order by (inserts + updates + deletes) desc;
--每日的改动量很大，也超过10%，对于这样的表进行锁定统计信息，让自动统计收集过滤这些表，然后定期做手工收集统计信息，放到自动JOB过程里。
--dbms_stats.lock_table_stats('用户名','表名');
--定期执行以下内容（举例）：
begin
dbms_stats.unlock_table_stats('用户名','表名');
dbms_stats.gather_table_stats(ownname => '用户名',tabname =>’表名’,estimate_percent => 0.2,cascade =>true);
dbms_stats.gather_table_stats(ownname => '用户名',tabname =>’表名’,partname =>’分区名’,estimate_percent => 0.2,cascade =>true);
dbms_stats.gather_table_stats(ownname=>'用户名',tabname=>'表名',granularty=>'APPROX_GLOBAL AND PARTITION',partname=>'分区名',estimate=>0.00001,cascade=>true);
dbms_stats.lock_table_stats('用户名','表名');
end;
--禁用临时表统计信息收集
select s.table_name, s.STATTYPE_LOCKED
     from dba_TAB_STATISTICS s
    where S.table_name IN (select T1.table_name
                          from dba_tables t1
                         where t1.temporary = 'Y'
                           and owner = '用户名')
--其中STATTYPE_LOCKED字段为空表示没有锁定统计信息。
--为避免数据库引用错误的临时表统计信息进行锁定临时表统计信息，而让其进行动态采样收集
begin
dbms_stats.unlock_table_stats('用户名','表名');
dbms_stats.delete_table_stats(用户名,'表名'); 
dbms_stats.lock_table_stats(用户名,'表名');
end;
--当系统有很大的分区表时，如果总是全部收集则会比较慢，11g之后可以设置INCREMENTAL只对数据有变动的分区做收集，如下示：
exec dbms_stats.set_table_prefs('JD','IMS_RES_MONITOR_2','INCREMENTAL','TRUE');
exec dbms_stats.set_table_prefs(user,'table_name','INCREMENTAL','TRUE'); --只收集数据变动的分区
select dbms_stats.get_prefs('INCREMENTAL',null,'table_name') from dual;  --查看分区表INCREMENTAL的值
----下面修改配置(使用sys用户登录oracle执行)
sqlplus sys/xxx@xxxdb as sysdba
--修改SATURDAY_WINDOW、SUNDAY_WINDOW的配置 (改成和平常相同,即每日都是22:00向后4小时,至次日凌晨2点)
--下面的方式也可修改周六、周日的时间Window
begin
  sys.dbms_scheduler.set_attribute(name => 'SYS.SATURDAY_WINDOW', attribute => 'repeat_interval', value => 'Freq=daily;ByDay=SAT;ByHour=22;ByMinute=0;BySecond=0');
  sys.dbms_scheduler.set_attribute(name => 'SYS.SATURDAY_WINDOW', attribute => 'duration', value => '0 04:00:00');
end;
/
begin
  sys.dbms_scheduler.set_attribute(name => 'SYS.SUNDAY_WINDOW', attribute => 'repeat_interval', value => 'Freq=daily;ByDay=SUN;ByHour=22;ByMinute=0;BySecond=0');
  sys.dbms_scheduler.set_attribute(name => 'SYS.SUNDAY_WINDOW', attribute => 'duration', value => '0 04:00:00');
end;
/
--查看修改结果:
select t1.window_name,t1.repeat_interval,t1.duration from dba_scheduler_windows t1,dba_scheduler_wingroup_members t2
 where t1.window_name=t2.window_name and t2.window_group_name='MAINTENANCE_WINDOW_GROUP';
/*           WINDOW_NAME        REPEAT_INTERVAL        DURATION
1        MONDAY_WINDOW        freq=daily;byday=MON;byhour=22;byminute=0; bysecond=0        +000 04:00:00
2        TUESDAY_WINDOW        freq=daily;byday=TUE;byhour=22;byminute=0; bysecond=0        +000 04:00:00
3        WEDNESDAY_WINDOW        freq=daily;byday=WED;byhour=22;byminute=0; bysecond=0        +000 04:00:00
4        THURSDAY_WINDOW        freq=daily;byday=THU;byhour=22;byminute=0; bysecond=0        +000 04:00:00
5        FRIDAY_WINDOW        freq=daily;byday=FRI;byhour=22;byminute=0; bysecond=0        +000 04:00:00
6        SATURDAY_WINDOW        Freq=daily;ByDay=SAT;ByHour=22;ByMinute=0;BySecond=0        +000 04:00:00
7        SUNDAY_WINDOW        Freq=daily;ByDay=SUN;ByHour=22;ByMinute=0;BySecond=0        +000 04:00:00
*/
