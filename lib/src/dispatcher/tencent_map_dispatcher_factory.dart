part of '../../tencent_map_sdk.dart';

/// 工厂模式
class TencentMapDispatcherFactory {
  /// 地图显示
  late TencentMapBasicDispatcher _mapBasicDispatcher;

  /// 点聚合
  late TencentMapClusterDispatcher _mapClusterDispatcher;

  /// 生命周期
  late TencentMapLifecycleDispatcher _mapLifecycleDispatcher;

  /// 地理信息检索
  late TencentSearcherDispatcher _searcherDispatcher;

  /// 地图工具
  late TencentMapUtilDispatcher _mapUtilDispatcher;

  TencentMapDispatcherFactory._internal() {
    _mapBasicDispatcher = TencentMapBasicDispatcher();
    _mapClusterDispatcher = TencentMapClusterDispatcher();
    _mapLifecycleDispatcher = TencentMapLifecycleDispatcher();
    _searcherDispatcher = TencentSearcherDispatcher();
    _mapUtilDispatcher = TencentMapUtilDispatcher();
  }

  /// 地图显示
  TencentMapBasicDispatcher get mapBasicDispatcher => _mapBasicDispatcher;

  /// 点聚合
  TencentMapClusterDispatcher get mapClusterDispatcher => _mapClusterDispatcher;

  /// 生命周期
  TencentMapLifecycleDispatcher get mapLifecycleDispatcher =>
      _mapLifecycleDispatcher;

  /// 地图工具
  TencentMapUtilDispatcher get mapUtilDispatcher => _mapUtilDispatcher;

  /// 地理信息检索
  TencentSearcherDispatcher get searcherDispatcher => _searcherDispatcher;

  factory TencentMapDispatcherFactory() => _getInstance();
  static TencentMapDispatcherFactory? _instance;
  static TencentMapDispatcherFactory get instance => _getInstance();
  static TencentMapDispatcherFactory _getInstance() {
    _instance ??= TencentMapDispatcherFactory._internal();
    return _instance!;
  }
}
