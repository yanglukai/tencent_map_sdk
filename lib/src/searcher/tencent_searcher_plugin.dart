part of '../../tencent_map_sdk.dart';

class TencentSearcherPlugin {
  final MethodChannel _channel = const MethodChannel(
      "eplbks.tencent_searcher_plugin", StandardMethodCodec(TencentMapCodec()));

  TencentSearcherPlugin._internal() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  /// 配置开发秘钥, 启用检索功能
  Future<void> setApiKey(String apiKey, String secretKey) =>
      TencentMapDispatcherFactory.instance.searcherDispatcher
          .setApiKey(_channel, apiKey, secretKey);

  /// 关键字提示检索
  Future<List<TmSearcherPoi>?> searchWithSuggestionSearchOption(
          TmSuggestionSearcherOption option) =>
      TencentMapDispatcherFactory.instance.searcherDispatcher
          .searchWithSuggestionSearchOption(_channel, option);

  /// 全国行政区域检索
  Future<List<List<TmDistrictData>>?> searchWithDistrictList() =>
      TencentMapDispatcherFactory.instance.searcherDispatcher
          .searchWithDistrictList(_channel);

  /// 地址解析
  Future<TmGeoCodeSearchResult?> searchWithGeoCodeSearchOption(
          TmGeoCodeSearchOption option) =>
      TencentMapDispatcherFactory.instance.searcherDispatcher
          .searchWithGeoCodeSearchOption(_channel, option);

  /// 逆地址解析
  Future<TmReverseGeoCodeSearchResult?> searchWithReverseGeoCodeSearchOption(
          TmReverseGeoCodeSearchOption option) =>
      TencentMapDispatcherFactory.instance.searcherDispatcher
          .searchWithReverseGeoCodeSearchOption(_channel, option);

  /// 周边搜索
  Future<List<TmSearcherPoi>?> searchWithPoiExploreSearchOption(
          TmPoiExploreSearchOption option) =>
      TencentMapDispatcherFactory.instance.searcherDispatcher
          .searchWithPoiExploreSearchOption(_channel, option);

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case '':
        break;
      default:
        throw MissingPluginException();
    }
  }

  factory TencentSearcherPlugin() => _getInstance();
  static TencentSearcherPlugin? _instance;
  static TencentSearcherPlugin get instance => _getInstance();
  static TencentSearcherPlugin _getInstance() {
    _instance ??= TencentSearcherPlugin._internal();
    return _instance!;
  }
}
