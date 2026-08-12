import { Any, MethodCall, MethodResult, MethodChannel } from "@ohos/flutter_ohos";
import { TencentMapHandler } from "../MapViewControllerHandlerImpl";
import { LatLng, LocationInfo, MapController, MapType } from "@tencentmap/map"
import { TAG } from "../../TencentMapPlugin";
import { TencentLocationManager, TencentLocationRequest, TencentLocationSDK } from "@tencentmap/location_sdk";
import { common } from "@kit.AbilityKit";
import TencentMapPluginHandlerImpl from "../TencentMapPluginHandlerImpl";
import { TmConfig, TmLatLng } from "../../model/TencentMapModels";

export default class TencentMapBasicHandler implements TencentMapHandler {

  private mapController: MapController
  private methodChannel: MethodChannel
  private locationManager?: TencentLocationManager | null

  constructor(controller: MapController, channel: MethodChannel) {
    this.mapController = controller
    this.methodChannel = channel
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    console.log(TAG, call.method)

    switch (call.method) {
      case "TencentMapBasic_updateMapConfig":
        {
          const config: TmConfig = call.args
          this.updateMapConfig(config)
          result.success(null)
          break
        }

      case "TencentMapBasic_getZoomLevel":
        {
          result.success(this.mapController.getScaleLevel())
          break
        }

      case "TencentMapBasic_setZoomLevel":
        {
          const arg: Map<string, Any> = call.args
          const level: number | null = arg.get("level")
          const animated: boolean | null = arg.get("animated")
          if (level != null && animated != null) {
            if (level >= this.mapController.getMinScaleLevel() && level <= this.mapController.getMaxScaleLevel()) {
              this.mapController.setScaleLevel(level, animated)
              result.success(true)
            } else {
              result.success(false)
            }
          } else {
            result.success(false)
          }
          break
        }

      case "TencentMapBasic_changeZoomLevel":
        {
          const arg: Map<string, Any> = call.args
          const change: number | null = arg.get("change")
          const animated: boolean | null = arg.get("animated")
          if (change != null && animated != null) {
            const currentLevel = this.mapController.getScaleLevel()
            const level = currentLevel + change
            if (level >= this.mapController.getMinScaleLevel() && level <= this.mapController.getMaxScaleLevel()) {
              this.mapController.setScaleLevel(level, animated)
              result.success(true)
            } else {
              result.success(false)
            }
          } else {
            result.success(false)
          }
          break
        }

      case "TencentMapBasic_setCenterLatLng":
        {
          const arg: Map<string, Any> = call.args
          const latLng: TmLatLng | null = arg.get("latLng")
          const animated: boolean | null = arg.get("animated")
          if (latLng != null && animated != null) {
            this.mapController.setCenter(latLng.latitude, latLng.longitude, animated)
          }
          result.success(null)
          break
        }

      default :
        result.notImplemented()
        break
    }
  }

  dispose(): void {
    this.locationManager?.stopContinuousLocation()
    this.locationManager = null
  }

  private updateMapConfig(config: TmConfig) {
    if (config.mapType != null) {
      switch (config.mapType) {
        case 1:
          // 卫星地图
          this.mapController.setSatelliteEnabled(true)
          break
        case 2:
          // 暗色模式地图
          this.mapController.setStyle(2);
          break
        case 3:
          // 显示3D沉浸式地图
          this.mapController.setMapType(MapType.IMMERSE3D)
          break
        default :
          this.mapController.setSatelliteEnabled(false)
          this.mapController.setStyle(1)
          this.mapController.setMapType(MapType.NORMAL)
          break
      }
    }
    if (config.mapStyle != null) {
      this.mapController.setStyle(config.mapStyle)
    }
    if (config.centerLatLng != null) {
      this.mapController.setCenter(config.centerLatLng.latitude, config.centerLatLng.longitude, false)
    }
    if (config.showsUserLocation != null) {
      this.mapController.setLocationMarkerEnable(config.showsUserLocation)
      if (config.showsUserLocation == true) {
        this.initLocation()
      }
    }
    if (config.showsScale != null) {
      this.mapController.setScaleViewEnabled(config.showsScale)
    }
    if (config.scaleOrigin != null) {
      this.mapController.setScaleViewPosition({ x: config.scaleOrigin.x, y: config.scaleOrigin.y })
    }
    if (config.showsBuildings != null) {
      this.mapController.setBuildingEnable(config.showsBuildings)
    }
    if (config.shows3DBuildings != null) {
      this.mapController.setBuildingEffect3D(config.shows3DBuildings)
    }
    if (config.showsPoi != null) {
      this.mapController.setAnnotationEnable(config.showsPoi)
    }
    if (config.labelSize != null) {
      // 底图上的标注的字体大小
    }
    if (config.showsBaseMap != null) {
      this.mapController.setBaseMapEnable(config.showsBaseMap)
    }
    if (config.showsCompass != null) {
      this.mapController.setCompassVisible(config.showsCompass)
    }
    if (config.compassOffset != null) {
      this.mapController.setCompassPosition({x: config.compassOffset.x, y: config.compassOffset.y})
    }
    if (config.preferredFramesPerSecond != null) {
      // 当前地图最大渲染帧数
    }
    if (config.logoCenter != null) {
      this.mapController.setLogoPosition({x: config.logoCenter.x, y: config.logoCenter.y})
    }
    if (config.logoScale != null) {
      // Logo大小
    }
    if (config.zoomLevel != null) {
      this.mapController.setScaleLevel(config.zoomLevel)
    }
    if (config.minZoomLevel != null) {
      this.mapController.setMinScaleLevel(config.minZoomLevel)
    }
    if (config.maxZoomLevel != null) {
      this.mapController.setMaxScaleLevel(config.maxZoomLevel)
    }
    if (config.zoomEnabled != null) {
      this.mapController.setPinchGestureEnable(config.zoomEnabled)
    }
    if (config.keepCenterDuringZoom != null) {
      // 捏合手势以地图中心为中心
    }
    if (config.scrollEnabled != null) {
      this.mapController.setMoveGestureEnable(config.scrollEnabled)
    }
    if (config.overlookingEnabled != null) {
      this.mapController.setSkewGestureEnable(config.overlookingEnabled)
    }
    if (config.rotateEnabled != null) {
      this.mapController.setRotatedGestureEnable(config.rotateEnabled)
    }
    if (config.alwaysTriggerDidTapCoordinateEnabled != null) {
      // 当地图被单击时，是否总是触发 "地图点击回调"
    }
  }

  private initLocation() {
    if (this.locationManager != null) {
      return
    }
    TencentLocationSDK.setPrivacyPolicyAgreement(true)
    const context = getContext(this) as common.UIAbilityContext
    TencentLocationSDK.init(context, TencentMapPluginHandlerImpl.tencentSdkKey)
    this.locationManager = TencentLocationManager.createInstance()
    const locationRequest = TencentLocationRequest.default().setInterval(2)

    this.locationManager?.startContinuousLocation(locationRequest, tencentLocation => {
      if (tencentLocation.latitude && tencentLocation.longitude) {
        const location: LocationInfo = {
          position: new LatLng(tencentLocation.latitude, tencentLocation.longitude),
          accuracy: tencentLocation.accuracy,
        }
        this.mapController.setLocation(location)
        const userLotLng = new TmLatLng(tencentLocation.latitude, tencentLocation.longitude)
        this.methodChannel.invokeMethod("userLocationChangedComplete", userLotLng)
      }
    }, error => {
      console.error(TAG, `连续定位失败: ${JSON.stringify(error)}`)
    })
  }
}