# 第四堂課 SQL的指令與高級查詢

檔案包括
---
上課講解的材料
## pptx
- Lesson 6: Reporting Aggregated Data Using the Group Functions
- Lesson 7: Displaying Data from Multiple Tables Using Joins
- Lesson 8: Using Subqueries to Solve Queries
- Lesson 9: Using Set Operators
- Lesson 10: Managing Tables Using DML Statements
- Lesson 11: Introduction to Data Definition Language
- Lesson 12: Oracle Cloud Overview
### APPENDIX
- Lesson 13: Table Descriptions
- Lesson 14: Using SQL Developer
- Lesson 15: Using SQL*Plus
- Lesson 16: Commonly Used SQL Commands
## docx
- oracle分析函數over
- oracle分析函數Rank, Dense_rank, row_number
- 級聯查詢(Hierarchical Queries)
- 級聯查詢(Hierarchical Queries)偽列Level

重點
---
- 連接sqlplus用這個指令
	- sqlplus user/pass@database
	- e.g. sqlplus hr/hr@pdboaec
- 執行sql用這個指令
	- sqlplus user/pass@database @sql
	- e.g. sqlplus hr/hr@pdboaec @insert.sql
- 啟動oracle database
	- 首先先確認listener是否啟動
		- lsnrctl status - 確認listener狀態
		- lsnrctl start - 啟動listener
		- lsnrctl shutdown - 關閉listener
	- 再來就是啟動服務了,先以管理員身分登入sqlplus
		- sqlplus / as sysdba - 以系統管理員身分連接數據庫
	- 登入到sql指令模式後就可以將實例與資料庫開啟
		- start up - 開啟實例
		- alter pluggable database pdboaec open; - 開啟pdboaec數據庫
		- exit - 退出
額外學習
---
sql練習4-10

成功之路: Oracle 11g學習筆記

劍破冰山 Oracle開發藝術

Oracle 11g 數據庫項目應用開發
