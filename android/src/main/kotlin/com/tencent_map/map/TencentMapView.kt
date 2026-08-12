package com.tencent_map.map

import android.content.Context
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent_map.bean.codec.TencentMapCodec
import com.tencent_map.handler.map.MapViewControllerHandler
import com.tencent_map.listener.TencentMapListener
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMethodCodec
import io.flutter.plugin.platform.PlatformView

class TencentMapView(
        private val context: Context,
        viewId: Int,
        private val params: Map<String, Any>?,
        private val messenger: BinaryMessenger
): PlatformView {

    private val mapView: MapView = MapView(context)
    private val handlerImpl: MapViewControllerHandler
    private val methodChannel: MethodChannel = MethodChannel(messenger, "eplbks.tencent_map_controller_$viewId", StandardMethodCodec(TencentMapCodec()))

    init {
        handlerImpl = MapViewControllerHandler(methodChannel, mapView)
        mapView.onResume()
        setTencentMapListener()
    }

    private fun setTencentMapListener() {
        val mapListener = TencentMapListener(methodChannel)
        val tencentMap = mapView.map
        tencentMap.addOnMapLoadedCallback(mapListener)
        tencentMap.setOnCameraChangeListener(mapListener)
        tencentMap.setOnMapClickListener(mapListener)
        tencentMap.setOnMapPoiClickListener(mapListener)
    }

    override fun getView(): MapView {
        return mapView
    }

    override fun dispose() {
        mapView.onDestroy()
    }
}