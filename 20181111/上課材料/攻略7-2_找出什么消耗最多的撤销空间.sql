--�ҳ����ݿ���sql�������ʱ���
select s.sql_text from v$sql s,v$undostat u where u.maxqueryid=s.sql_id;
--�ҳ���ǰִ�е������У�ʹ�ó����ռ����ĻỰ
select s.sid,s.username,t.used_urec,t.used_ublk from v$session s,v$transaction t where s.saddr=t.ses_addr order by t.used_ublk desc;
--�ҳ�ʵ���е�ǰ�ĸ��Ựʹ�����Ĳ�ѯ�ռ�
select s.sid,t.name,s.value from v$sesstat s,v$statistic# t
WHERE t.name='undo change vector size'
order by s.value desc;
--v$transaction��ͼ��ʾ���ڻ������ϸ��Ϣ��used_urec��ʾ��ʹ�õĳ�����¼������used_ublk����ʾ������ռ�õĳ������ݿ�
select sql.sql_text sql_text,
       t.used_urec Records,
       t.used_ublk Block,
       (t.used_ulk * 8192 / 1024) kbytes
  from v$transaction t, v$session s, v$sql sql
 where t.addr = s.taddr
   and s.sql_id = sql.sql_id
   and s.username = '&USERNAME';
