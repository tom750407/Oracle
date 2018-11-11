--当遇到数据库被挂起，按照下面步骤进行排查
--1）检查报警日志，看看是否有明显错误
--2）看看能不能生成一份AWR或者ASH报告，查询第五章提到的ASH视图，查找AWR中load profile部分找到线索
--3）单独一条特别的查询当然可以搞垮数据库，查看单独sql或者进程
--4）检查数据库中是否存在阻塞锁以及所存器争夺
--5）检查服务器内存使用率和CPU使用率，确保不会出现第三章的PGA设置问题
--6）看看归档日志是否满了，移走归档日志，
--7）FRA（flash recovery area 闪回恢复区）无法写入闪回数据库日志也会挂起可以使用：alter system set db_recouvery_file_size=8G
--如果不能解决使用prelim登录数据库
$sqlplus /nolog
set _prelim on
connect /as sysdba
--或者;sqlplus -prelim "/as sysdba"
--执行oradebug hanganalyze分析挂起数据库
oradebug hanganalyze 3
--RAC环境中使用附加选项指定
oradebug setinst all
oradebug -g def hanganalyze 3
--除了hanganalyze命令生产转储文件，SR还需要一个进程转储文件-系统状态转储
oradebug setmypid
oradebug dump systemstate 266
--RAC环境：
oradebug setmypid
oradebug unlimit
oradebug -g all dump systemstate 266
--必须多次提交系统状态转储命令，两次转储之间间隔大约一分钟，
--通过命令创建的转储文件创建在ADR追踪文件夹中

--可以使用oradebug dumplist查看所能收集的各种错误；
sql> oradebug dumplist
TRACE_BUFFER_ON
TRACE_BUFFER_OFF
LATCHES
PROCESSSTATE
SYSTEMSTATE
INSTANTIATIONSTATE
REFRESH_OS_STATS
CROSSIC
CONTEXTAREA
HANGDIAG_HEADER
HEAPDUMP
