# 第二堂課 Shell腳本的寫法與Oracle數據庫的安裝

檔案包括
---
上課使用的Shell腳本指南以及搭建數據庫環境的教程

偵測權限的腳本

分數評估的腳本

還有我自己寫的剪刀石頭布的腳本

筆記
---
1.解壓縮tar zxvf
- z:通過gzip解壓縮
- x:解壓縮(c:壓縮)
- v:在解壓縮或壓縮過程顯示處理中的文件名
- f:代表後面接的是文件

安裝數據庫的重點部分
---
1./etc/hosts裡面添加hostname

2.由於PATH的修改是在oracle用戶的.bash_profile,所以要讓他成為環境變數的話要使用oracle來登入

3.dbca No protocol specified問題,在root下輸入
xhost local:oracle non-network local connections being added to access control list

額外學習
---
Shell腳本實踐指南-第十八章腳本範例
