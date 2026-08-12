import { MethodCallHandler, MethodCall, MethodResult, MethodChannel } from "@ohos/flutter_ohos"
import { MapController } from "@tencentmap/map"
import TencentMapBasicHandler from "./map/TencentMapBasicHandler"
import TencentMapClusterHandler from "./map/TencentMapClusterHandler"
import TencentMapUtilHandler from "./map/TencentMapUtilHandler"

export default class MapViewControllerHandlerImpl implements MethodCallHandler {

  private methodChannel: MethodChannel
  mapController: MapController | null = null

  private _mapViewHandles: Map<string, TencentMapHandler> | null = null
  private mapViewHandles(): Map<string, TencentMapHandler> | null {
    if (this._mapViewHandles == null && this.mapController != null) {
      let map: Map<string, TencentMapHandler> = new Map()
      map.set("TencentMapBasic", new TencentMapBasicHandler(this.mapController, this.methodChannel))
      map.set("TencentMapCluster", new TencentMapClusterHandler(this.mapController, this.methodChannel))
      map.set("TencentMapUtil", new TencentMapUtilHandler(this.mapController))
      this._mapViewHandles = map
    }
    return this._mapViewHandles
  }

  constructor(channel: MethodChannel) {
    this.methodChannel = channel
    channel.setMethodCallHandler(this)
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    const array: string[] = call.method.split('_')
    const handle = this.mapViewHandles()?.get(array[0])
    if (handle == null) {
      result.notImplemented()
      return
    }
    handle.onMethodCall(call, result)
  }

  dispose(): void {
    this._mapViewHandles?.forEach(handle => {
      handle.dispose()
    })
  }
}

export interface TencentMapHandler {
  onMethodCall(call: MethodCall, result: MethodResult): void
  dispose(): void
}