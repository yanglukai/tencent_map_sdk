# tencent_map_sdk

[![pub package](https://img.shields.io/pub/v/tencent_map_sdk.svg)](https://pub.dev/packages/tencent_map_sdk)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

`tencent_map_sdk` 是一个基于腾讯地图 SDK 封装的 Flutter 插件，支持 Android、iOS、HarmonyOS 三端。

通过集成此插件，开发者可以快速实现**地图展示**、**点聚合**、**地理编码/逆地理编码**、**关键词检索**等能力，满足出行、物流、O2O 等 LBS 场景的地图需求。

> 📖 **官方文档**：[腾讯位置服务](https://lbs.qq.com/)

---

## ✨ 功能特性

- 🗺️ **地图展示**：通过 PlatformView 将腾讯地图原生视图嵌入 Flutter Widget 树，支持常规、卫星、暗色、3D 沉浸式四种地图类型。
- 🎛️ **丰富配置**：支持缩放级别、俯视/旋转开关、比例尺、指南针、建筑物 3D、标注字体大小、帧率控制等 20+ 配置项。
- 📌 **点聚合**：支持批量添加聚合点、自定义聚合距离、刷新及清除，点击可逐级展开。
- 🔍 **关键词提示检索**：输入关键词获取联想地点建议，支持城市范围和分页。
- 🏙️ **行政区域检索**：获取全国完整行政区划树（省/市/区）。
- 📍 **地理编码**：地址 → 经纬度坐标。
- 🔄 **逆地理编码**：经纬度坐标 → 详细地址，支持返回周边 POI。
- 🔎 **周边搜索**：按中心点 + 半径搜索周边地点，支持排序和分页。
- 🧭 **坐标转换**：屏幕坐标 ↔ 经纬度互转。
- 🔐 **隐私合规**：内置隐私协议接口，地图初始化前必须调用。
- 📱 **三端覆盖**：支持 Android、iOS、HarmonyOS（检索功能仅 Android / iOS）。
- 🔄 **生命周期感知**：自动将 Flutter 生命周期映射到原生地图的 resumed / paused / detached。

---

## 📋 前置准备

在使用插件前，请务必完成以下配置：

1. **注册开发者**：在 [腾讯位置服务控制台](https://lbs.qq.com/) 注册并完成企业/个人认证。
2. **创建应用**：在控制台中创建应用，获取 **API Key**（地图展示）和 **Secret Key**（检索功能）。
3. **开启服务**：确保已开通「地图」和「检索」相关服务。
4. **配置权限**：各平台需在对应配置文件中声明网络权限和定位权限。

### Android

在 `AndroidManifest.xml` 中添加：

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

> ⚠️ **注意事项**：Android 端的 API Key 必须统一在 `AndroidManifest.xml` 中配置，在其他位置输入无效。具体配置位置请参见 Demo 或开发指南。

### iOS

在 `Info.plist` 中添加：

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>我们需要您的位置信息以提供更好的服务</string>
```

> 如需后台定位，在 Xcode 的 **Signing & Capabilities** → **Background Modes** 中勾选 **Location updates**。

### HarmonyOS

在 `module.json5` 中添加：

```json5
{
  "requestPermissions": [
    {
      "name": "ohos.permission.INTERNET"
    },
    {
      "name": "ohos.permission.LOCATION",
      "reason": "...",
      "usedScene": { "abilities": [], "when": "inuse" }
    },
    {
      "name": "ohos.permission.APPROXIMATELY_LOCATION",
      "reason": "...",
      "usedScene": { "abilities": [], "when": "inuse" }
    }
  ]
}
```

---

## 🚀 快速开始

### 1. 添加依赖

在 `pubspec.yaml` 中添加：

```yaml
dependencies:
  tencent_map_sdk: ^0.0.1
```

### 2. 导入包

```dart
import 'package:tencent_map_sdk/tencent_map_sdk.dart';
```

### 3. 代码示例

#### SDK 初始化

```dart
// 1. 设置隐私协议（必须首先调用）
TencentMapPlugin.instance.setPrivacyAgreement(true);

// 2. 设置 API Key（地图展示）
TencentMapPlugin.instance.setApiKey('你的腾讯地图API_KEY');

// 3. 设置 API Key + Secret Key（检索功能，仅 Android / iOS）
TencentSearcherPlugin.instance.setApiKey('你的腾讯地图API_KEY', '你的SecretKey');
```

#### 地图展示

```dart
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  TencentMapController? _mapController;

  void _onMapViewCreated(TencentMapController controller) {
    _mapController = controller;

    // 设置地图回调
    controller.setMapViewAuthenticationDidComplete(callback: (error) {
      if (error != null) {
        print('地图鉴权失败: ${error.code} - ${error.message}');
      } else {
        print('地图鉴权成功');
      }
    });

    controller.setMapViewFirstRenderDidComplete(callback: () {
      print('地图加载完成');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('腾讯地图')),
      body: TencentMapView(
        onViewCreated: _onMapViewCreated,
        mapConfig: TmConfig(
          mapType: TmType.standard,
          centerLatLng: TmLatLng(latitude: 39.908692, longitude: 116.397477),
          zoomLevel: 12,
          showsUserLocation: true,
          rotateEnabled: false,
          overlookingEnabled: false,
          shows3DBuildings: false,
        ),
      ),
    );
  }
}
```

#### 地图回调

```dart
void setupMapCallbacks(TencentMapController controller) {
  // 地图鉴权结果回调
  controller.setMapViewAuthenticationDidComplete(callback: (error) {
    print(error == null ? '鉴权成功' : '鉴权失败: ${error.code}');
  });

  // 地图首次渲染完成
  controller.setMapViewFirstRenderDidComplete(callback: () {
    print('地图加载完成');
  });

  // 地图区域变化（手势拖拽/缩放）
  controller.setMapViewRegionDidChangeComplete(
    callback: (latLng, gesture) {
      print('中心点: ${latLng.latitude}, ${latLng.longitude}');
    },
  );

  // 用户定位更新（showsUserLocation = true 时有效）
  controller.setUserLocationChangedComplete(callback: (latLng) {
    print('用户位置: ${latLng.latitude}, ${latLng.longitude}');
  });

  // 点击地图空白处
  controller.setMapViewDidTapAtLatLngComplete(callback: (latLng) {
    print('点击地图: ${latLng.latitude}, ${latLng.longitude}');
  });

  // 点击地图 POI 图标
  controller.setMapViewDidTapAtPoiComplete(callback: (poi) {
    print('点击POI: ${poi.name}');
  });

  // 聚合点点击
  controller.setMapViewDidTapAtClusterComplete(callback: (cluster) {
    print('聚合点: ${cluster.latLng?.longitude}');
  });

  // 单个聚合子项点击
  controller.setMapViewDidTapAtClusterItemComplete(callback: (info) {
    print('聚合子项: ${info.title}');
  });
}
```

#### 地图操作

```dart
// 设置地图中心点
_mapController?.setCenterLatLng(
  TmLatLng(latitude: 39.908692, longitude: 116.397477),
  animated: true,
);

// 获取缩放级别
double? zoom = await _mapController?.getZoomLevel();

// 设置缩放级别
await _mapController?.setZoomLevel(15, animated: true);

// 在当前基础上缩放（负数为缩小）
await _mapController?.changeZoomLevel(2, animated: true);
```

#### 点聚合

```dart
// 构造聚合点数据
List<TmClusterInfo> clusters = [];
for (var item in dataList) {
  clusters.add(TmClusterInfo(
    latLng: TmLatLng(longitude: item[0], latitude: item[1]),
    title: '测试数据',
    custom: {'customerName': '客户姓名', 'customerId': '1'},
    customId: '1',
  ));
}

// 设置聚合距离
await _mapController?.setClusterMaxDistance(100.0);

// 添加聚合点
await _mapController?.setClusterCoordinates(clusters);

// 刷新聚合点状态
await _mapController?.refreshCluster();

// 清除聚合点
await _mapController?.clearClusterCoordinates();
```

#### 坐标转换

```dart
// 经纬度 → 屏幕坐标
TmPoint? point = await _mapController?.convertCoordinateToPoint(
  TmLatLng(latitude: 39.908692, longitude: 116.397477),
);
print('x: ${point?.x}, y: ${point?.y}');

// 屏幕坐标 → 经纬度
TmLatLng? latLng = await _mapController?.convertPointToCoordinate(
  TmPoint(x: 100, y: 100),
);
print('经度: ${latLng?.longitude}, 纬度: ${latLng?.latitude}');
```

#### 关键词提示检索

```dart
final result = await TencentSearcherPlugin.instance
    .searchWithSuggestionSearchOption(
  TmSuggestionSearcherOption(
    keyword: '北京',
    region: '北京',
  ),
);

result?.forEach((poi) {
  print('${poi.title} — ${poi.address}');
});
```

#### 行政区域检索

```dart
final result = await TencentSearcherPlugin.instance.searchWithDistrictList();

// result 为三层嵌套列表，每层对应各级行政区划
result?[0].forEach((item) => print(item.fullName)); // 省级
result?[1].forEach((item) => print(item.fullName)); // 市级
```

#### 地理编码（地址 → 坐标）

```dart
final result = await TencentSearcherPlugin.instance
    .searchWithGeoCodeSearchOption(
  TmGeoCodeSearchOption(
    address: '北京市海淀区彩和坊路海淀西大街74号',
    region: '北京',
  ),
);

print('经度: ${result?.location?.longitude}');
print('纬度: ${result?.location?.latitude}');
```

#### 逆地理编码（坐标 → 地址）

```dart
final result = await TencentSearcherPlugin.instance
    .searchWithReverseGeoCodeSearchOption(
  TmReverseGeoCodeSearchOption(
    location: TmLatLng(latitude: 39.908692, longitude: 116.397477),
    getPoi: true,  // 是否返回周边 POI
  ),
);

print('地址: ${result?.address}');
result?.poisArray?.forEach((poi) {
  print('周边POI: ${poi.title}');
});
```

#### 周边搜索

```dart
final result = await TencentSearcherPlugin.instance
    .searchWithPoiExploreSearchOption(
  TmPoiExploreSearchOption(
    location: TmLatLng(latitude: 39.908692, longitude: 116.397477),
    radius: 1000,              // 搜索半径，米
    orderbyDistance: true,     // 按距离排序
    pageSize: 10,
    pageIndex: 1,
  ),
);

result?.forEach((poi) {
  print('${poi.title} — ${poi.address}');
});
```

---

## 📊 地图配置项

| 配置项 | 类型 | 说明 |
| ------ | ---- | ---- |
| `mapType` | `TmType` | 地图类型：`standard` / `satellite` / `dark` / `immersiveMap3D` |
| `mapStyle` | `int?` | 自定义底图样式序号（控制台配置） |
| `centerLatLng` | `TmLatLng?` | 中心点经纬度 |
| `showsUserLocation` | `bool?` | 是否显示用户定位图标 |
| `showsScale` | `bool?` | 是否显示比例尺 |
| `showsBuildings` | `bool?` | 是否显示建筑物 |
| `shows3DBuildings` | `bool?` | 建筑物是否以 3D 效果显示 |
| `showsPoi` | `bool?` | 是否显示底图标注 |
| `showsBaseMap` | `bool?` | 是否显示底图 |
| `showsCompass` | `bool?` | 是否显示指南针 |
| `labelSize` | `TmLabelSize?` | 标注字体大小，五档：`tiny` / `small` / `normal` / `large` / `huge` |
| `zoomLevel` | `double?` | 缩放级别 |
| `minZoomLevel` | `double?` | 最小缩放级别（默认 3） |
| `maxZoomLevel` | `double?` | 最大缩放级别（默认 20） |
| `zoomEnabled` | `bool?` | 是否允许手势缩放 |
| `keepCenterDuringZoom` | `bool?` | 缩放时是否保持地图中心 |
| `scrollEnabled` | `bool?` | 是否允许手势移动地图 |
| `overlookingEnabled` | `bool?` | 是否支持俯视 |
| `rotateEnabled` | `bool?` | 是否支持旋转 |
| `preferredFramesPerSecond` | `int?` | 最大渲染帧率（默认 60） |
| `logoCenter` | `TmPoint?` | Logo 位置 |
| `logoScale` | `double?` | Logo 缩放比例（0.7 ~ 1.3） |

---

## 📦 检索结果数据模型

#### TmSearcherPoi（检索 POI）

```dart
class TmSearcherPoi {
  String? id;          // POI 唯一标识
  TmLatLng? location;  // 坐标
  String? title;       // 名称
  String? address;     // 详细地址
  num? adcode;         // 行政区划代码
  String? province;    // 省
  String? city;        // 市
  String? district;    // 区/县
}
```

#### TmGeoCodeSearchResult（地理编码结果）

```dart
class TmGeoCodeSearchResult {
  TmLatLng? location;                 // 解析到的坐标
  TmAddressComponent? addressComponents;  // 地址部件
}

class TmAddressComponent {
  String? nation;        // 国家
  String? province;      // 省
  String? city;          // 市
  String? district;      // 区
  String? street;        // 街道
  String? streetNumber;  // 门牌号
}
```

#### TmReverseGeoCodeSearchResult（逆地理编码结果）

```dart
class TmReverseGeoCodeSearchResult {
  String? address;                          // 地址描述
  TmAddressComponent? addressComponents;    // 地址部件
  List<TmSearcherPoi>? poisArray;          // 周边 POI 列表
  int? poiCount;                            // POI 总数
}
```

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
