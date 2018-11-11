--��ѯ��ʱ��ռ��Ѿ�ʹ�úͿ��пռ�
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
--����7-5_ȷ��˭ʹ����ʱ��ռ�
--�ҳ���һ��sql�����������ݶ��еĿռ��ù�
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
 --�����ѯ����ĸ��Ựʹ������ʱ��ռ��еĴ洢�ռ䣬ֻ����ÿ���Ự�ܵ�ʹ����
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
