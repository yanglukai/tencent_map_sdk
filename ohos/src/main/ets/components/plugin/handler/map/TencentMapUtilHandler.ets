import { MethodCall, MethodResult } from "@ohos/flutter_ohos";
import { LatLng, MapController, Point } from "@tencentmap/map";
import { TmLatLng, TmPoint } from "../../model/TencentMapModels";
import { TAG } from "../../TencentMapPlugin";
import { TencentMapHandler } from "../MapViewControllerHandlerImpl";
import { display } from "@kit.ArkUI";

export default class TencentMapUtilHandler implements TencentMapHandler {

  private mapController: MapController

  constructor(controller: MapController) {
    this.mapController = controller
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    console.log(TAG, call.method)

    switch (call.method) {
      case "TencentMapUtil_convertCoordinateToPoint":
        {
          const latLng: TmLatLng = call.args
          const point: Point = this.mapController.geoToScreen(latLng.latitude, latLng.longitude)
          const screenDensity = display.getDefaultDisplaySync().densityDPI/160
          result.success(new TmPoint(point.x/screenDensity, point.y/screenDensity))
          break
        }

      case "TencentMapUtil_convertPointToCoordinate":
        {
          const point: TmPoint = call.args
          const latLng: LatLng = this.mapController.screenToGeo(point.x, point.y)
          result.success(new TmLatLng(latLng.lat, latLng.lng))
          break
        }

      default :
        result.notImplemented()
        break
    }
  }

  dispose(): void {

  }

}