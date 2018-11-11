--1.һ��CPUռ�ø���������SQL������ִ�мƻ�ͻ�䡢ȫ��ɨ�衢�Ự�����ȣ����ܵ�ԭ��϶࣬��Ҫ��˿���룬�𲽶�λ����
--2.����������Ҫ������top/topasռCPU�ߵĽ��̲�ѯ��ӦSQL���Ự�������ơ�����������ASH/AWR���������SQLִ��ʱ��/ִ�мƻ��仯�ȣ�
--3.��Ҫѯ�ʿͻ�ҵ�񳡾���ҵ������û�б�������翪�����ܱ����ҵ��ʹ�������ӵȣ��ǵ�ǰͻ���ģ����ǳ�����һ��ʱ�������

--�ҵ�ռ��ϵͳ��Դ�ر���Oracle��Session��ִ�е�SQL���(���ݽ��̺Ų���)
select a.username,a.machine,a.program,a.sid,a.serial#,a.status,c.piece,c.sql_text from v$session a, v$process b,v$sqltext c
where b.spid=&pid and b.addr=a.paddr and a.sql_address=c.address(+) order by c.piece;
--����sid����session��ִ�����
select sid,sql_text from v$session s,v$sql q
where sid = &sid and (q.sql_id=s.sql_id or q.sql_id = s.prev_sql_id);
--ͨ����ѯV$SYSMETRIC_HISTORY��ͼ����¼����һСʱ��ÿ1���ӵ�ָ����Ϣ����3������ÿ15s��ָ����Ϣ�������Եó�ÿ�����ڻỰ������������
select begin_time,trunc(value) 
from V$SYSMETRIC_HISTORY 
where metric_name='Average Active Sessions' 
and group_id=2 order by begin_time;

--�ȴ��¼������
SELECT t.SQL_ID,t.EVENT,COUNT(*) 
from v$active_session_history t
WHERE t.SAMPLE_TIME >= to_date('2018-09-13 08:30:00', 'yyyy-mm-dd hh24:mi:ss')
   and sample_time < to_date('2018-09-13 11:00:00', 'yyyy-mm-dd hh24:mi:ss')
GROUP BY t.SQL_ID,t.EVENT ORDER BY 3 DESC;
--�ȴ��¼�������ʱ������
SELECT TRUNC(sqmple_time,'mi'),COUNT(1) from v$active_session_history t
WHERE t.SAMPLE_TIME >= to_date('2018-09-13 08:30:00', 'yyyy-mm-dd hh24:mi:ss')
   and sample_time < to_date('2018-09-13 11:00:00', 'yyyy-mm-dd hh24:mi:ss')
   AND t.EVENT='enq: TX - row lock contention'
   GROUP BY trunc(t.SAMPLE_TIME,'mi')
   ORDER BY 1;
--��Ҫ��һ��������ͨ�������ȴ��¼�����Դ��
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
--AWR�������
--�鿴SQLִ�мƻ���ʷ���
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
--�鿴�����һ�η���ʱ��
SELECT owner,table_name,last_analyzed from Dba_Tab_Statistics WHERE last_analyzed IS NOT NULL ORDER BY 3 DESC;
--��ѯ�Զ�ͳ����Ϣ�ռ���Ϣ
SELECT * from dba_autotask_window_clients;
SELECT w.window_name,w.repeat_interval,w.duration,w.enabled 
from Dba_Autotask_Window_Clients c,dba_scheduler_windows w
WHERE c.WINDOW_NAME=w.window_name AND c.OPTIMIZER_STATS='ENABLED';
--����10%�ĸı����ı�ʵ��û�м�ʱ�ռ���ͳ����Ϣ�������ռ���dba_tab_modifications���¼���
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
 where a.table_owner in ('�û���')
 order by (inserts + updates + deletes) desc;
--��������num_rows�ܴ�last_analyzed�ռ���Ϣ�Ͼɵı�
select t.table_owner,
       t.table_name,
       t.partition_name,
       t.num_rows,
       t.last_analyzed
  from dba_tab_partitions t
 where t.table_owner = 'P2BEMADM'
 order by t.num_rows desc;
--����10%�ĸı����ı�ʵ��û�м�ʱ�ռ���ͳ����Ϣ
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
--ÿ�յĸĶ����ܴ�Ҳ����10%�����������ı��������ͳ����Ϣ�����Զ�ͳ���ռ�������Щ��Ȼ�������ֹ��ռ�ͳ����Ϣ���ŵ��Զ�JOB�����
--dbms_stats.lock_table_stats('�û���','����');
--����ִ���������ݣ���������
begin
dbms_stats.unlock_table_stats('�û���','����');
dbms_stats.gather_table_stats(ownname => '�û���',tabname =>��������,estimate_percent => 0.2,cascade =>true);
dbms_stats.gather_table_stats(ownname => '�û���',tabname =>��������,partname =>����������,estimate_percent => 0.2,cascade =>true);
dbms_stats.gather_table_stats(ownname=>'�û���',tabname=>'����',granularty=>'APPROX_GLOBAL AND PARTITION',partname=>'������',estimate=>0.00001,cascade=>true);
dbms_stats.lock_table_stats('�û���','����');
end;
--������ʱ��ͳ����Ϣ�ռ�
select s.table_name, s.STATTYPE_LOCKED
     from dba_TAB_STATISTICS s
    where S.table_name IN (select T1.table_name
                          from dba_tables t1
                         where t1.temporary = 'Y'
                           and owner = '�û���')
--����STATTYPE_LOCKED�ֶ�Ϊ�ձ�ʾû������ͳ����Ϣ��
--Ϊ�������ݿ����ô������ʱ��ͳ����Ϣ����������ʱ��ͳ����Ϣ����������ж�̬�����ռ�
begin
dbms_stats.unlock_table_stats('�û���','����');
dbms_stats.delete_table_stats(�û���,'����'); 
dbms_stats.lock_table_stats(�û���,'����');
end;
--��ϵͳ�кܴ�ķ�����ʱ���������ȫ���ռ����Ƚ�����11g֮���������INCREMENTALֻ�������б䶯�ķ������ռ�������ʾ��
exec dbms_stats.set_table_prefs('JD','IMS_RES_MONITOR_2','INCREMENTAL','TRUE');
exec dbms_stats.set_table_prefs(user,'table_name','INCREMENTAL','TRUE'); --ֻ�ռ����ݱ䶯�ķ���
select dbms_stats.get_prefs('INCREMENTAL',null,'table_name') from dual;  --�鿴������INCREMENTAL��ֵ
----�����޸�����(ʹ��sys�û���¼oracleִ��)
sqlplus sys/xxx@xxxdb as sysdba
--�޸�SATURDAY_WINDOW��SUNDAY_WINDOW������ (�ĳɺ�ƽ����ͬ,��ÿ�ն���22:00���4Сʱ,�������賿2��)
--����ķ�ʽҲ���޸����������յ�ʱ��Window
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
--�鿴�޸Ľ��:
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
