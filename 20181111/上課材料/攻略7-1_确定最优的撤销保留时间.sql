--�������ݿ���ʵ�ʲ����ĳ�������
select sum(d.bytes)/1024/1024 "undo_M"
  from v$datafile d, v$tablespace t, dba_tablespaces s
 where s.contents = 'UNDO'
   and s.status = 'ONLINE' AND t.name = s.tablespace_name
   and d.ts# = t.ts#;
--����UNDO_BLOCKS_PER_SED
select max(undoblks / ((end_time - begin_time) * 3600 * 24))
  from v$undostat;
 --��ʾoracle��θ��ݵ�ǰʵ����������Ĳ�ѯ���Զ��Ż���������ʱ��
 select to_char(begin_time, 'hh24:mi:ss') BEGIN_TIME,
        to_char(end_time, 'hh24:mi:ss') END_TIME�� maxquerylen,
        nospaceerrcnt,
        tuned_undoretention
   from v$undostat;
--��ʾ�������ݿ��ʹ���ʣ��Լ�ÿʮ���Ӽ���ڵ��������
select to_char(begin_time, 'hh24:mi:ss'),
       to_char(end_time, 'hh24:mi:ss'),
       maxquerylen,
       ssolderrcnt,
       nospaceerrcnt,
       undoblks,
       txncount
  from v$undostat
 order by undoblks;
