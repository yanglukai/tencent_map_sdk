part of '../../tencent_map_sdk.dart';

class TencentMapCodec extends StandardMessageCodec {
  const TencentMapCodec();

  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is TmType) {
      buffer.putUint8(150);
      writeValue(buffer, value.index);
    } else if (value is TmConfig) {
      buffer.putUint8(151);
      writeValue(buffer, value.toMap());
    } else if (value is TmPoint) {
      buffer.putUint8(152);
      writeValue(buffer, value.toMap());
    } else if (value is TmLatLng) {
      buffer.putUint8(153);
      writeValue(buffer, value.toMap());
    } else if (value is TmClusterInfo) {
      buffer.putUint8(154);
      writeValue(buffer, value.toMap());
    } else if (value is TmPoiInfo) {
      buffer.putUint8(155);
      writeValue(buffer, value.toMap());
    } else if (value is TmClusterAnnotation) {
      buffer.putUint8(156);
      writeValue(buffer, value.toMap());
    } else if (value is TmError) {
      buffer.putUint8(157);
      writeValue(buffer, value.toMap());
    } else if (value is TmSuggestionSearcherOption) {
      buffer.putUint8(158);
      writeValue(buffer, value.toMap());
    } else if (value is TmSearcherPoi) {
      buffer.putUint8(159);
      writeValue(buffer, value.toMap());
    } else if (value is TmDistrictData) {
      buffer.putUint8(160);
      writeValue(buffer, value.toMap());
    } else if (value is TmGeoCodeSearchOption) {
      buffer.putUint8(161);
      writeValue(buffer, value.toMap());
    } else if (value is TmAddressComponent) {
      buffer.putUint8(162);
      writeValue(buffer, value.toMap());
    } else if (value is TmGeoCodeSearchResult) {
      buffer.putUint8(163);
      writeValue(buffer, value.toMap());
    } else if (value is TmReverseGeoCodeSearchOption) {
      buffer.putUint8(164);
      writeValue(buffer, value.toMap());
    } else if (value is TmReverseGeoCodeSearchResult) {
      buffer.putUint8(165);
      writeValue(buffer, value.toMap());
    } else if (value is TmPoiExploreSearchOption) {
      buffer.putUint8(166);
      writeValue(buffer, value.toMap());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 150:
        return TmType.values.elementAt(readValue(buffer) as int);
      case 151:
        return TmConfig.fromMap(readValue(buffer) as Map);
      case 152:
        return TmPoint.fromMap(readValue(buffer) as Map);
      case 153:
        return TmLatLng.fromMap(readValue(buffer) as Map);
      case 154:
        return TmClusterInfo.fromMap(readValue(buffer) as Map);
      case 155:
        return TmPoiInfo.fromMap(readValue(buffer) as Map);
      case 156:
        return TmClusterAnnotation.fromMap(readValue(buffer) as Map);
      case 157:
        return TmError.fromMap(readValue(buffer) as Map);
      case 158:
        return TmSuggestionSearcherOption.fromMap(readValue(buffer) as Map);
      case 159:
        return TmSearcherPoi.fromMap(readValue(buffer) as Map);
      case 160:
        return TmDistrictData.fromMap(readValue(buffer) as Map);
      case 161:
        return TmGeoCodeSearchOption.fromMap(readValue(buffer) as Map);
      case 162:
        return TmAddressComponent.fromMap(readValue(buffer) as Map);
      case 163:
        return TmGeoCodeSearchResult.fromMap(readValue(buffer) as Map);
      case 164:
        return TmReverseGeoCodeSearchOption.fromMap(readValue(buffer) as Map);
      case 165:
        return TmReverseGeoCodeSearchResult.fromMap(readValue(buffer) as Map);
      case 166:
        return TmPoiExploreSearchOption.fromMap(readValue(buffer) as Map);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}
