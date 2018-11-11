--找出数据库中sql语句运行时间最长
select s.sql_text from v$sql s,v$undostat u where u.maxqueryid=s.sql_id;
--找出当前执行的事务中，使用撤销空间最多的会话
select s.sid,s.username,t.used_urec,t.used_ublk from v$session s,v$transaction t where s.saddr=t.ses_addr order by t.used_ublk desc;
--找出实例中当前哪个会话使用最多的查询空间
select s.sid,t.name,s.value from v$sesstat s,v$statistic# t
WHERE t.name='undo change vector size'
order by s.value desc;
--v$transaction视图显示关于活动事务详细信息，used_urec显示所使用的撤销记录数量，used_ublk列显示事务所占用的撤销数据块
select sql.sql_text sql_text,
       t.used_urec Records,
       t.used_ublk Block,
       (t.used_ulk * 8192 / 1024) kbytes
  from v$transaction t, v$session s, v$sql sql
 where t.addr = s.taddr
   and s.sql_id = sql.sql_id
   and s.username = '&USERNAME';
