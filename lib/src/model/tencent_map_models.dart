part of '../../tencent_map_sdk.dart';

/// 地图类型
enum TmType {
  /// 常规地图
  standard,

  /// 卫星地图
  satellite,

  /// 暗色地图
  dark,

  /// D沉浸式地图
  immersiveMap3D,
}

enum TmLabelSize {
  /// 特小
  tiny,

  /// 小
  small,

  /// 标准
  normal,

  /// 大
  large,

  /// 特大
  huge,
}

class TmLatLng {
  num? longitude;
  num? latitude;

  TmLatLng({
    this.longitude,
    this.latitude,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['longitude'] = longitude;
    map['latitude'] = latitude;
    return map;
  }

  TmLatLng.fromMap(Map map) {
    longitude = map['longitude'];
    latitude = map['latitude'];
  }
}

class TmPoint {
  num? x;
  num? y;

  TmPoint({
    this.x,
    this.y,
  });

  TmPoint.fromMap(Map map) {
    x = map['x'];
    y = map['y'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['x'] = x;
    map['y'] = y;
    return map;
  }
}

class TmSize {
  double? width;
  double? height;

  TmSize({
    this.width,
    this.height,
  });

  TmSize.fromMap(Map map) {
    width = map['width'];
    height = map['height'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['width'] = width;
    map['height'] = height;
    return map;
  }
}

/// 地图属性配置
class TmConfig {
  /// 地图类型， 默认常规地图
  TmType? mapType;

  /// 底图样式
  /// 值为在官网配置的自定义样式列表中的顺序, 从1开始
  int? mapStyle;

  /// 中心经纬度
  TmLatLng? centerLatLng;

  /// 开启定位并展示位置图标.
  bool? showsUserLocation;

  /// 是否显示比例尺，默认为YES
  bool? showsScale;

  /// 比例尺原点位置
  TmPoint? scaleOrigin;

  /// 是否显示建筑物，默认为YES
  bool? showsBuildings;

  /// 是否显示建筑物样式为3D效果，默认为YES
  bool? shows3DBuildings;

  /// 是否显示底图上的标注及名称，默认为YES
  bool? showsPoi;

  /// 底图上的标注的字体大小
  TmLabelSize? labelSize;

  /// 是否显示底图，默认为YES
  bool? showsBaseMap;

  /// 是否显示指南针，默认为NO
  bool? showsCompass;

  /// 设置指南针基于默认位置的偏移. 右下为正
  TmPoint? compassOffset;

  /// 当前地图最大渲染帧数，默认为60
  int? preferredFramesPerSecond;

  /// logo位置，需设置在地图的bounds里
  TmPoint? logoCenter;

  /// Logo大小. 基于原始大小的比例值, 默认为1.0. 有效区间[0.7, 1.3]
  double? logoScale;

  /// 缩放级别
  double? zoomLevel;

  /// 最小缩放级别, 默认 minZoomLevel = 3
  double? minZoomLevel;

  /// 最大缩放级别, 默认 maxZoomLevel = 20
  double? maxZoomLevel;

  /// 设定地图View能否支持用户多点缩放, 默认为YES.
  bool? zoomEnabled;

  /// 以地图中心为中心, 默认为NO（即以手势为中心）
  bool? keepCenterDuringZoom;

  /// 设定地图View能否支持用户移动地图, 默认为YES.
  bool? scrollEnabled;

  /// 是否支持俯视. 默认为YES.
  bool? overlookingEnabled;

  /// 是否支持旋转. 默认为YES.
  bool? rotateEnabled;

  /// 当地图被单击时，是否总是触发 "地图点击回调"，默认为NO.
  /// 当设置为NO时：只有当点击到地图空白处(即未点击到 Annotation, POI，Polyline，Polygon，定位标) 才会触发回调。
  ///  当设置为YES时：只要点击到地图（未点击到 Annotation），就会触发回调。
  bool? alwaysTriggerDidTapCoordinateEnabled;

  TmConfig({
    this.mapType,
    this.mapStyle,
    this.centerLatLng,
    this.showsUserLocation,
    this.showsScale,
    this.showsBuildings,
    this.shows3DBuildings,
    this.showsPoi,
    this.labelSize,
    this.showsBaseMap,
    this.showsCompass,
    this.compassOffset,
    this.preferredFramesPerSecond,
    this.logoCenter,
    this.logoScale,
    this.scaleOrigin,
    this.zoomLevel,
    this.minZoomLevel,
    this.maxZoomLevel,
    this.zoomEnabled,
    this.keepCenterDuringZoom,
    this.scrollEnabled,
    this.overlookingEnabled,
    this.rotateEnabled,
    this.alwaysTriggerDidTapCoordinateEnabled,
  });

  TmConfig._default() {
    mapType = TmType.satellite;
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['mapType'] = mapType?.index;
    map['mapStyle'] = mapStyle;
    map['centerLatLng'] = centerLatLng?.toMap();
    map['showsUserLocation'] = showsUserLocation;
    map['showsScale'] = showsScale;
    map['showsBuildings'] = showsBuildings;
    map['shows3DBuildings'] = shows3DBuildings;
    map['showsPoi'] = showsPoi;
    map['labelSize'] = labelSize?.index;
    map['showsBaseMap'] = showsBaseMap;
    map['showsCompass'] = showsCompass;
    map['compassOffset'] = compassOffset?.toMap();
    map['preferredFramesPerSecond'] = preferredFramesPerSecond;
    map['logoCenter'] = logoCenter?.toMap();
    map['logoScale'] = logoScale;
    map['scaleOrigin'] = scaleOrigin?.toMap();
    map['zoomLevel'] = zoomLevel;
    map['minZoomLevel'] = minZoomLevel;
    map['maxZoomLevel'] = maxZoomLevel;
    map['zoomEnabled'] = zoomEnabled;
    map['keepCenterDuringZoom'] = keepCenterDuringZoom;
    map['scrollEnabled'] = scrollEnabled;
    map['overlookingEnabled'] = overlookingEnabled;
    map['rotateEnabled'] = rotateEnabled;
    map['alwaysTriggerDidTapCoordinateEnabled'] =
        alwaysTriggerDidTapCoordinateEnabled;
    return map;
  }

  TmConfig.fromMap(Map map) {
    mapType =
        map['mapType'] is int ? TmType.values.elementAt(map['mapType']) : null;
    mapStyle = map['mapStyle'];
    if (map['centerLatLng'] != null) {
      centerLatLng = TmLatLng.fromMap(map['centerLatLng']);
    }
    showsUserLocation = map['showsUserLocation'];
    showsScale = map['showsScale'];
    showsBuildings = map['showsBuildings'];
    shows3DBuildings = map['shows3DBuildings'];
    showsPoi = map['showsPoi'];
    labelSize = map['labelSize'] is int
        ? TmLabelSize.values.elementAt(map['labelSize'])
        : null;
    showsBaseMap = map['showsBaseMap'];
    showsCompass = map['showsCompass'];
    if (map['compassOffset'] != null) {
      compassOffset = TmPoint.fromMap(map['compassOffset']);
    }
    preferredFramesPerSecond = map['preferredFramesPerSecond'];
    if (map['logoCenter'] != null) {
      logoCenter = TmPoint.fromMap(map['logoCenter']);
    }
    logoScale = map['logoScale'];
    if (map['scaleOrigin'] != null) {
      scaleOrigin = TmPoint.fromMap(map['scaleOrigin']);
    }
    zoomLevel = map['zoomLevel'];
    minZoomLevel = map['minZoomLevel'];
    maxZoomLevel = map['maxZoomLevel'];
    zoomEnabled = map['zoomEnabled'];
    keepCenterDuringZoom = map['keepCenterDuringZoom'];
    scrollEnabled = map['scrollEnabled'];
    overlookingEnabled = map['overlookingEnabled'];
    rotateEnabled = map['rotateEnabled'];
    alwaysTriggerDidTapCoordinateEnabled =
        map['alwaysTriggerDidTapCoordinateEnabled'];
  }
}

/// 点聚合
class TmClusterAnnotation {
  TmLatLng? latLng;
  List<TmClusterInfo>? items;

  TmClusterAnnotation({
    this.latLng,
    this.items,
  });

  TmClusterAnnotation.fromMap(Map map) {
    if (map['latLng'] != null) {
      latLng = TmLatLng.fromMap(map['latLng']);
    }
    if (map['items'] != null) {
      items = [];
      map['items'].forEach((v) {
        items?.add(TmClusterInfo.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['latLng'] = latLng?.toMap();
    if (items != null) {
      map['items'] = items?.map((v) => v.toMap()).toList();
    }
    return map;
  }
}

/// 单个聚合点
class TmClusterInfo {
  TmLatLng? latLng;
  String? title;
  String? customId;
  Map<String, dynamic>? custom;

  TmClusterInfo({
    this.latLng,
    this.title,
    this.customId,
    this.custom,
  });

  TmClusterInfo.fromMap(Map map) {
    if (map['latLng'] != null) {
      latLng = TmLatLng.fromMap(map['latLng']);
    }
    title = map['title'];
    customId = map['customId'];
    if (map['custom'] is Map) {
      custom = Map<String, dynamic>.from(map['custom']);
    }
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['latLng'] = latLng?.toMap();
    map['title'] = title;
    map['customId'] = customId;
    map['custom'] = custom;
    return map;
  }
}

/// Poi
class TmPoiInfo {
  TmLatLng? latLng;
  String? uid;
  String? name;

  TmPoiInfo({
    this.latLng,
    this.uid,
    this.name,
  });

  TmPoiInfo.fromMap(Map map) {
    if (map['latLng'] != null) {
      latLng = TmLatLng.fromMap(map['latLng']);
    }
    uid = map['uid'];
    name = map['name'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['latLng'] = latLng?.toMap();
    map['uid'] = uid;
    map['name'] = name;
    return map;
  }
}

/// 错误信息
class TmError {
  num? code;
  String? message;

  TmError({
    this.code,
    this.message,
  });

  TmError.fromMap(Map map) {
    code = map['code'];
    message = map['message'];
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['code'] = code;
    map['message'] = message;
    return map;
  }
}
