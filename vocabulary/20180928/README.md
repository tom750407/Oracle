# 2018/09/28 vocabulary
Vocabulary|Definition
----------|----------
striping|切分
span|延展
error correction code|錯誤修正碼
parity|奇偶校驗
redundant|冗餘
inexpensive|廉價
independent|獨立
block interleaving|
disk Striping|硬碟分割
data striping|數據分割/條帶化
redundant array of independent disks|磁碟陣列

Level 0 -- Striped Disk Array without Fault Tolerance  
Level 1 -- Mirroring and Duplexing  
Level 2 -- Error-Correcting Coding  
Level 3 -- Bit-Interleaved Parity  
Level 4 -- Dedicated Parity Drive  
Level 5 -- Block Interleaved Distributed Parity  
Level 6 -- Independent Data Disks with Double Parity  
Level 0+1 -- Mirror of Stripes  
Level 1+0 -- Stripe of Mirror  




Data striping
- 當多個進程同時訪問一個磁盤時，可能會出現磁盤衝突
- 大多數磁盤系統都對訪問次數（每秒的I/O 操作，IOPS）和數據傳輸率（每秒傳輸的數據量，TPS）有限制
- 當達到這些限制時，後面需要訪問磁盤的進程就需要等待，這時就是所謂的磁盤衝突
- 避免磁盤衝突是優化I/O 性能的一個重要目標，而I/O 性能的優化與其他資源（如CPU和內存）的優化有著很大的區別,I/O 優化最有效的手段是將I/O 最大限度的進行平衡
- 條帶化技術就是一種自動的將I/O 的負載均衡到多個物理磁盤上的技術，條帶化技術就是將一塊連續的數據分成很多小部分並把他們分別存儲到不同磁盤上去
- 這就能使多個進程同時訪問數據的多個不同部分而不會造成磁盤衝突，而且在需要對這種數據進行順序訪問的時候可以獲得最大程度上的I/O 並行能力，從而獲得非常好的性能
- 由於條帶化在I/O 性能問題上的優越表現，以致於在應用系統所在的計算環境中的多個層次或平台都涉及到了條帶化的技術，如操作系統和存儲系統這兩個層次中都可能使用條帶化技術

JBOD(Just a Bunch Of Disks)

RAID(Redundant Arrays of Inexpensive Disks)

