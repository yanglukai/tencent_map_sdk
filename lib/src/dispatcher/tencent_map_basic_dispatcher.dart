part of '../../tencent_map_sdk.dart';

/// 地图相关操作
class TencentMapBasicDispatcher {
  /// 更新地图配置
  Future<void> updateMapConfig(
      MethodChannel mapChannel, TmConfig config) async {
    try {
      await mapChannel.invokeMethod("TencentMapBasic_updateMapConfig", config);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  /// 获取缩放级别
  Future<double?> getZoomLevel(MethodChannel mapChannel) async {
    try {
      return mapChannel.invokeMethod("TencentMapBasic_getZoomLevel");
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// 设置缩放等级
  Future<bool> setZoomLevel(MethodChannel mapChannel, double level,
      {bool animated = false}) async {
    bool res = false;
    try {
      res = await mapChannel.invokeMethod("TencentMapBasic_setZoomLevel", {
        'level': level,
        'animated': animated,
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  /// 在当前基础上修改缩放等级 change 可以为负数
  Future<bool> changeZoomLevel(MethodChannel mapChannel, double change,
      {bool animated = false}) async {
    bool res = false;
    try {
      res = await mapChannel.invokeMethod("TencentMapBasic_changeZoomLevel", {
        'change': change,
        'animated': animated,
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  /// 设置地图中心点
  Future<void> setCenterLatLng(MethodChannel mapChannel, TmLatLng latLng,
      {bool animated = false}) async {
    try {
      await mapChannel.invokeMethod("TencentMapBasic_setCenterLatLng", {
        'latLng': latLng,
        'animated': animated,
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }
}
