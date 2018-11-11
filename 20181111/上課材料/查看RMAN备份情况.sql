--查看近7天备份情况，非常详细。ps：命令列耗费的时间不需要计算
select s.status as "备份状态",
       b.INPUT_TYPE as "备份类型",
       to_char(b.START_TIME,'yyyy-mm-dd hh24:mi:ss') as 总的开始时间,
       to_char(b.end_time, 'yyyy-mm-dd hh24:mi:ss') as 总的结束时间,
       trunc(b.ELAPSED_SECONDS/60,0) as 耗时多少分钟,
       b.INPUT_BYTES_PER_SEC_DISPLAY "in_sec/s",
       b.OUTPUT_BYTES_PER_SEC_DISPLAY "out_sec/s",
       trunc((s.END_TIME-s.START_TIME)*24*60,0) "单个文件备份用时(分)",
       to_char(s.START_TIME, 'yyyy-mm-dd hh24:mi:ss') as "开始备份时间",
       to_char(s.END_TIME, 'yyyy-mm-dd hh24:mi:ss') as "结束备份时间",
       s.OPERATION as "命令",
       trunc(s.INPUT_BYTES/1024/1024,2) as "INPUT-M",
       trunc(s.OUTPUT_BYTES/1024/1024,2) as "OUTPUT-M",
       s.OBJECT_TYPE as "对象类型",
       s.MBYTES_PROCESSED as "百分比",
       s.OUTPUT_DEVICE_TYPE as "设备类型"
  from v$rman_status s,v$rman_backup_job_details b
  where to_char(s.START_TIME, 'yyyy-mm-dd hh24:mi:ss') < to_char(sysdate,'yyyy-mm-dd hh24:mi:ss')
  and to_char(s.END_TIME, 'yyyy-mm-dd hh24:mi:ss') > to_char(sysdate-100,'yyyy-mm-dd hh24:mi:ss')
  and s.COMMAND_ID=b.COMMAND_ID
  AND s.status='RUNNING'
  order by  s.START_TIME desc ;
  --------------------------------------------检查错误，中断的备份
  SELECT bp.STAMP,bp.SET_STAMP,'rm -rf'||bp.HANDLE,bp.START_TIME,bp.COMPLETION_TIME,bp.RMAN_STATUS_STAMP 
from  V$BACKUP_PIECE bp WHERE to_char(bp.START_TIME, 'yyyy-mm-dd hh24:mi:ss') LIKE '2018-11-08%'
AND bp.HANDLE IS NOT NULL 
AND bp.RMAN_STATUS_STAMP IN (SELECT STAMP from v$rman_status s WHERE s.status IN ('RUNNING WITH ERRORS','FAILED'));
---------------------------------------
  SELECT A.RECID "BACKUP SET",
       A.SET_STAMP,
        DECODE (B.INCREMENTAL_LEVEL,
                '', DECODE (BACKUP_TYPE, 'L', 'Archivelog', 'Full'),
                1, 'Incr-1级',
                0, 'Incr-0级',
                B.INCREMENTAL_LEVEL)
           "Type LV",
        B.CONTROLFILE_INCLUDED "包含CTL",
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
