--计算数据库中实际产生的撤销数据
select sum(d.bytes)/1024/1024 "undo_M"
  from v$datafile d, v$tablespace t, dba_tablespaces s
 where s.contents = 'UNDO'
   and s.status = 'ONLINE' AND t.name = s.tablespace_name
   and d.ts# = t.ts#;
--计算UNDO_BLOCKS_PER_SED
select max(undoblks / ((end_time - begin_time) * 3600 * 24))
  from v$undostat;
 --显示oracle如何根据当前实例中运行最长的查询，自动优化撤销保留时间
 select to_char(begin_time, 'hh24:mi:ss') BEGIN_TIME,
        to_char(end_time, 'hh24:mi:ss') END_TIME， maxquerylen,
        nospaceerrcnt,
        tuned_undoretention
   from v$undostat;
--显示撤销数据库的使用率，以及每十分钟间隔内的事务记数
select to_char(begin_time, 'hh24:mi:ss'),
       to_char(end_time, 'hh24:mi:ss'),
       maxquerylen,
       ssolderrcnt,
       nospaceerrcnt,
       undoblks,
       txncount
  from v$undostat
 order by undoblks;
