import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tencent_map_sdk/tencent_map_sdk.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  TencentMapController? mapController;
  List<TmClusterInfo> clusterList = [];

  @override
  void initState() {
    super.initState();
  }

  /// MapView 创建完成
  void _onMapViewCreated(TencentMapController controller) {
    mapController = controller;
    _addMapControllerDelegate();
  }

  /// Map 回调
  void _addMapControllerDelegate() {
    mapController?.setMapViewAuthenticationDidComplete(callback: (error) {
      if (error != null) {
        print("地图鉴权失败: ${error.code} - ${error.message}");
      } else {
        print("地图鉴权成功");
      }
    });

    mapController?.setMapViewFirstRenderDidComplete(callback: () {
      print("地图加载完成");
    });

    mapController?.setMapViewRegionDidChangeComplete(
        callback: (latLng, gesture) {
      print(latLng.latitude);
      print(gesture);
      if (Platform.isIOS) mapController?.refreshCluster();
    });

    mapController?.setUserLocationChangedComplete(callback: (latLng) {
      print(latLng.latitude);
    });

    mapController?.setMapViewDidTapAtLatLngComplete(callback: (latLng) async {
      print(latLng.latitude);
      TmPoint? point = await mapController?.convertCoordinateToPoint(latLng);
      print(point?.x);
    });

    mapController?.setMapViewDidTapAtPoiComplete(callback: (poi) {
      print(poi.name);
    });

    mapController?.setMapViewDidTapAtClusterComplete(callback: (cluster) {
      print(cluster.latLng?.longitude);
      cluster.items?.forEach((item) {
        print(item.custom);
      });
    });

    mapController?.setMapViewDidTapAtClusterItemComplete(callback: (info) {
      print(info.custom);
    });
  }

  /// 权限申请
  void _requestLocationAuthorization() {
    TencentMapPlugin.instance.requestLocationAuthorization();
  }

  /// 设置地图中心
  void _setCenterLatLng() {
    mapController?.setCenterLatLng(
        TmLatLng(latitude: 39.908692, longitude: 116.397477),
        animated: true);
  }

  /// 添加点聚合
  void _addCluster() {
    List dataList = _getLatLngData();
    clusterList = [];
    for (int i = 0; i < dataList.length; i++) {
      var item = dataList[i];
      clusterList.add(TmClusterInfo(
        latLng: TmLatLng(longitude: item[0], latitude: item[1]),
        title: '测试数据',
        custom: {"customerName": "客户姓名", 'customerId': '$i'},
        customId: '$i',
      ));
    }
    mapController?.setClusterMaxDistance(100.0);
    mapController?.setClusterCoordinates(clusterList);
  }

  /// 清除点聚合
  void _clearCluster() {
    mapController?.clearClusterCoordinates();
  }

  /// point转经纬度
  void _convertPointToCoordinate() async {
    TmLatLng? latLng =
        await mapController?.convertPointToCoordinate(TmPoint(x: 100, y: 100));
    print(latLng?.longitude);
  }

  /// 经纬度转point
  void _convertCoordinateToPoint() async {
    TmPoint? point = await mapController?.convertCoordinateToPoint(
        TmLatLng(latitude: 39.908692, longitude: 116.397477));
    print(point?.x);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('腾讯地图插件'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildMapView(),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _requestLocationAuthorization,
                  child: const Text(
                    '权限申请',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _setCenterLatLng,
                  child: const Text(
                    '设置地图中心',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addCluster,
                  child: const Text(
                    '添加点聚合',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _clearCluster,
                  child: const Text(
                    '清除点聚合',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _convertPointToCoordinate,
                  child: const Text(
                    'point转经纬度',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _convertCoordinateToPoint,
                  child: const Text(
                    '经纬度转point',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// MapView
  Widget _buildMapView() {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return SizedBox(
      width: mediaQuery.size.width,
      height: 400,
      child: TencentMapView(
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

  /// 测试数据
  List _getLatLngData() => [
        [116.307621, 39.984059],
        [116.304703, 39.981954],
        [116.312256, 39.984355],
        [116.315346, 39.980442],
        [116.308994, 39.981527],
        [116.310539, 39.979751],
        [116.305776, 39.977252],
        [116.316419, 39.984026],
        [116.314874, 39.976956],
        [116.311827, 39.978501],
        [116.312814, 39.980277],
        [116.369022, 39.980236],
        [116.368486, 39.980236],
        [116.367488, 39.977161],
        [116.396713, 39.915398],
        [116.455421, 39.937645],
        [116.321182, 39.896304],
        [121.452827, 31.254487],
        [121.485443, 31.225133],
        [121.442528, 31.216912],
        [121.500893, 31.251552],
        [121.455917, 31.249204],
        [114.042892, 22.546885],
        [113.999805, 22.538086],
        [114.082031, 22.538086],
      ];

  @override
  void dispose() {
    super.dispose();
  }
}
