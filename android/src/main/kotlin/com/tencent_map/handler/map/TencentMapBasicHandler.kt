package com.tencent_map.handler.map

import android.graphics.Color
import android.location.Location
import android.util.Log
import com.tencent.map.geolocation.TencentLocation
import com.tencent.map.geolocation.TencentLocationListener
import com.tencent.map.geolocation.TencentLocationManager
import com.tencent.map.geolocation.TencentLocationRequest
import com.tencent.tencentmap.mapsdk.maps.CameraUpdateFactory
import com.tencent.tencentmap.mapsdk.maps.LocationSource
import com.tencent.tencentmap.mapsdk.maps.LocationSource.OnLocationChangedListener
import com.tencent.tencentmap.mapsdk.maps.MapView
import com.tencent.tencentmap.mapsdk.maps.TencentMap
import com.tencent.tencentmap.mapsdk.maps.UiSettings
import com.tencent.tencentmap.mapsdk.maps.model.BitmapDescriptorFactory
import com.tencent.tencentmap.mapsdk.maps.model.LatLng
import com.tencent.tencentmap.mapsdk.maps.model.MapFontSize
import com.tencent.tencentmap.mapsdk.maps.model.MyLocationConfig
import com.tencent.tencentmap.mapsdk.maps.model.MyLocationStyle
import com.tencent_map.TAG
import com.tencent_map.util.TencentMapUtil
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.tencent_map.R
import com.tencent_map.bean.TmConfig

class TencentMapBasicHandler(
        private val mapView: MapView,
        private val methodChannel: MethodChannel
) : TencentMapHandlerInterface, LocationSource, TencentLocationListener {

    private val tencentMap: TencentMap = mapView.map
    private val mapUiSettings: UiSettings = tencentMap.uiSettings

    private var locationManager: TencentLocationManager? = null
    private var locationRequest: TencentLocationRequest? = null
    private var locationChangedListener: OnLocationChangedListener? = null
    private var locationStyle: MyLocationStyle? = null

    override fun handle(call: MethodCall, result: MethodChannel.Result) {
        Log.v(TAG, call.method)

        when (call.method) {
            "TencentMapBasic_updateMapConfig" -> {
                val config = call.arguments as? TmConfig
                config?.let { updateMapConfig(it) }
                result.success(null)
            }

            "TencentMapBasic_getZoomLevel" -> {
                result.success(tencentMap.cameraPosition.zoom)
            }

            "TencentMapBasic_setZoomLevel" -> {
                val arg = call.arguments as? Map<String, *>
                val level = arg?.get("level") as? Double
                val animated = arg?.get("animated") as? Boolean
                if (level != null && animated != null) {
                    if (animated) {
                        tencentMap.animateCamera(CameraUpdateFactory.zoomTo(level.toFloat()))
                    } else {
                        tencentMap.moveCamera(CameraUpdateFactory.zoomTo(level.toFloat()))
                    }
                    result.success(level >= tencentMap.minZoomLevel && level <= tencentMap.maxZoomLevel)
                } else {
                    result.success(false)
                }
            }

            "TencentMapBasic_changeZoomLevel" -> {
                val arg = call.arguments as? Map<String, *>
                val change = arg?.get("change") as? Double
                val animated = arg?.get("animated") as? Boolean
                if (change != null && animated != null) {
                    val currentLevel = tencentMap.cameraPosition.zoom
                    val level = currentLevel + change
                    if (animated) {
                        tencentMap.animateCamera(CameraUpdateFactory.zoomTo(level.toFloat()))
                    } else {
                        tencentMap.moveCamera(CameraUpdateFactory.zoomTo(level.toFloat()))
                    }
                    result.success(level >= tencentMap.minZoomLevel && level <= tencentMap.maxZoomLevel)
                } else {
                    result.success(false)
                }
            }

            "TencentMapBasic_setCenterLatLng" -> {
                val arg = call.arguments as? Map<String, *>
                val latLng = arg?.get("latLng") as? LatLng
                val animated = arg?.get("animated") as? Boolean
                if (latLng != null && animated != null) {
                    if (animated) {
                        tencentMap.animateCamera(CameraUpdateFactory.newLatLng(latLng))
                    } else {
                        tencentMap.moveCamera(CameraUpdateFactory.newLatLng(latLng))
                    }
                }
                result.success(null)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun updateMapConfig(config: TmConfig) {
        config.mapType?.let {
            tencentMap.mapType = when (it) {
                0 -> TencentMap.MAP_TYPE_NORMAL
                1 -> TencentMap.MAP_TYPE_SATELLITE
                2 -> TencentMap.MAP_TYPE_DARK
                3 -> TencentMap.MAP_TYPE_NEW_3D_IMMERSIVE
                else -> TencentMap.MAP_TYPE_NORMAL
            }
        }
        config.mapStyle?.let { tencentMap.mapStyle = it }
        config.centerLatLng?.let { tencentMap.animateCamera(CameraUpdateFactory.newLatLng(it)) }
        if (config.showsUserLocation == true) {
            initLocation()
        }
        config.showsScale?.let { mapUiSettings.isScaleViewEnabled = it }
        config.scaleOrigin?.let {
            // 比例尺原点位置
        }
        config.showsBuildings?.let {
            // 是否显示建筑物
        }
        config.shows3DBuildings?.let { tencentMap.setBuilding3dEffectEnable(it) }
        config.showsPoi?.let { tencentMap.setPoisEnabled(it) }
        config.labelSize?.let {
            // 设置底图上的标注的字体大小
            tencentMap.setMapFontSize(when (it) {
                0 -> MapFontSize.tiny
                1 -> MapFontSize.small
                2 -> MapFontSize.normal
                3 -> MapFontSize.large
                4 -> MapFontSize.huge
                else -> MapFontSize.normal
            })
        }
        config.showsBaseMap?.let { tencentMap.setBaseMapEnabled(it) }
        config.showsCompass?.let { mapUiSettings.isCompassEnabled = it }
        config.compassOffset?.let {
            // 置指南针基于默认位置的偏移. 右下为正
            mapUiSettings.setCompassExtraPadding(it.x.toInt(), it.y.toInt())
        }
        config.preferredFramesPerSecond?.let {
            // 当前地图最大渲染帧数
        }
        config.logoCenter?.let {
            // logo位置
        }
        config.logoScale?.let { mapUiSettings.setLogoScale(it) }
        config.zoomLevel?.let {
            val cameraUpdate = CameraUpdateFactory.zoomTo(it.toFloat())
            tencentMap.animateCamera(cameraUpdate)
        }
        config.minZoomLevel?.let { tencentMap.setMinZoomLevel(it.toInt()) }
        config.maxZoomLevel?.let { tencentMap.setMaxZoomLevel(it.toInt()) }
        config.zoomEnabled?.let { mapUiSettings.isZoomGesturesEnabled = it }
        config.keepCenterDuringZoom?.let {
            // 以地图中心为中心
        }
        config.scrollEnabled?.let { mapUiSettings.isZoomGesturesEnabled = it }
        config.overlookingEnabled?.let { mapUiSettings.isTiltGesturesEnabled = it }
        config.rotateEnabled?.let { mapUiSettings.isRotateGesturesEnabled = it }
        config.alwaysTriggerDidTapCoordinateEnabled?.let {
            //
        }
    }

    private fun initLocation() {
        locationManager = TencentLocationManager.getInstance(mapView.context)
        locationRequest = TencentLocationRequest.create()
        locationRequest?.setInterval(2000)
        locationRequest?.setAllowDirection(true)
        // 地图上设置定位数据源
        tencentMap.myLocationConfig = MyLocationConfig.newBuilder().setLocationSource(this).build()
        // 设置当前位置可见
        tencentMap.myLocationConfig = MyLocationConfig.newBuilder(tencentMap.myLocationConfig).setMyLocationEnabled(true).build()
        // 设置定位图标样式
        setLocMarkerStyle()
        tencentMap.myLocationConfig = MyLocationConfig.newBuilder(tencentMap.myLocationConfig).setMyLocationStyle(locationStyle).build()
    }

    private fun setLocMarkerStyle() {
        locationStyle = MyLocationStyle()
        // 连续定位，但不会移动到地图中心点，定位点依照设备方向旋转，并且跟随设备移动
        locationStyle?.myLocationType(MyLocationStyle.LOCATION_TYPE_LOCATION_ROTATE_NO_CENTER)
        val bitmapDescriptor = BitmapDescriptorFactory.fromBitmap(TencentMapUtil.getUserLocationBitMap(mapView.context, R.drawable.my_location))
        locationStyle?.icon(bitmapDescriptor)
        // 设置定位圆形区域的边框宽度
        locationStyle?.strokeWidth(3)
        locationStyle?.fillColor(Color.parseColor("#4ddad589"))
    }

    // -- LocationSource --
    override fun activate(onLocationChangedListener: OnLocationChangedListener?) {
        locationChangedListener = onLocationChangedListener
        val error: Int? = locationManager?.requestLocationUpdates(locationRequest, this)
        if (error != 0) {
            Log.e("requestLocationUpdates", "定位失败_$error")
        }
    }

    override fun deactivate() {
        locationManager?.removeUpdates(this)
        locationManager = null
        locationRequest = null
        locationChangedListener = null
    }

    // -- TencentLocationListener --
    override fun onLocationChanged(tencentLocation: TencentLocation?, i: Int, s: String?) {
        if (i == TencentLocation.ERROR_OK && locationChangedListener != null) {
            var location = Location(tencentLocation?.provider)
            // 设置经纬度以及精度方向
            tencentLocation?.latitude?.let { location.latitude = it }
            tencentLocation?.longitude?.let { location.longitude = it }
            tencentLocation?.accuracy?.let { location.accuracy = it }
            tencentLocation?.direction?.let { location.bearing = it.toFloat() }
            locationChangedListener?.onLocationChanged(location)
            methodChannel.invokeMethod("userLocationChangedComplete", LatLng(location.latitude, location.longitude))
        }
    }

    // GPS, WiFi, Radio 等状态发生变化
    override fun onStatusUpdate(p0: String?, p1: Int, p2: String?) {
        Log.v("State changed", "$p0===$p2")
    }
}