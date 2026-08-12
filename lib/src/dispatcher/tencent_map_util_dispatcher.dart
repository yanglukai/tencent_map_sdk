part of '../../tencent_map_sdk.dart';

class TencentMapUtilDispatcher {
  /// 将经纬度坐标转换为View坐标
  Future<TmPoint?> convertCoordinateToPoint(
      MethodChannel mapChannel, TmLatLng latLng) async {
    try {
      return mapChannel.invokeMethod(
          "TencentMapUtil_convertCoordinateToPoint", latLng);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// 将View坐标转换成经纬度坐标
  Future<TmLatLng?> convertPointToCoordinate(
      MethodChannel mapChannel, TmPoint point) async {
    try {
      return mapChannel.invokeMethod(
          "TencentMapUtil_convertPointToCoordinate", point);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
