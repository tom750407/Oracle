# 2018/09/26 vocabulary
Vocabulary|Definition
----------|----------
elasticity|彈性
automation|自動化
stability|穩定性
deployment|部署
scalability|可擴增的
iteration|迭代
distribution|分配
replicate|複製
provision|提供
patch|修補
monitor|監控
failover|故障轉移
migrate|遷移
associate|關聯
capability|能力
utilization|使用
inspection|檢查
server load balancer|負載均衡
disaster recovery system|容災系統


# 雲伺服器(Elastic Compute Service)
- 基礎雲端運算服務
- 使用Elastic Compute Service就像使用水、電、瓦斯等資源一樣便捷、高效
- 無需提前採購硬體裝置，而是根據業務需要，隨時建立所需數量的Elastic Compute Service執行個體
- 在使用過程中，隨著業務的擴充,可以
	- 隨時擴容磁碟
	- 增加頻寬
- 如果不再需要雲伺服器，也能隨時釋放資源，節省費用
- ECS涉及的所有資源，包括
	- 執行個體規格
	- 區塊存放裝置
	- 鏡像
	- 快照
	- 頻寬
	- 安全性群組

# 雲資料庫(Relational Database Service)
- 阿里雲ApsaraDB for RDS
	- 安全可靠、伸縮靈活的按需雲資料庫服務
	- 部署方便快捷，具有自動上線和伸縮功能，可以根據應用的即時需求擴充或縮小資料庫
	- 高度可用託管服務，具有自動監控、備份及容災功能，可將您從耗時的資料庫管理工作中解放出來，讓您有其他時間專註於您的應用和商務
	- 資料庫託管服務提供三種資料庫引擎：MySQL、SQL Server及PostgreSQL

# 專有網路功能(Virtual Private Cloud)
- 基於阿里雲構建出一個隔離的網路功能環境，以便在安全的專有環境中執行資源
- 通過選取項目IP位址可及範圍、設定路由表和網路閘道，可以掌控和自訂網路功能
- 可以通過將本網無間斷的接至阿里雲專有網路功能來相應增加資源，並利用阿里雲作為資料中心的延伸項目應用程式執行個體

# 雲存儲(Object Storage Service/Table Store/Network Attached Storage)
### Object Storage Service
- 高度可伸縮且安全強固雲物件儲存服務，可以儲存、備份和歸檔大量資料
- 簡單易用的服務，每秒能處理數百萬要求，還支援巨量資料、科學與財務剖析以及媒體應用
- 可隨時隨地以高度安全、經濟實惠的方式儲存、處理和存取資料
- 為企業提供加密雲端儲存，具有自動資料複製與容錯移轉功能及高達99.9%的服務可用工時和資料可靠性，是容災的理想選擇

### Table Store
- 基於阿里雲的Apsara散發式系統構建的可擴充且全託管的NoSQL資料存放區服務
- 該雲NoSQL資料庫服務能夠儲存海量結構化和半結構化的資料，同時實現即時存取、高度的一致性和單個毫秒的單行平均存取延時
- 可將資料群組織清理到包含行和列的表格中，這些表格能夠利用資料分區和負載平衡技術快速且無縫地進行擴充
- 自動備份和故障檢測功能使表格服務非常可靠，靈活的資料模型使表格服務非常適合任何 IoT、遊戲、行動裝置 App、Web 和許多其他套用

### Network Attached Storage
- 為ECS、HPC和Container Service等計算節點提供高可靠、彈性、高效能、多共用的檔案儲存體服務，相比雲上自建NAS以及傳統NAS具有諸多優勢

# 容災系統(Disaster Recovery System)
- 在相隔較遠的異地，建立兩套或多套功能相同的IT系統，互相之間可以進行健康狀態監視和功能切換，當一處系統因意外(如火災、地震等)停止工作時，整個應用系統可以切換到另一處，使得該系統功能可以繼續正常工作
- 容災技術是系統的高可用性技術的一個組成部分，容災系統更加強調處理外界環境對系統的影響，特別是災難性事件對整個IT節點的影響，提供節點級別的系統恢復功能
- 完善的容災系統是企業保護核心數據，讓企業生產應用不間斷運行、為客戶提供增值服務的關鍵和前提

# 負載均衡(Server Load Balancer)
- 可以降低單台雲服務器ECS出現異常時對業務的衝擊，提升業務的可用性
- 結合彈性伸縮服務，通過動態調整後端服務器，可以快速對業務進行彈性調整(擴容或縮容)，以快速應對業務的發展
