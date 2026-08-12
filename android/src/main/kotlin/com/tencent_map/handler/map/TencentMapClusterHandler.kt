package com.tencent_map.handler.map

import android.content.Context
import android.util.Log
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import com.tencent.tencentmap.mapsdk.maps.model.CameraPosition
import com.tencent.tencentmap.mapsdk.maps.model.MarkerOptions
import com.tencent.tencentmap.mapsdk.vector.utils.clustering.Cluster
import com.tencent.tencentmap.mapsdk.vector.utils.clustering.ClusterManager
import com.tencent.tencentmap.mapsdk.vector.utils.clustering.algo.NonHierarchicalDistanceBasedAlgorithm
import com.tencent.tencentmap.mapsdk.vector.utils.clustering.view.DefaultClusterRenderer
import com.tencent_map.TAG
import com.tencent_map.bean.TmClusterInfo
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class TencentMapClusterHandler(
        private val mapView: MapView,
        private val methodChannel: MethodChannel
) : TencentMapHandlerInterface {

    private val tencentMap: TencentMap = mapView.map

    private val clusterManager: ClusterManager<TmClusterInfo> by lazy {
        val manager = ClusterManager<TmClusterInfo>(mapView.context, tencentMap)
        val clusterRenderer = CustomIconClusterRenderer(mapView.context, tencentMap, manager, methodChannel)
        clusterRenderer.minClusterSize = 1
        clusterRenderer.buckets = intArrayOf(10, 20, 50, 100, 500, 1000, 5000, 10000)
        manager.renderer = clusterRenderer
        manager
    }

    override fun handle(call: MethodCall, result: MethodChannel.Result) {
        Log.v(TAG, call.method)

        when (call.method) {
            "TencentMapCluster_setClusterMaxDistance" -> {
                val distance = call.arguments as? Double
                distance?.let {
                    val ndba = NonHierarchicalDistanceBasedAlgorithm<TmClusterInfo>(mapView.context)
                    ndba.maxDistanceAtZoom= it.toInt()
                    clusterManager.algorithm= ndba
                }
            }

            "TencentMapCluster_setClusterCoordinates" -> {
                val items = call.arguments as? Collection<TmClusterInfo>
                items?.let {

                    clusterManager.setOnClusterItemClickListener {
                        methodChannel.invokeMethod("mapViewDidTapAtClusterItemComplete", it)
                        false
                    }
                    clusterManager.setOnClusterClickListener {
                        methodChannel.invokeMethod("mapViewDidTapAtClusterComplete", it)
                        false
                    }
                    tencentMap.setOnCameraChangeListener(clusterManager)
                    tencentMap.setOnMarkerClickListener(clusterManager)
                    clusterManager.addItems(it)
                    clusterManager.cluster()
                }
            }

            "TencentMapCluster_clearClusterCoordinates" -> {
                clusterManager.cancel()
                tencentMap.clearAllOverlays()
            }

            "TencentMapCluster_refreshCluster" -> {
                clusterManager.cluster()
            }
            else -> {
                result.notImplemented()
            }
        }
    }
}

class CustomIconClusterRenderer(
        context: Context,
        tencentMap: TencentMap,
        clusterManager: ClusterManager<TmClusterInfo>,
        private val methodChannel: MethodChannel
) : DefaultClusterRenderer<TmClusterInfo>(context, tencentMap, clusterManager), TencentMap.OnCameraChangeListener {

    private val mContext: Context = context

    override fun onBeforeClusterItemRendered(item: TmClusterInfo?, markerOptions: MarkerOptions?) {
        markerOptions?.icon(item?.getBitmapDescriptor(mContext))
    }

    override fun onBeforeClusterRendered(p0: Cluster<TmClusterInfo>?, p1: MarkerOptions?) {
        super.onBeforeClusterRendered(p0, p1)
    }

    override fun onCameraChange(p0: CameraPosition?) {

    }

    override fun onCameraChangeFinished(position: CameraPosition?) {
        val argMap: MutableMap<String, Any?> = mutableMapOf()
        argMap.set("latLng", position?.target)
        var isGesture: Boolean = false
        position?.triggers?.forEach {
            if (it == CameraPosition.Trigger.GESTURE) isGesture = true
        }
        argMap.set("gesture", isGesture)
        methodChannel.invokeMethod("mapViewRegionDidChangeComplete", argMap)
    }
}