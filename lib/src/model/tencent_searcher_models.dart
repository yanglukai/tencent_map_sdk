part of '../../tencent_map_sdk.dart';

/// 关键词输入提示参数
class TmSuggestionSearcherOption {
  /// 必填,检索关键字
  String? keyword;

  /// 必填,设置城市名，限制关键词所示的地域范围，如，仅获取“广州市”范围内的提示内容	比如:region=广州
  String? region;

  /// 定位坐标，传入后，若用户搜索关键词为类别词（如酒店、餐馆时），与此坐标距离近的地点将靠前显示
  TmLatLng? location;

  /// 检索分页索引
  int? pageIndex;

  /// 检索分页大小
  int? pageSize;

  TmSuggestionSearcherOption({
    required this.keyword,
    required this.region,
    this.location,
    this.pageIndex,
    this.pageSize,
  });

  TmSuggestionSearcherOption.fromMap(Map map) {
    keyword = map['keyword'];
    region = map['region'];
    if (map['location'] != null) {
      location = TmLatLng.fromMap(map['location']);
    }
    pageIndex = map['pageIndex'];
    pageSize = map['pageSize'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['keyword'] = keyword;
    map['region'] = region;
    map['location'] = location?.toMap();
    map['pageIndex'] = pageIndex;
    map['pageSize'] = pageSize;
    return map;
  }
}

/// 返回地址Poi
class TmSearcherPoi {
  /// POI唯一标识
  String? id;

  /// 定位坐标
  TmLatLng? location;

  /// POI名称
  String? title;

  /// 地址详细描述
  String? address;

  /// 行政区划代码
  num? adcode;

  /// 省份名称
  String? province;

  /// 城市名称
  String? city;

  /// 区县名称
  String? district;

  TmSearcherPoi({
    this.id,
    this.location,
    this.title,
    this.address,
    this.adcode,
    this.province,
    this.city,
    this.district,
  });

  TmSearcherPoi.fromMap(Map map) {
    id = map['id'];
    if (map['location'] != null) {
      location = TmLatLng.fromMap(map['location']);
    }
    title = map['title'];
    address = map['address'];
    adcode = map['adcode'];
    province = map['province'];
    city = map['city'];
    district = map['district'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['location'] = location?.toMap();
    map['title'] = title;
    map['address'] = address;
    map['adcode'] = adcode;
    map['province'] = province;
    map['city'] = city;
    map['district'] = district;
    return map;
  }
}

/// 行政区划信息返回结果
class TmDistrictData {
  /// 行政区划唯一标识
  String? id;

  /// 简称，如“内蒙古”
  String? name;

  /// 全称，如“内蒙古自治区”
  String? fullName;

  /// 中心点坐标
  TmLatLng? location;

  /// 行政区划拼音，每一下标为一个字的全拼，如：["nei","meng","gu"]
  List<String>? pinyin;

  TmDistrictData({
    this.id,
    this.name,
    this.fullName,
    this.location,
    this.pinyin,
  });

  TmDistrictData.fromMap(Map map) {
    id = map['id'];
    name = map['name'];
    fullName = map['fullName'];
    if (map['location'] != null) {
      location = TmLatLng.fromMap(map['location']);
    }
    pinyin = map['pinyin']?.cast<String>();
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['fullName'] = fullName;
    map['location'] = location?.toMap();
    map['pinyin'] = pinyin;
    return map;
  }
}

/// 地址解析接口参数
class TmGeoCodeSearchOption {
  /// 必填，用于做地理编码的地址, 如:address=北京市海淀区彩和坊路海淀西大街74号
  String? address;

  /// 指定地址所属城市, 如：region=北京
  String? region;

  TmGeoCodeSearchOption({
    required this.address,
    required this.region,
  });

  TmGeoCodeSearchOption.fromMap(Map map) {
    address = map['address'];
    region = map['region'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['region'] = region;
    return map;
  }
}

/// 解析后的地址部件
class TmAddressComponent {
  /// 国家
  String? nation;

  /// 省
  String? province;

  /// 市
  String? city;

  /// 区(可能为空)
  String? district;

  /// 街道(可能为空)
  String? street;

  /// 门牌(可能为空)
  String? streetNumber;

  TmAddressComponent({
    this.nation,
    this.province,
    this.city,
    this.district,
    this.street,
    this.streetNumber,
  });

  TmAddressComponent.fromMap(Map map) {
    nation = map['nation'];
    province = map['province'];
    city = map['city'];
    district = map['district'];
    street = map['street'];
    streetNumber = map['streetNumber'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['nation'] = nation;
    map['province'] = province;
    map['city'] = city;
    map['district'] = district;
    map['street'] = street;
    map['streetNumber'] = streetNumber;
    return map;
  }
}

/// 地址解析检索结果
class TmGeoCodeSearchResult {
  /// 解析到的坐标(经纬度)
  TmLatLng? location;

  /// 解析后的地址部件
  TmAddressComponent? addressComponents;

  TmGeoCodeSearchResult({
    this.location,
    this.addressComponents,
  });

  TmGeoCodeSearchResult.fromMap(Map map) {
    if (map['location'] != null) {
      location = TmLatLng.fromMap(map['location']);
    }
    if (map['addressComponents'] != null) {
      addressComponents = TmAddressComponent.fromMap(map['addressComponents']);
    }
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['location'] = location?.toMap();
    map['addressComponents'] = addressComponents?.toMap();
    return map;
  }
}

/// 逆地址解析接口参数
class TmReverseGeoCodeSearchOption {
  /// 位置坐标
  TmLatLng? location;

  /// 是否返回周边POI列表 默认不返回
  bool? getPoi;

  TmReverseGeoCodeSearchOption({
    required this.location,
    this.getPoi,
  });

  TmReverseGeoCodeSearchOption.fromMap(Map map) {
    if (map['location'] != null) {
      location = TmLatLng.fromMap(map['location']);
    }
    getPoi = map['getPoi'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['location'] = location?.toMap();
    map['getPoi'] = getPoi;
    return map;
  }
}

/// 逆地址检索结果
class TmReverseGeoCodeSearchResult {
  /// 地址详细描述
  String? address;

  /// 地址部件，address不满足需求时可自行拼接
  TmAddressComponent? addressComponents;

  /// POI数组，对象中每个子项为一个POI(TmSearcherPoi)对象
  List<TmSearcherPoi>? poisArray;

  /// 查询的周边poi的总数
  int? poiCount;

  TmReverseGeoCodeSearchResult({
    this.address,
    this.addressComponents,
    this.poisArray,
    this.poiCount,
  });

  TmReverseGeoCodeSearchResult.fromMap(Map map) {
    address = map['address'];
    if (map['addressComponents'] != null) {
      addressComponents = TmAddressComponent.fromMap(map['addressComponents']);
    }
    if (map['poisArray'] != null) {
      poisArray = [];
      map['poisArray'].forEach((v) {
        poisArray?.add(TmSearcherPoi.fromMap(v));
      });
    }
    poiCount = map['poiCount'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['addressComponents'] = addressComponents?.toMap();
    if (poisArray != null) {
      map['poisArray'] = poisArray?.map((v) => v.toMap()).toList();
    }
    map['poiCount'] = poiCount;
    return map;
  }
}

/// 周边Poi搜索接口参数
class TmPoiExploreSearchOption {
  /// 中心坐标
  TmLatLng? location;

  /// 搜索半径/米
  int? radius;

  /// 当前范围无结果时，是否自动扩大范围。
  bool? autoExtend;

  /// 1 [默认]地点签到场景，针对用户签到的热门 地点进行优先排序。
  ///  2 位置共享场景，用于发送位置、位置分享等场景的热门地点优先排序
  int? policy;

  /// 设置排序方式,是否根据距离排序
  bool? orderbyDistance;

  /// 每页条目数，最大限制为20条。 默认10条
  int? pageSize;

  /// 第x页，默认第1页
  int? pageIndex;

  TmPoiExploreSearchOption({
    this.location,
    this.radius,
    this.autoExtend,
    this.policy,
    this.orderbyDistance,
    this.pageSize,
    this.pageIndex,
  });

  TmPoiExploreSearchOption.fromMap(Map map) {
    if (map['location'] != null) {
      location = TmLatLng.fromMap(map['location']);
    }
    radius = map['radius'];
    autoExtend = map['autoExtend'];
    policy = map['policy'];
    orderbyDistance = map['orderbyDistance'];
    pageSize = map['pageSize'];
    pageIndex = map['pageIndex'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['location'] = location?.toMap();
    map['radius'] = radius;
    map['autoExtend'] = autoExtend;
    map['policy'] = policy;
    map['orderbyDistance'] = orderbyDistance;
    map['pageSize'] = pageSize;
    map['pageIndex'] = pageIndex;
    return map;
  }
}
