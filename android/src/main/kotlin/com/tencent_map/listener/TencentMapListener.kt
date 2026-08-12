package com.tencent_map.listener

import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import com.tencent.tencentmap.mapsdk.maps.model.LatLng
import com.tencent.tencentmap.mapsdk.maps.model.MapPoi
import io.flutter.plugin.common.MethodChannel

class TencentMapListener(
        private val methodChannel: MethodChannel,
): TencentMapListenerInterface {

    override fun onMapLoaded() {
        // 地图加载完成
        methodChannel.invokeMethod("mapViewFirstRenderDidComplete", null)
        methodChannel.invokeMethod("mapViewAuthenticationDidComplete", null)
    }

    override fun onMapClick(latLng: LatLng?) {
        // 点击地图空白处回调
        methodChannel.invokeMethod("mapViewDidTapAtLatLngComplete", latLng)
    }

    override fun onClicked(poi: MapPoi?) {
        // 点击地图Poi回调
        methodChannel.invokeMethod("mapViewDidTapAtPoiComplete", poi)
    }

    override fun onCameraChange(p0: CameraPosition?) {

    }

    override fun onCameraChangeFinished(position: CameraPosition?) {
        val argMap: MutableMap<String, Any?> = mutableMapOf()
        argMap.set("latLng", position?.target)
        var isGesture = false
        position?.triggers?.forEach {
            if (it == CameraPosition.Trigger.GESTURE) isGesture = true
        }
        argMap.set("gesture", isGesture)
        methodChannel.invokeMethod("mapViewRegionDidChangeComplete", argMap)
    }
}

internal interface TencentMapListenerInterface :
        com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMapLoadedCallback,
        com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMapClickListener,
        com.tencent.tencentmap.mapsdk.maps.TencentMap.OnMapPoiClickListener,
        com.tencent.tencentmap.mapsdk.maps.TencentMap.OnCameraChangeListener
