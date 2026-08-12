package com.tencent_map.handler.map

import android.graphics.PointF
import android.util.Log
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import com.tencent.tencentmap.mapsdk.maps.model.LatLng
import com.tencent_map.TAG
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class TencentMapUtilHandler (private val mapView: MapView) : TencentMapHandlerInterface {

    private val tencentMap: TencentMap = mapView.map
    override fun handle(call: MethodCall, result: MethodChannel.Result) {
        Log.v(TAG, call.method)

        when (call.method) {
            "TencentMapUtil_convertCoordinateToPoint" -> {
                val latLng = call.arguments as? LatLng
                latLng?.let {
                    val projection = tencentMap.projection
                    val point = projection.toScreenLocation(latLng)
                    val density = mapView.context.resources.displayMetrics.density
                    result.success(PointF(point.x/density, point.y/density))
                } ?: result.success(null)
            }

            "TencentMapUtil_convertPointToCoordinate" -> {
                val point = call.arguments as? PointF
                point?.let {
                    val projection = tencentMap.projection
                    val latLng = projection.fromScreenLocation(point)
                    result.success(latLng)
                } ?: result.success(null)
            }

            else -> {
                result.notImplemented()
            }
        }
    }
}