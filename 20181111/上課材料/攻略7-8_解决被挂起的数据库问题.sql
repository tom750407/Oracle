--���������ݿⱻ���𣬰������沽������Ų�
--1����鱨����־�������Ƿ������Դ���
--2�������ܲ�������һ��AWR����ASH���棬��ѯ�������ᵽ��ASH��ͼ������AWR��load profile�����ҵ�����
--3������һ���ر�Ĳ�ѯ��Ȼ���Ը�����ݿ⣬�鿴����sql���߽���
--4��������ݿ����Ƿ�����������Լ�����������
--5�����������ڴ�ʹ���ʺ�CPUʹ���ʣ�ȷ��������ֵ����µ�PGA��������
--6�������鵵��־�Ƿ����ˣ����߹鵵��־��
--7��FRA��flash recovery area ���ػָ������޷�д���������ݿ���־Ҳ��������ʹ�ã�alter system set db_recouvery_file_size=8G
--������ܽ��ʹ��prelim��¼���ݿ�
$sqlplus /nolog
set _prelim on
connect /as sysdba
--����;sqlplus -prelim "/as sysdba"
--ִ��oradebug hanganalyze�����������ݿ�
oradebug hanganalyze 3
--RAC������ʹ�ø���ѡ��ָ��
oradebug setinst all
oradebug -g def hanganalyze 3
--����hanganalyze��������ת���ļ���SR����Ҫһ������ת���ļ�-ϵͳ״̬ת��
oradebug setmypid
oradebug dump systemstate 266
--RAC������
oradebug setmypid
oradebug unlimit
oradebug -g all dump systemstate 266
--�������ύϵͳ״̬ת���������ת��֮������Լһ���ӣ�
--ͨ���������ת���ļ�������ADR׷���ļ�����

--����ʹ��oradebug dumplist�鿴�����ռ��ĸ��ִ���
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
