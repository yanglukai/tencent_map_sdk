import 'package:flutter/material.dart';
import 'package:tencent_map_sdk/tencent_map_sdk.dart';

class SearcherPage extends StatefulWidget {
  const SearcherPage({super.key});

  @override
  State<SearcherPage> createState() => _SearcherPageState();
}

class _SearcherPageState extends State<SearcherPage> {
  /// 关键字提示检索
  void _searchWithSuggestion() async {
    final result =
        await TencentSearcherPlugin.instance.searchWithSuggestionSearchOption(
      TmSuggestionSearcherOption(
        keyword: '北京',
        region: '北京',
      ),
    );
    result?.forEach((element) {
      print(element.title);
    });
  }

  /// 全国行政区域检索
  void _searchWithDistrictList() async {
    final result =
        await TencentSearcherPlugin.instance.searchWithDistrictList();
    print(result?.runtimeType);
    result?[1].forEach((item) {
      print(item.fullName);
    });
  }

  /// 地址解析
  void _searchWithGeoCode() async {
    final result = await TencentSearcherPlugin.instance
        .searchWithGeoCodeSearchOption(
            TmGeoCodeSearchOption(address: '北京市海淀区彩和坊路海淀西大街74号', region: '北京'));
    print(result?.location?.longitude);
  }

  /// 逆地址解析
  void _searchWithReverseGeoCode() async {
    final result = await TencentSearcherPlugin.instance
        .searchWithReverseGeoCodeSearchOption(
      TmReverseGeoCodeSearchOption(
        location: TmLatLng(latitude: 39.908692, longitude: 116.397477),
        getPoi: true,
      ),
    );
    print(result?.address);
    result?.poisArray?.forEach((poi) {
      print(poi.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('地理信息检索'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _searchWithSuggestion,
            child: const Text(
              '关键字提示检索',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _searchWithDistrictList,
            child: const Text(
              '全国行政区域检索',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _searchWithGeoCode,
            child: const Text(
              '地址解析',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _searchWithReverseGeoCode,
            child: const Text(
              '逆地址解析',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
