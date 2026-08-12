import { MethodChannel, Any } from "@ohos/flutter_ohos"
import { MapController, MapEvent, MapPoi } from "@tencentmap/map"
import { TmLatLng, TmPoiInfo } from "../model/TencentMapModels"

export default class TencentMapListener {
  private mapController: MapController
  private methodChannel: MethodChannel

  constructor(controller: MapController, channel: MethodChannel) {
    this.mapController = controller
    this.methodChannel = channel

    this.methodChannel.invokeMethod("mapViewFirstRenderDidComplete", null)
    this.addMapListener()
  }

  addMapListener(): void {
    this.mapController.addOnRegionChangeListener({
      onRegionWillChangeAnimated: (animated: boolean, bGesture: boolean): void => {

      },
      onRegionDidChangeAnimated: (animated: boolean, bGesture: boolean): void => {
        const latLng = new TmLatLng(this.mapController.getCenter().lat, this.mapController.getCenter().lng)
        let argMap: Map<string, Any> = new Map()
        argMap.set("latLng", latLng)
        argMap.set("gesture", bGesture)
        this.methodChannel.invokeMethod("mapViewRegionDidChangeComplete", argMap)
      }
    })

    this.mapController.addMapClickListener((evt: MapEvent) => {
      const latLng = new TmLatLng(evt.position.lat, evt.position.lng)
      this.methodChannel.invokeMethod("mapViewDidTapAtLatLngComplete", latLng)
    })

    this.mapController.addPoiClickListener((evt: MapPoi) => {
      const poiInfo: TmPoiInfo = new TmPoiInfo(new TmLatLng(evt.position.lat, evt.position.lng), evt.poiId, evt.name)
      this.methodChannel.invokeMethod("mapViewDidTapAtPoiComplete", poiInfo)
    })
  }
}