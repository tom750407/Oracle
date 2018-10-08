# 2018/09/26 Distributed Computing
Vocabulary|Definition
----------|----------
distributed computing|分布式計算
consistency|一致性
availability|可用性
partition tolerance|分區容錯性
clustered|集群
manipulation|操作
asynchronous|異步
coordinator|協調者
participant|參與者
infrastructure|基礎建設

# CAP定理(CAP theorem)
- 又被稱作布魯爾定理(Brewer's theorem),這個定理指出了對於一個分布式計算系統(Distributed system),不可能同時滿足以下三點:
	- 一致性(Consistency)
		- 等同於所有節點訪問同一份最新的數據副本
	- 可用性(Availability)
		- 每次請求都能獲取到非錯的響應——但是不保證獲取的數據為最新數據
	- 分區容錯性(Partition tolerance)
		- 以實際效果而言，分區相當於對通信的時限要求。系統如果不能在時限內達成數據一致性，就意味著發生了分區的情況，必須就當前操作在C和A之間做出選擇
- 根據定理，分布式系統只能滿足三項中的兩項而不可能滿足全部三項
	- 理解CAP理論的最簡單方式是想像兩個節點分處分區兩側
		- 允許至少一個節點更新狀態會導致數據不一致，即喪失了C性質
		- 如果為了保證數據一致性，將分區一側的節點設置為不可用，那麼又喪失了A性質
		- 除非兩個節點可以互相通信，才能既保證C又保證A，這又會導致喪失P性質
