--查询临时表空间已经使用和空闲空间
select *
  from (select a.tablespace_name, sum(a.bytes / 1024 / 1024) allocated_mb
          from dba_temp_files a
         where a.tablespace_name = uper('&&temp_tsname')
         group by a.tablespace_name) x,
       (select sum(b.bytes_used / 1024 / 1024) used_mb,
               sum(b.bytes_free / 1024 / 1024) free_mb
          from v$temp_space_header b
         where b.tablespace_name = uper('&&temp_tsname')
         group by b.tablespace_name);
--攻略7-5_确定谁使用临时表空间
--找出哪一条sql语句把排序数据段中的空间用光
select s.sid || ',' | s.serial# sid_serial,
       s.username,
       o.blocks * t.block_size / 1024 / 1024 mb_used,
       o.tablespace,
       o.sqladdr address,
       h.hash_value,
       h.sql_text
  from v$sort_usage o, v$session s, v$sqlarea h, dba_tablespaces t
 where o.session_addr = s.saddr
   and o.sqladdr = h.address(+)
   and o.tablespace = t.tablespace_name
 order by s.sid;
 --下面查询查出哪个会话使用了临时表空间中的存储空间，只给出每个会话总得使用率
select s.sid || ',' || s.serial# sid_serial,
       s.username,
       s.osuser,
       p.spid,
       s.module,
       s.program,
       sum(o.blocks) * t.block_size / 1024 / 1024 mb_used,
       o.tablesapce,
       count(*) sorts
  from v$sort_usage o, v$session s, dba_tablespaces t, v$process p
 where o.session_addr = s.saddr
   and s.paddr = p.addr
   and o.tablespace = t.tablespace_name
 group by s.sid,
          s.serial#,
          s.username,
          s.osuser,
          p.spid,
          s.module,
          s.program,
          t.block_size,
          o.tablespace
 order by sid_serial;
--
