# 1 批量添加用戶腳本

首先需要一個包含用戶名與密碼的文本文件,每行包括了一個用戶名與密碼,中間以空格作為分隔符

<img src="https://github.com/tom750407/Oracle/blob/master/20180902/%E4%B8%8A%E8%AA%B2%E6%9D%90%E6%96%99/src/addusers.txt%E5%85%A7%E8%B3%87%E6%96%99.png" width="300px">addusers.txt內資料

for在讀取文件時,任何空白字符都能作為其讀取的分隔符,所以執行結果其實循環了18次,當然要是分隔符是使用空白字符外的其他字符就能得到我們想要的結果了

<img src="https://github.com/tom750407/Oracle/blob/master/20180902/%E4%B8%8A%E8%AA%B2%E6%9D%90%E6%96%99/src/useradd_for01.sh%E5%9F%B7%E8%A1%8C%E7%B5%90%E6%9E%9C.png" width="300px">useradd_for01.sh執行結果

而while從執行的結果來看,按行讀取沒問題,因為while是使用換行符號作為分隔符的

<img src="https://github.com/tom750407/Oracle/blob/master/20180902/%E4%B8%8A%E8%AA%B2%E6%9D%90%E6%96%99/src/useradd_while01.sh%E5%9F%B7%E8%A1%8C%E7%B5%90%E6%9E%9C.png" width="300px">useradd_while01.sh執行結果

接下來就要從每行中拆分出用戶名跟密碼,每行空格前面是用戶名,後面是密碼,用cut命令就能簡單的拆分開來了

<img src="https://github.com/tom750407/Oracle/blob/master/20180902/%E4%B8%8A%E8%AA%B2%E6%9D%90%E6%96%99/src/useradd_while02.sh%E5%9F%B7%E8%A1%8C%E7%B5%90%E6%9E%9C.png" width="300px">useradd_while02.sh執行結果

既然已經成功截取到每行的用戶名與密碼,下一步就是要使用useradd與passwd命令了,不過由於passwd是需要管理員權限的,所以要使用--stdin參數,這個參數可以使用管道將密碼傳給passwd命令

<img src="https://github.com/tom750407/Oracle/blob/master/20180902/%E4%B8%8A%E8%AA%B2%E6%9D%90%E6%96%99/src/useradd_while03.sh%E5%9F%B7%E8%A1%8C%E7%B5%90%E6%9E%9C.png" width="300px">useradd_while03.sh執行結果

雖然從上圖可以看出此腳本已經能夠運行了,但當我們再次運行時候會發現,新增用戶是失敗的,但是卻又成功地修改了密碼

<img src="https://github.com/tom750407/Oracle/blob/master/20180902/%E4%B8%8A%E8%AA%B2%E6%9D%90%E6%96%99/src/useradd_while03.sh%E5%86%8D%E5%9F%B7%E8%A1%8C%E7%B5%90%E6%9E%9C.png" width="300px">useradd_while03.sh再執行結果

因此需要在腳本內增加一個判斷式,如果用戶名已經存在就跳過修改,否則就新增用戶並修改密碼

此外如果可能的話,所有非BASH內建命令都建議使用全路徑,以防由於環境變量所造成的command not found問題

<img src="https://github.com/tom750407/Oracle/blob/master/20180902/%E4%B8%8A%E8%AA%B2%E6%9D%90%E6%96%99/src/useradd_while04.sh%E5%9F%B7%E8%A1%8C%E7%B5%90%E6%9E%9C.png" width="300px">useradd_while04.sh執行結果

當然有新增就有刪除,只要將過程反過來即可

<img src="https://github.com/tom750407/Oracle/blob/master/20180902/%E4%B8%8A%E8%AA%B2%E6%9D%90%E6%96%99/src/userdel_while01.sh%E5%9F%B7%E8%A1%8C%E7%B5%90%E6%9E%9C.png" width="300px">userdel_while01.sh執行結果

這樣一個簡易的新增與刪除的腳本就寫完了
