part of '../../tencent_map_sdk.dart';

class TencentMapClusterDispatcher {
  /// 设置点聚合距离
  Future<void> setClusterMaxDistance(
      MethodChannel mapChannel, double distance) async {
    try {
      await mapChannel.invokeMethod(
          "TencentMapCluster_setClusterMaxDistance", distance);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  /// 添加批量的原始被聚合点
  Future<void> setClusterCoordinates(
      MethodChannel mapChannel, List<TmClusterInfo> clusters) async {
    try {
      await mapChannel.invokeMethod(
          "TencentMapCluster_setClusterCoordinates", clusters);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  /// 移除所有的原始被聚合点
  Future<void> clearClusterCoordinates(MethodChannel mapChannel) async {
    try {
      await mapChannel
          .invokeMethod("TencentMapCluster_clearClusterCoordinates");
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  /// 刷新聚合点状态
  Future<void> refreshCluster(MethodChannel mapChannel) async {
    try {
      await mapChannel.invokeMethod("TencentMapCluster_refreshCluster");
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }
}
