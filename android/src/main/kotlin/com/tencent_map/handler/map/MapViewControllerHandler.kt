package com.tencent_map.handler.map

import com.tencent.tencentmap.mapsdk.maps.MapView
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MapViewControllerHandler(
        methodChannel: MethodChannel,
        mapView: MapView
) {

    private val mapViewHandles = mapOf(
            "TencentMapBasic" to TencentMapBasicHandler(mapView, methodChannel),
            "TencentMapLifecycle" to TencentMapLifecycleHandler(mapView),
            "TencentMapCluster" to TencentMapClusterHandler(mapView, methodChannel),
            "TencentMapUtil" to TencentMapUtilHandler(mapView)
            )

    init {
        methodChannel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            val handleStr = call.method.split("_").firstOrNull()
            var handler: TencentMapHandlerInterface? = null
            handleStr?.let { handler = mapViewHandles[it] }
            handler?.let {
                it.handle(call, result)
            } ?: run {
                result.notImplemented()
            }
        }
    }
}

interface TencentMapHandlerInterface {
    fun handle(call: MethodCall, result: MethodChannel.Result)
}