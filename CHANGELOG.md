## 0.0.1

* 首次发布。
* 支持 Android、iOS、HarmonyOS 三端地图展示。
* 通过 `TencentMapView` Widget 嵌入原生地图视图，提供 `TencentMapController` 进行地图操作。
* 支持四种地图类型：常规（`standard`）、卫星（`satellite`）、暗色（`dark`）、3D 沉浸式（`immersiveMap3D`）。
* 支持 20+ 地图配置项：缩放/俯视/旋转开关、建筑物 3D、标注字体、比例尺、指南针、帧率等。
* 提供地图回调：鉴权、首次渲染、区域变化、用户定位、点击地图/POI/聚合点/聚合子项。
* 提供点聚合能力：设置聚合距离、批量添加聚合点、刷新、清除。
* 提供坐标转换工具：经纬度 ↔ 屏幕坐标互转。
* 内置隐私合规接口（`setPrivacyAgreement`），地图初始化前必须调用。
* 提供定位权限申请接口（`requestLocationAuthorization`）。
* 提供 Flutter 生命周期感知，自动映射到原生地图 resumed / paused / detached。
* 提供地理信息检索（仅 Android / iOS）：关键词提示、行政区域检索、地理编码、逆地理编码、周边搜索。
* 检索功能通过 `TencentSearcherPlugin` 单例使用，支持 API Key + Secret Key 配置。
