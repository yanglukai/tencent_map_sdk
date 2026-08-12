package com.tencent_map.handler.map

import android.util.Log
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent_map.TAG
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class TencentMapLifecycleHandler (private val mapView: MapView) : TencentMapHandlerInterface {

    override fun handle(call: MethodCall, result: MethodChannel.Result) {
        Log.v(TAG, call.method)

        when (call.method) {
            "TencentMapLifecycle_resumed" -> {
                mapView.onStart()
                mapView.onResume()
                result.success(null)
            }

            "TencentMapLifecycle_paused" -> {
                mapView.onPause()
                mapView.onStop()
                result.success(null)
            }

            "TencentMapLifecycle_detached" -> {
                mapView.onDestroy()
                result.success(null)
            }

            else -> {
                result.notImplemented()
            }
        }
    }
}