# 2018/10/08 Oracle ASM
Vocabulary|Definition
----------|----------
redundancy|冗於
failure|失敗

# Oracle ASM提供的三種冗於方式
- 三種模式:
	- external redundancy 外部冗於
	- normal redundancy 正常冗於
	- high redundancy 高度冗於
- 一般情況下三種模式需要的磁碟組:
	- external 1塊
	- normal 3塊
	- high 5塊
### 外部冗餘（external redundancy）
- 表示Oracle不幫你管理鏡像，功能由外部存儲系統實現，比如通過RAID技術
- 有效磁碟空間是所有磁碟設備空間的大小之和
### 正常冗餘（normal redundancy）
- 表示Oracle提供2份鏡像來保護數據(鏡像數據一次)，以提高數據的安全，最少需要兩塊磁碟（兩個failure group）
- 有效磁碟空間是所有磁碟設備大小之和的1/2 （使用最多）
### 高度冗餘（high redundancy）
- 表示Oracle提供3份鏡像來保護數據(鏡像數據兩次)，以提高性能和數據的安全，最少需要三塊磁碟（三個failure group）
- 有效磁碟空間是所有磁碟設備大小之和的1/3，雖然冗餘級別高了，但是硬件的代價也最高
