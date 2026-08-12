part of '../../tencent_map_sdk.dart';

class TencentMapController {
  late MethodChannel _channel;
  late TencentMapDelegate _delegate;

  TencentMapController.initChannel(int viewId) {
    _channel = MethodChannel(
      "eplbks.tencent_map_controller_$viewId",
      const StandardMethodCodec(TencentMapCodec()),
    );
    _channel.setMethodCallHandler(_handleMethodCall);
    _delegate = TencentMapDelegate();
  }

  Future<dynamic> _handleMethodCall(MethodCall call) =>
      _delegate.handlerMethod(call);
}

/// 地图显示相关操作
extension MapExtension on TencentMapController {
  /// 更新地图属性
  Future<void> updateMapConfig(TmConfig config) =>
      TencentMapDispatcherFactory.instance.mapBasicDispatcher
          .updateMapConfig(_channel, config);

  /// 获取缩放级别
  Future<double?> getZoomLevel() =>
      TencentMapDispatcherFactory.instance.mapBasicDispatcher
          .getZoomLevel(_channel);

  /// 设置缩放等级
  Future<bool> setZoomLevel(double level, {bool animated = false}) =>
      TencentMapDispatcherFactory.instance.mapBasicDispatcher
          .setZoomLevel(_channel, level, animated: animated);

  /// 在当前基础上修改缩放等级 change 可以为负数
  Future<bool> changeZoomLevel(double change, {bool animated = false}) =>
      TencentMapDispatcherFactory.instance.mapBasicDispatcher
          .changeZoomLevel(_channel, change, animated: animated);

  /// 设置地图中心点
  Future<void> setCenterLatLng(TmLatLng latLng, {bool animated = false}) =>
      TencentMapDispatcherFactory.instance.mapBasicDispatcher
          .setCenterLatLng(_channel, latLng, animated: animated);
}

/// 点聚合
extension MapClusterExtension on TencentMapController {
  /// 聚合点距离
  Future<void> setClusterMaxDistance(double distance) =>
      TencentMapDispatcherFactory.instance.mapClusterDispatcher
          .setClusterMaxDistance(_channel, distance);

  /// 添加批量的原始被聚合点
  Future<void> setClusterCoordinates(List<TmClusterInfo> clusters) =>
      TencentMapDispatcherFactory.instance.mapClusterDispatcher
          .setClusterCoordinates(_channel, clusters);

  /// 移除所有的原始被聚合点
  Future<void> clearClusterCoordinates() =>
      TencentMapDispatcherFactory.instance.mapClusterDispatcher
          .clearClusterCoordinates(_channel);

  /// 刷新聚合点状态
  Future<void> refreshCluster() =>
      TencentMapDispatcherFactory.instance.mapClusterDispatcher
          .refreshCluster(_channel);
}

/// 地图工具
extension MapUtilExtension on TencentMapController {
  /// 将经纬度坐标转换为View坐标
  Future<TmPoint?> convertCoordinateToPoint(TmLatLng latLng) =>
      TencentMapDispatcherFactory.instance.mapUtilDispatcher
          .convertCoordinateToPoint(_channel, latLng);

  /// 将View坐标转换成经纬度坐标
  Future<TmLatLng?> convertPointToCoordinate(TmPoint point) =>
      TencentMapDispatcherFactory.instance.mapUtilDispatcher
          .convertPointToCoordinate(_channel, point);
}

/// 地图相关回调
extension MapCallbackExtension on TencentMapController {
  /// 地图鉴权回调
  void setMapViewAuthenticationDidComplete(
          {required TmAuthCallback callback}) =>
      _delegate.mapViewAuthenticationDidComplete = callback;

  /// 设置地图加载完成回调
  void setMapViewFirstRenderDidComplete({required TmVoidCallback callback}) =>
      _delegate.mapViewFirstRenderDidComplete = callback;

  /// 地图区域改变完成
  void setMapViewRegionDidChangeComplete(
          {required TmRegionChangeCallback callback}) =>
      _delegate.mapViewRegionDidChangeComplete = callback;

  /// 用户定位回调（showsUserLocation = true时才有效）
  void setUserLocationChangedComplete({required TmLatLngCallback callback}) =>
      _delegate.userLocationChangedComplete = callback;

  /// 点击地图空白处回调
  void setMapViewDidTapAtLatLngComplete({required TmLatLngCallback callback}) =>
      _delegate.mapViewDidTapAtLatLngComplete = callback;

  /// 点击地图poi图标
  void setMapViewDidTapAtPoiComplete({required TmPoiCallback callback}) =>
      _delegate.mapViewDidTapAtPoiComplete = callback;

  /// 聚合点点击回调
  void setMapViewDidTapAtClusterComplete(
          {required TmClusterCallback callback}) =>
      _delegate.mapViewDidTapAtClusterComplete = callback;

  /// 单个聚合点点击回调
  void setMapViewDidTapAtClusterItemComplete(
          {required TmClusterItemCallback callback}) =>
      _delegate.mapViewDidTapAtClusterItemComplete = callback;
}

/// 生命周期
extension _LifecycleExtension on TencentMapController {
  Future<void> _resumed() =>
      TencentMapDispatcherFactory.instance.mapLifecycleDispatcher
          ._resumed(_channel);
  Future<void> _paused() =>
      TencentMapDispatcherFactory.instance.mapLifecycleDispatcher
          ._paused(_channel);
  Future<void> _detached() =>
      TencentMapDispatcherFactory.instance.mapLifecycleDispatcher
          ._detached(_channel);
}

/// 私有方法
extension _MapCallbackPrivate on TencentMapController {
  /// 鸿蒙地图准备完毕 ohos only
  void _setMapViewOnReadyComplete({required TmVoidCallback callback}) =>
      _delegate._mapViewOnReadyComplete = callback;
}
