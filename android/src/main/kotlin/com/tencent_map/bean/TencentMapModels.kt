package com.tencent_map.bean

import android.content.Context
import android.graphics.PointF
import com.tencent.tencentmap.mapsdk.maps.model.BitmapDescriptor
import com.tencent.tencentmap.mapsdk.maps.model.BitmapDescriptorFactory
import com.tencent.tencentmap.mapsdk.maps.model.LatLng
import com.tencent.tencentmap.mapsdk.maps.model.MapPoi
import com.tencent.tencentmap.mapsdk.vector.utils.clustering.ClusterItem
import com.tencent.tencentmap.mapsdk.vector.utils.clustering.algo.StaticCluster
import com.tencent_map.util.TencentMapUtil

fun LatLng.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    map["longitude"] = longitude
    map["latitude"] = latitude
    return map
}

fun LatLng(map: Map<String, Any?>): LatLng {
    val latitude = map["latitude"] as? Double
    val longitude = map["longitude"] as? Double
    return LatLng(latitude ?: 0.0, longitude ?: 0.0)
}

fun PointF.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    map["x"] = x
    map["y"] = y
    return map
}

fun PointF(map: Map<String, Any?>): PointF {
    val x = map["x"]
    val y = map["y"]
    var pointX = 0.0f
    if (x is Long) {
        pointX = x.toFloat()
    } else if (x is Double) {
        pointX = x.toFloat()
    }
    var pointY = 0.0f
    if (y is Long) {
        pointY = y.toFloat()
    } else if (y is Double) {
        pointY = y.toFloat()
    }
    return PointF(pointX, pointY)
}

class TmConfig(
        val mapType: Int?,
        val mapStyle: Int?,
        val centerLatLng: LatLng?,
        val showsUserLocation: Boolean?,
        val showsScale: Boolean?,
        val scaleOrigin: PointF?,
        val showsBuildings: Boolean?,
        val shows3DBuildings: Boolean?,
        val showsPoi: Boolean?,
        val labelSize: Int?,
        val showsBaseMap: Boolean?,
        val showsCompass: Boolean?,
        val compassOffset: PointF?,
        val preferredFramesPerSecond: Int?,
        val logoCenter: PointF?,
        val logoScale: Float?,
        val zoomLevel: Number?,
        val minZoomLevel: Number?,
        val maxZoomLevel: Number?,
        val zoomEnabled: Boolean?,
        val keepCenterDuringZoom: Boolean?,
        val scrollEnabled: Boolean?,
        val overlookingEnabled: Boolean?,
        val rotateEnabled: Boolean?,
        val alwaysTriggerDidTapCoordinateEnabled: Boolean?
) {

    companion object {
        fun fromMap(map: Map<String, Any?>): TmConfig {
            val mapType = map["mapType"] as? Int
            val mapStyle = map["mapStyle"] as? Int
            val centerLatLngMap = map["centerLatLng"] as? Map<String, Any>
            val showsUserLocation = map["showsUserLocation"] as? Boolean
            val showsScale = map["showsScale"] as? Boolean
            val scaleOriginMap = map["scaleOrigin"] as? Map<String, Any>
            val showsBuildings = map["showsBuildings"] as? Boolean
            val shows3DBuildings = map["shows3DBuildings"] as? Boolean
            val showsPoi = map["showsPoi"] as? Boolean
            val labelSize = map["labelSize"] as? Int
            val showsBaseMap = map["showsBaseMap"] as? Boolean
            val showsCompass = map["showsCompass"] as? Boolean
            val compassOffsetMap = map["compassOffset"] as? Map<String, Any>
            val preferredFramesPerSecond = map["preferredFramesPerSecond"] as? Int
            val logoCenterMap = map["logoCenter"] as? Map<String, Any>
            val logoScale = map["logoScale"] as? Float
            val zoomLevel = map["zoomLevel"] as? Number
            val minZoomLevel = map["minZoomLevel"] as? Number
            val maxZoomLevel = map["maxZoomLevel"] as? Number
            val zoomEnabled = map["zoomEnabled"] as? Boolean
            val keepCenterDuringZoom = map["keepCenterDuringZoom"] as? Boolean
            val scrollEnabled = map["scrollEnabled"] as? Boolean
            val overlookingEnabled = map["overlookingEnabled"] as? Boolean
            val rotateEnabled = map["rotateEnabled"] as? Boolean
            val alwaysTriggerDidTapCoordinateEnabled = map["alwaysTriggerDidTapCoordinateEnabled"] as? Boolean

            return TmConfig(
                    mapType,
                    mapStyle,
                    centerLatLngMap?.let { LatLng(it) },
                    showsUserLocation,
                    showsScale,
                    scaleOriginMap?.let { PointF(it) },
                    showsBuildings,
                    shows3DBuildings,
                    showsPoi,
                    labelSize,
                    showsBaseMap,
                    showsCompass,
                    compassOffsetMap?.let { PointF(it) },
                    preferredFramesPerSecond,
                    logoCenterMap?.let { PointF(it) },
                    logoScale,
                    zoomLevel,
                    minZoomLevel,
                    maxZoomLevel,
                    zoomEnabled,
                    keepCenterDuringZoom,
                    scrollEnabled,
                    overlookingEnabled,
                    rotateEnabled,
                    alwaysTriggerDidTapCoordinateEnabled
            )
        }
    }

    fun toMap(): Map<String, Any?> {
        val map: MutableMap<String, Any?> = mutableMapOf()
        map["mapType"] = mapType
        map["mapStyle"] = mapStyle
        map["centerLatLng"] = centerLatLng?.toMap()
        map["showsUserLocation"] = showsUserLocation
        map["showsScale"] = showsScale
        map["scaleOrigin"] = scaleOrigin?.toMap()
        map["showsBuildings"] = showsBuildings
        map["shows3DBuildings"] = shows3DBuildings
        map["showsPoi"] = showsPoi
        map["labelSize"] = labelSize
        map["showsBaseMap"] = showsBaseMap
        map["showsCompass"] = showsCompass
        map["compassOffset"] = compassOffset?.toMap()
        map["preferredFramesPerSecond"] = preferredFramesPerSecond
        map["logoCenter"] = logoCenter?.toMap()
        map["logoScale"] = logoScale
        map["zoomLevel"] = zoomLevel
        map["minZoomLevel"] = minZoomLevel
        map["maxZoomLevel"] = maxZoomLevel
        map["zoomEnabled"] = zoomEnabled
        map["keepCenterDuringZoom"] = keepCenterDuringZoom
        map["scrollEnabled"] = scrollEnabled
        map["overlookingEnabled"] = overlookingEnabled
        map["rotateEnabled"] = rotateEnabled
        map["alwaysTriggerDidTapCoordinateEnabled"] = alwaysTriggerDidTapCoordinateEnabled
        return map
    }
}

class TmClusterInfo(
        private val latLng: LatLng,
        private val title: String?,
        private val custom: Map<String, Any?>?,
        private val customId: String?
): ClusterItem {

    fun getTitle(): String? {
        return title
    }

    fun getCustom(): Map<String, Any?>? {
        return custom
    }

    override fun getPosition(): LatLng {
        return latLng
    }

    fun getBitmapDescriptor(context: Context): BitmapDescriptor {
        return BitmapDescriptorFactory.fromBitmap(TencentMapUtil.clusterBitmapWithCustomerName(context, title ?: ""))
    }

    fun getDrawableResourceId(): Int {
        return customId?.toInt() ?: 0
    }

    companion object {
        fun fromMap(map: Map<String, Any?>): TmClusterInfo {
            val latLngMap = map["latLng"] as? Map<String, Any>
            var latLng = LatLng()
            latLngMap?.let { latLng = LatLng(it) }
            val title = map["title"] as? String
            val custom = map["custom"] as? Map<String, Any>
            val customId = map["customId"] as? String
            return TmClusterInfo(
                    latLng,
                    title,
                    custom,
                    customId,
            )
        }
    }

    fun toMap(): Map<String, Any?> {
        val map: MutableMap<String, Any?> = mutableMapOf()
        map["latLng"] = latLng.toMap()
        map["title"] = title
        map["custom"] = custom
        map["customId"] = customId
        return map
    }
}

fun MapPoi.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    map["uid"] = poiId
    map["name"] = name
    map["latLng"] = position.toMap()
    return map
}

fun MapPoi(map: Map<String, Any?>): MapPoi {
    val latLng = map["latLng"] as? Map<String, Any>
    val latitude = latLng?.get("latitude") as? Double
    val longitude = latLng?.get("longitude") as? Double
    val poi = MapPoi(latitude ?: 0.0, longitude ?: 0.0)
    poi.name = map["name"] as? String
    poi.poiId = map["uid"] as? String
    return poi
}

fun StaticCluster<*>.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    var mapItems = mutableListOf<Map<String, Any?>>()
    items.forEach {
        if (it is TmClusterInfo) mapItems.add(it.toMap())
    }
    map["latLng"] = position.toMap()
    map["items"] = mapItems
    return map
}

fun StaticCluster(map: Map<String, Any?>): StaticCluster<TmClusterInfo> {
    val latLng = map["latLng"] as? Map<String, Any>
    val latitude = latLng?.get("latitude") as? Double
    val longitude = latLng?.get("longitude") as? Double
    return StaticCluster<TmClusterInfo>(LatLng(latitude ?: 0.0, longitude ?: 0.0))
}

class TmError(
        private val code: Int?,
        private val message: String?
) {
    companion object {
        fun fromMap(map: Map<String, Any?>): TmError {
            val code = map["code"] as? Int
            val message = map["message"] as? String
            return TmError(code, message)
        }
    }

    fun toMap(): Map<String, Any?> {
        val map: MutableMap<String, Any?> = mutableMapOf()
        map["code"] = code
        map["message"] = message
        return map
    }
}
