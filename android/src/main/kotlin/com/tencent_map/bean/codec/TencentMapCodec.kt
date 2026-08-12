package com.tencent_map.bean.codec


import android.graphics.PointF
import com.tencent.lbssearch.`object`.param.Address2GeoParam
import com.tencent.lbssearch.`object`.param.ExploreParam
import com.tencent.lbssearch.`object`.param.Geo2AddressParam
import com.tencent.lbssearch.`object`.param.SuggestionParam
import com.tencent.lbssearch.`object`.result.Address2GeoResultObject.Address2GeoResult
import com.tencent.lbssearch.`object`.result.AddressComponent
import com.tencent.lbssearch.`object`.result.DistrictResultObject.DistrictResult
import com.tencent.lbssearch.`object`.result.ExploreResultObject
import com.tencent.lbssearch.`object`.result.Geo2AddressResultObject.ReverseAddressResult
import com.tencent.lbssearch.`object`.result.SuggestionResultObject.SuggestionData
import com.tencent.tencentmap.mapsdk.maps.model.LatLng
import com.tencent.tencentmap.mapsdk.maps.model.MapPoi
import com.tencent.tencentmap.mapsdk.vector.utils.clustering.algo.StaticCluster
import com.tencent_map.bean.Address2GeoParam
import com.tencent_map.bean.Address2GeoResult
import com.tencent_map.bean.AddressComponent
import com.tencent_map.bean.DistrictResult
import com.tencent_map.bean.ExploreParam
import com.tencent_map.bean.Geo2AddressParam
import com.tencent_map.bean.LatLng
import com.tencent_map.bean.MapPoi
import com.tencent_map.bean.PointF
import com.tencent_map.bean.ReverseAddressResult
import com.tencent_map.bean.StaticCluster
import com.tencent_map.bean.SuggestionData
import com.tencent_map.bean.SuggestionParam
import com.tencent_map.bean.TmClusterInfo
import com.tencent_map.bean.TmConfig
import com.tencent_map.bean.TmError
import com.tencent_map.bean.toMap
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

class TencentMapCodec: StandardMessageCodec() {
    override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
        return when (type) {
            151.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    TmConfig.fromMap(it)
                }
            }
            152.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    PointF(it)
                }
            }
            153.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    LatLng(it)
                }
            }
            154.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    TmClusterInfo.fromMap(it)
                }
            }
            155.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    MapPoi(it)
                }
            }
            156.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    StaticCluster(it)
                }
            }
            157.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    TmError.fromMap(it)
                }
            }
            158.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    SuggestionParam(it)
                }
            }
            159.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    SuggestionData(it)
                }
            }
            160.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    DistrictResult(it)
                }
            }
            161.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    Address2GeoParam(it)
                }
            }
            162.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    AddressComponent(it)
                }
            }
            163.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    Address2GeoResult(it)
                }
            }
            164.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    Geo2AddressParam(it)
                }
            }
            165.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    ReverseAddressResult(it)
                }
            }
            166.toByte() -> {
                return (readValue(buffer) as? Map<String, Any?>)?.let {
                    ExploreParam(it)
                }
            }
            else -> super.readValueOfType(type, buffer)
        }
    }

    override fun writeValue(stream: ByteArrayOutputStream, value: Any?) {
        when (value) {
            is TmConfig -> {
                stream.write(151)
                writeValue(stream, value.toMap())
            }
            is PointF -> {
                stream.write(152)
                writeValue(stream, value.toMap())
            }
            is LatLng -> {
                stream.write(153)
                writeValue(stream, value.toMap())
            }
            is TmClusterInfo -> {
                stream.write(154)
                writeValue(stream, value.toMap())
            }
            is MapPoi -> {
                stream.write(155)
                writeValue(stream, value.toMap())
            }
            is StaticCluster<*> -> {
                stream.write(156)
                writeValue(stream, value.toMap())
            }
            is TmError -> {
                stream.write(157)
                writeValue(stream, value.toMap())
            }
            is SuggestionParam -> {
                stream.write(158)
                writeValue(stream, value.toMap())
            }
            is SuggestionData -> {
                stream.write(159)
                writeValue(stream, value.toMap())
            }
            is DistrictResult -> {
                stream.write(160)
                writeValue(stream, value.toMap())
            }
            is Address2GeoParam -> {
                stream.write(161)
                writeValue(stream, value.toMap())
            }
            is AddressComponent -> {
                stream.write(162)
                writeValue(stream, value.toMap())
            }
            is Address2GeoResult -> {
                stream.write(163)
                writeValue(stream, value.toMap())
            }
            is Geo2AddressParam -> {
                stream.write(164)
                writeValue(stream, value.toMap())
            }
            is ReverseAddressResult -> {
                stream.write(165)
                writeValue(stream, value.toMap())
            }
            is ExploreParam -> {
                stream.write(166)
                writeValue(stream, value.toMap())
            }
            is ExploreResultObject.SearchResultData -> {
                stream.write(159)
                writeValue(stream, value.toMap())
            }
            else -> super.writeValue(stream, value)
        }

    }
}