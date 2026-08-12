import { Any, BinaryMessenger, MethodChannel, StandardMethodCodec } from "@ohos/flutter_ohos"
import PlatformView, { Params } from "@ohos/flutter_ohos/src/main/ets/plugin/platform/PlatformView"
import { common } from "@kit.AbilityKit"
import MapViewControllerHandlerImpl from "../handler/MapViewControllerHandlerImpl"
import TencentMapCodec from "../model/codec/TencentMapCodec"
import { InfoWindowInfo, MapComponent, MapController, Marker } from "@tencentmap/map"
import { AsyncCallback, BusinessError } from "@kit.BasicServicesKit"
import { TmClusterInfo, TmError } from "../model/TencentMapModels"
import TencentMapListener from "../listener/TencentMapListener"

export default class TencentMapView extends PlatformView {

  methodChannel: MethodChannel
  handler: MapViewControllerHandlerImpl

  constructor(context: common.Context, viewId: number, args: Any, message: BinaryMessenger) {
    super()

    this.methodChannel = new MethodChannel(message, `eplbks.tencent_map_controller_${viewId}`, new StandardMethodCodec(new TencentMapCodec()))
    this.handler = new MapViewControllerHandlerImpl(this.methodChannel)
  }

  getView(): WrappedBuilder<[Params]> {
		return new WrappedBuilder(MapViewBuilder)
	}

  dispose(): void {
    this.handler.dispose()
  }
}

@Builder
function MapViewBuilder(params: Params) {
  TencentMap({
    onReady:  (err: BusinessError, controller: MapController) => {
      const platformView = params.platformView as TencentMapView
      platformView.handler.mapController = controller
      new TencentMapListener(controller, platformView.methodChannel)
    },
    onAuthCallback: (err: BusinessError, success: boolean) => {
      const platformView = params.platformView as TencentMapView
      if (success) {
        platformView.methodChannel.invokeMethod("mapViewAuthenticationDidComplete", null)
      } else {
        const error: TmError = new TmError(err.code, err.message)
        platformView.methodChannel.invokeMethod("mapViewAuthenticationDidComplete", error)
      }
    },
  })
}

@Component
struct TencentMap {
  onReady: AsyncCallback<MapController> | undefined
  onAuthCallback: AsyncCallback<boolean> | undefined

  @StorageLink('poiDataList') poiDataList: Array<TmClusterInfo> = []
  @StorageLink('clusterDataList') clusterDataList: Array<Marker> = []

  aboutToAppear(): void {
    AppStorage.setOrCreate<Array<TmClusterInfo>>('poiDataList', [])
    AppStorage.setOrCreate<Array<Marker>>('clusterDataList', [])
    this.poiDataList = []
    this.clusterDataList = []
  }

  build() {
    Column() {
      MapComponent({
        mapOptions: {
          infoWindowConfig: {
            autoRefresh: false,
          }
        },
        onReady: this.onReady?.bind(this),
        onAuthCallback: this.onAuthCallback?.bind(this),
      })

      ForEach(this.poiDataList, (item: TmClusterInfo, idx: number) => {
        PoiComponent({ poiData: item, infoWindowInfo: item.infoWindowInfo })
      }, (item: TmClusterInfo) => item.customId)

      ForEach(this.clusterDataList, (item: TmClusterInfo, idx: number) => {
        ClusterComponent({ poiData: item, infoWindowInfo: item.infoWindowInfo })
      }, (item: TmClusterInfo) => item.customId)
    }
  }

  aboutToDisappear(): void {

  }
}

@Component
struct PoiComponent {
  @ObjectLink
  poiData: TmClusterInfo
  @ObjectLink
  infoWindowInfo: InfoWindowInfo

  build() {
    Text(this.poiData.title)
      .id(this.poiData.customId)
      .visibility(this.infoWindowInfo.visible ? Visibility.Visible : Visibility.Hidden)
      .position({ x: this.infoWindowInfo.x, y: this.infoWindowInfo.y - 5 })
      .foregroundColor(Color.White)
      .fontSize(13)
      .padding({ left: 14, right: 14 })
      .width(130)
      .maxLines(1)
      .textAlign(TextAlign.Center)
      .textOverflow({
        overflow: TextOverflow.Ellipsis
      })
      .hitTestBehavior(HitTestMode.Transparent)
      // .backgroundColor(Color.Red)
      // .opacity(0.5)
  }
}

@Component
struct ClusterComponent {
  @ObjectLink
  poiData: TmClusterInfo
  @ObjectLink
  infoWindowInfo: InfoWindowInfo

  build() {
    Text(this.poiData.title)
      .id(this.poiData.customId)
      .visibility(this.infoWindowInfo.visible ? Visibility.Visible : Visibility.Hidden)
      .position({ x: this.infoWindowInfo.x, y: this.infoWindowInfo.y + this.getSizeWidth() })
      .foregroundColor(Color.White)
      .fontSize(13)
      .width(this.getSizeWidth())
      .height(this.getSizeWidth())
      .maxLines(1)
      .textAlign(TextAlign.Center)
      .align(Alignment.Center)
      .textOverflow({
        overflow: TextOverflow.Ellipsis
      })
      .hitTestBehavior(HitTestMode.Transparent)
      // .backgroundColor(Color.Red)
      // .opacity(0.5)
  }

  getSizeWidth(): number {
    const size: number = Number.parseInt(this.poiData.title ?? '1')
    if (size >= 10000) {
      return 90
    } else if (size >= 1000) {
      return 75
    } else if (size >= 100) {
      return 65
    } else if (size >= 10) {
      return 55
    } else {
      return 50
    }
  }
}


