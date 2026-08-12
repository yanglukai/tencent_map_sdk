package com.tencent_map.handler.map

import android.app.Activity
import android.content.Context
import android.util.Log
import com.tencent.map.geolocation.TencentLocationManager
import com.tencent.tencentmap.mapsdk.maps.TencentMapInitializer
import com.tencent_map.TAG
import com.tencent_map.util.TencentMapUtil
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class TencentMapPluginHandler(
        methodChannel: MethodChannel,
        private val context: Context,
) {

    var activity: Activity? = null
    private var methodResult: MethodChannel.Result? = null

    init {
        methodChannel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            this.onMethodCall(call, result)
        }
    }

    private fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        Log.v(TAG, call.method)
        val args = call.arguments

        when (call.method) {
            "setPrivacyAgreement" -> {
                val isAgree: Boolean? = args as? Boolean
                isAgree?.let {
                    TencentLocationManager.setUserAgreePrivacy(isAgree)
                    TencentMapInitializer.setAgreePrivacy(context, isAgree)
                    TencentMapInitializer.start(context)
                }
                result.success(null)
            }

            "setApiKey" -> {
                result.success(null)
            }

            "requestLocationAuthorization" -> {
                if (TencentMapUtil.hasBasicLocationPermission(activity!!)) {
                    result.success(true)
                } else {
                    methodResult = result
                    TencentMapUtil.requestBasicLocationPermission(activity!!)
                }
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    // 权限结果回调监听器
    val permissionResultListener = PluginRegistry.RequestPermissionsResultListener { requestCode: Int, permissions: Array<out String>, grantResults: IntArray ->
        // 匹配定位权限请求码
        if (requestCode != TencentMapUtil.LOCATION_PERMISSION_REQUEST_CODE) {
            return@RequestPermissionsResultListener false
        }
        // 判断定位权限是否授权成功
        if (TencentMapUtil.hasBasicLocationPermission(activity!!)) {
            methodResult?.success(true)
        } else {
            methodResult?.success(false)
        }
        methodResult = null
        return@RequestPermissionsResultListener true
    }
    
}
