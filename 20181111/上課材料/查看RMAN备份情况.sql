--�鿴��7�챸��������ǳ���ϸ��ps�������кķѵ�ʱ�䲻��Ҫ����
select s.status as "����״̬",
       b.INPUT_TYPE as "��������",
       to_char(b.START_TIME,'yyyy-mm-dd hh24:mi:ss') as �ܵĿ�ʼʱ��,
       to_char(b.end_time, 'yyyy-mm-dd hh24:mi:ss') as �ܵĽ���ʱ��,
       trunc(b.ELAPSED_SECONDS/60,0) as ��ʱ���ٷ���,
       b.INPUT_BYTES_PER_SEC_DISPLAY "in_sec/s",
       b.OUTPUT_BYTES_PER_SEC_DISPLAY "out_sec/s",
       trunc((s.END_TIME-s.START_TIME)*24*60,0) "�����ļ�������ʱ(��)",
       to_char(s.START_TIME, 'yyyy-mm-dd hh24:mi:ss') as "��ʼ����ʱ��",
       to_char(s.END_TIME, 'yyyy-mm-dd hh24:mi:ss') as "��������ʱ��",
       s.OPERATION as "����",
       trunc(s.INPUT_BYTES/1024/1024,2) as "INPUT-M",
       trunc(s.OUTPUT_BYTES/1024/1024,2) as "OUTPUT-M",
       s.OBJECT_TYPE as "��������",
       s.MBYTES_PROCESSED as "�ٷֱ�",
       s.OUTPUT_DEVICE_TYPE as "�豸����"
  from v$rman_status s,v$rman_backup_job_details b
  where to_char(s.START_TIME, 'yyyy-mm-dd hh24:mi:ss') < to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')
  and to_char(s.END_TIME, 'yyyy-mm-dd hh24:mi:ss') > to_char(sysdate-100,'yyyy-mm-dd hh24:mi:ss')
  and s.COMMAND_ID=b.COMMAND_ID
  AND s.status='RUNNING'
  order by  s.START_TIME desc ;
  --------------------------------------------�������жϵı���
  SELECT bp.STAMP,bp.SET_STAMP,'rm -rf'||bp.HANDLE,bp.START_TIME,bp.COMPLETION_TIME,bp.RMAN_STATUS_STAMP 
from  V$BACKUP_PIECE bp WHERE to_char(bp.START_TIME, 'yyyy-mm-dd hh24:mi:ss') LIKE '2018-11-08%'
AND bp.HANDLE IS NOT NULL 
AND bp.RMAN_STATUS_STAMP IN (SELECT STAMP from v$rman_status s WHERE s.status IN ('RUNNING WITH ERRORS','FAILED'));
---------------------------------------
  SELECT A.RECID "BACKUP SET",
       A.SET_STAMP,
        DECODE (B.INCREMENTAL_LEVEL,
                '', DECODE (BACKUP_TYPE, 'L', 'Archivelog', 'Full'),
                1, 'Incr-1��',
                0, 'Incr-0��',
                B.INCREMENTAL_LEVEL)
           "Type LV",
        B.CONTROLFILE_INCLUDED "����CTL",
        DECODE (A.STATUS,
                'A', 'AVAILABLE',
                'D', 'DELETED',
                'X', 'EXPIRED',
                'ERROR')
           "STATUS",
        A.DEVICE_TYPE "Device Type",
        A.START_TIME "Start Time",
        A.COMPLETION_TIME "Completion Time",
        A.ELAPSED_SECONDS "Elapsed Seconds",
        A.BYTES/1024/1024/1024 "Size(G)",
        A.COMPRESSED,
        A.TAG "Tag",
        A.HANDLE "Path"
   FROM GV$BACKUP_PIECE A, GV$BACKUP_SET B
  WHERE A.SET_STAMP = B.SET_STAMP AND A.DELETED = 'NO'
ORDER BY A.COMPLETION_TIME DESC;
