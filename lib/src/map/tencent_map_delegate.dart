part of '../../tencent_map_sdk.dart';

/// 地图无参数回调
typedef TmVoidCallback = void Function();

/// 地图鉴权回调
typedef TmAuthCallback = void Function(TmError?);

/// 地图区域改变回调
typedef TmRegionChangeCallback = void Function(TmLatLng, bool);

/// 经纬度回调
typedef TmLatLngCallback = void Function(TmLatLng);

/// Poi回调
typedef TmPoiCallback = void Function(TmPoiInfo);

/// 聚合点回调
typedef TmClusterCallback = void Function(TmClusterAnnotation);

/// 单个聚合点回调
typedef TmClusterItemCallback = void Function(TmClusterInfo);

class TencentMapDelegate {

  /// 鸿蒙地图准备完毕
  TmVoidCallback? _mapViewOnReadyComplete;

  /// 地图鉴权回调
  TmAuthCallback? mapViewAuthenticationDidComplete;

  /// 加载完成回调
  TmVoidCallback? mapViewFirstRenderDidComplete;

  /// 地图区域改变完成
  TmRegionChangeCallback? mapViewRegionDidChangeComplete;

  /// 用户定位回调
  TmLatLngCallback? userLocationChangedComplete;

  /// 点击地图空白处
  TmLatLngCallback? mapViewDidTapAtLatLngComplete;

  /// 点击地图poi图标
  TmPoiCallback? mapViewDidTapAtPoiComplete;

  /// 聚合点点击回调
  TmClusterCallback? mapViewDidTapAtClusterComplete;

  /// 单个聚合点回调
  TmClusterItemCallback? mapViewDidTapAtClusterItemComplete;

  /// native -> flutter
  dynamic handlerMethod(MethodCall call) async {
    switch (call.method) {
      case "mapViewAuthenticationDidComplete":
        if (call.arguments is TmError) {
          mapViewAuthenticationDidComplete?.call(call.arguments);
        } else {
          mapViewAuthenticationDidComplete?.call(null);
        }
      case "mapViewFirstRenderDidComplete":
        _mapViewOnReadyComplete?.call();
        mapViewFirstRenderDidComplete?.call();
      case "mapViewRegionDidChangeComplete":
        var latLng = call.arguments['latLng'];
        var gesture = call.arguments['gesture'];
        if (latLng is TmLatLng && gesture is bool) {
          mapViewRegionDidChangeComplete?.call(latLng, gesture);
        }
      case "userLocationChangedComplete":
        if (call.arguments is TmLatLng) {
          userLocationChangedComplete?.call(call.arguments);
        }
      case "mapViewDidTapAtLatLngComplete":
        if (call.arguments is TmLatLng) {
          mapViewDidTapAtLatLngComplete?.call(call.arguments);
        }
      case "mapViewDidTapAtPoiComplete":
        if (call.arguments is TmPoiInfo) {
          mapViewDidTapAtPoiComplete?.call(call.arguments);
        }
      case "mapViewDidTapAtClusterComplete":
        if (call.arguments is TmClusterAnnotation) {
          mapViewDidTapAtClusterComplete?.call(call.arguments);
        }
      case "mapViewDidTapAtClusterItemComplete":
        if (call.arguments is TmClusterInfo) {
          mapViewDidTapAtClusterItemComplete?.call(call.arguments);
        }
      default:
        throw MissingPluginException();
    }
  }
}
