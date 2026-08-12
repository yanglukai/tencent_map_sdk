part of '../../tencent_map_sdk.dart';

class TencentSearcherDispatcher {
  /// 配置开发秘钥, 启用检索功能
  Future<void> setApiKey(
      MethodChannel searcherChannel, String apiKey, String secretKey) async {
    if (Platform.operatingSystem == 'ohos') return;
    try {
      await searcherChannel.invokeMethod(
          'setApiKey', {"apiKey": apiKey, "secretKey": secretKey});
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  /// 关键字提示检索
  Future<List<TmSearcherPoi>?> searchWithSuggestionSearchOption(
      MethodChannel searcherChannel, TmSuggestionSearcherOption option) async {
    if (Platform.operatingSystem == 'ohos') return null;
    try {
      final result = await searcherChannel.invokeMethod(
          "searchWithSuggestionSearchOption", option);
      return result?.cast<TmSearcherPoi>();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// 全国行政区域检索
  Future<List<List<TmDistrictData>>?> searchWithDistrictList(
      MethodChannel searcherChannel) async {
    if (Platform.operatingSystem == 'ohos') return null;
    try {
      final result =
          await searcherChannel.invokeMethod("searchWithDistrictList");
      final List<List<TmDistrictData>> list = [];
      if (result is List) {
        for (var element in result) {
          list.add(element.cast<TmDistrictData>());
        }
      }
      return list;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// 地址解析
  Future<TmGeoCodeSearchResult?> searchWithGeoCodeSearchOption(
      MethodChannel searcherChannel, TmGeoCodeSearchOption option) async {
    if (Platform.operatingSystem == 'ohos') return null;
    try {
      final result = await searcherChannel.invokeMethod(
          "searchWithGeoCodeSearchOption", option);
      return result;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// 逆地址解析
  Future<TmReverseGeoCodeSearchResult?> searchWithReverseGeoCodeSearchOption(
      MethodChannel searcherChannel,
      TmReverseGeoCodeSearchOption option) async {
    if (Platform.operatingSystem == 'ohos') return null;
    try {
      final result = await searcherChannel.invokeMethod(
          "searchWithReverseGeoCodeSearchOption", option);
      return result;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  /// 周边搜索
  Future<List<TmSearcherPoi>?> searchWithPoiExploreSearchOption(
      MethodChannel searcherChannel, TmPoiExploreSearchOption option) async {
    if (Platform.operatingSystem == 'ohos') return null;
    try {
      final result = await searcherChannel.invokeMethod(
          "searchWithPoiExploreSearchOption", option);
      return result?.cast<TmSearcherPoi>();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
