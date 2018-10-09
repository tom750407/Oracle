# 2018/10/08 SQL
Vocabulary|Definition
----------|----------
alter|變更
truncate|縮短（尤指去尾）
allocate|分配
concurrency|併發
privilege|特權
withdraw|取回
transaction|事務
atomicity|原子性
consistency|一致性
isolation|隔離性
durability|持久性
retrieve|檢索

# 資料定義語言 DDL(Data Definition Language)
- 用來定義資料庫、資料表、檢視表、索引、預存程序、觸發程序、函數等資料庫物件
- 可以用來建立、更新、刪除 table,index,function,views,store procedure and triggers
- 不需要COMMIT
- 常見的指令有:
	- CREATE : create the database or its objects
	- ALTER : alter the structure of the database
	- DROP : delete objects from the database
	- TRUNCATE : remove all records from a table, including all spaces allocated for the records are removed
	- COMMENT : add comments to the data dictionary
	- RENAME : rename an object existing in the database
# 資料操作語言 DML(Data Manipulation Language)
- 用來處理資料表裡的資料
- 需要COMMIT
- 常見的指令有:
	- INSERT : insert data into a table
	- UPDATE : update existing data within a table
	- DELETE : delete records from a table, the space for the records remain
	- MERGE : UPSERT operation (insert or update)
	- CALL : call a PL/SQL or Java subprogram
	- EXPLAIN PLAN : explain access path to data
	- LOCK TABLE : control concurrency
# 資料控制語言 DCL(Data Control Language)
- 用來控制資料表、檢視表之存取權限，提供資料庫的安全性
- 常見的指令有:
	- GRANT : gives user's access privileges to database
	- REVOKE : withdraw access privileges given with the GRANT command
# 事務控制語言 TCL(Transaction Control Language)
- 用來處理數據庫中的事物
- 常見的指令有:
	- COMMIT : save work done
	- SAVEPOINT : identify a point in a transaction to which you can later roll back
	- ROLLBACK : restore database to original since the last COMMIT
	- SET TRANSACTION : Change transaction options like isolation level and what rollback segment to use
# 資料查詢語言 DQL(Data Query Language)
- 負責進行資料查詢，不會對資料本身進行修改的語句
- 用來查詢資料表裡的資料
- 不需要COMMIT
- 常見的指令有:
        - SELECT : retrieve data from the a database
