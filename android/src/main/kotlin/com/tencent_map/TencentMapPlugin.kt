package com.tencent_map


import com.tencent_map.bean.codec.TencentMapCodec
import com.tencent_map.handler.map.TencentMapPluginHandler
import com.tencent_map.handler.searcher.TencentSearcherPluginHandler
import com.tencent_map.map.TencentMapFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMethodCodec

const val TAG = "TencentMapPlugin"

class TencentMapPlugin: FlutterPlugin, ActivityAware {
    private lateinit var mapChannel: MethodChannel
    private lateinit var mapHandler: TencentMapPluginHandler
    private lateinit var searcheerHandler: TencentSearcherPluginHandler

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        // mapView
        val factory = TencentMapFactory(binding.binaryMessenger)
        binding.platformViewRegistry.registerViewFactory("eplbks.tencent_map_view", factory)

        mapChannel = MethodChannel(binding.binaryMessenger, "eplbks.tencent_map_plugin", StandardMethodCodec(TencentMapCodec()))
        mapHandler = TencentMapPluginHandler(mapChannel, binding.applicationContext)
        val searchChannel = MethodChannel(binding.binaryMessenger, "eplbks.tencent_searcher_plugin", StandardMethodCodec(TencentMapCodec()))
        searcheerHandler = TencentSearcherPluginHandler(searchChannel, binding.applicationContext)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        mapChannel.setMethodCallHandler(null)
    }

    // 插件和Activity第一次绑定
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        mapHandler.activity = binding.activity
        binding.addRequestPermissionsResultListener(mapHandler.permissionResultListener)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        mapHandler.activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        mapHandler.activity = binding.activity
        binding.addRequestPermissionsResultListener(mapHandler.permissionResultListener)
    }

    // 插件和Activity解绑
    override fun onDetachedFromActivity() {
        mapHandler.activity = null
    }
}
