import { MethodCall, MethodChannel, MethodResult } from "@ohos/flutter_ohos";
import { Align, ClusterCreatedEvent, ClusterInfo, MapController, Marker, MarkerCluster,
  OverlayEvent } from "@tencentmap/map";
import { TmClusterAnnotation, TmClusterInfo, TmLatLng } from "../../model/TencentMapModels";
import { TAG } from "../../TencentMapPlugin";
import { TencentMapHandler } from "../MapViewControllerHandlerImpl";

const ClusterGroupTag: string = 'tencentMapClusterGroupTag'

export default class TencentMapClusterHandler implements TencentMapHandler {

  private mapController: MapController
  private methodChannel: MethodChannel

  private markerCluster?: MarkerCluster = undefined
  private clusterDistance: number = 100
  private markerList: Array<Marker> = []
  private clusterMarkerList: Marker[] = []

  constructor(controller: MapController, channel: MethodChannel) {
    this.mapController = controller
    this.methodChannel = channel
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    console.log(TAG, call.method)

    switch (call.method) {
      case "TencentMapCluster_setClusterMaxDistance":
        {
          const distance: number = call.args
          this.clusterDistance = distance
          if (this.markerCluster) {
            this.markerCluster.setDistance(this.clusterDistance)
          }
          result.success(null)
          break
        }

      case "TencentMapCluster_setClusterCoordinates":
        {
          const poiList: Array<TmClusterInfo> = call.args
          this.addMarkers(poiList)
          setTimeout(() => {
            this.createMarkerCluster()
            result.success(null)
          }, 100)
          break
        }

      case "TencentMapCluster_clearClusterCoordinates":
        {
          if (this.markerList.length > 0) {
            this.markerList.forEach(item => {
              this.mapController.removeMarker(item)
            })
          }
          this.markerList = []
          AppStorage.set<Array<TmClusterInfo>>('poiDataList', [])
          if (this.markerCluster) {
            this.markerCluster.refreshCluster();
          }
          result.success(null)
          break
        }

      case "TencentMapCluster_refreshCluster":
        {
          if (this.markerCluster) {
            this.markerCluster.refreshCluster();
          }
          result.success(null)
          break
        }

      default :
        result.notImplemented()
        break
    }
  }

  addMarkers(poiList: Array<TmClusterInfo>): void {
    if (this.markerList.length > 0) {
      this.markerList.forEach(item => {
        this.mapController.removeMarker(item)
      })
    }
    this.markerList = []

    poiList.forEach((item, idx) => {
      const marker = new Marker(
        {
          position: item.getLatLng(),
          icon: { uri: "rawfile://map_customer.png" },
          avoidAnnotation: true,
          avoidMarker: true,
          zIndex: idx,
          collisionRelation: 'alone',
          clusterGroupTag: ClusterGroupTag
        }
      )
      marker.setUserTag(item)
      marker.setOnClickListener((event) => {
        const info: TmClusterInfo = event.target.getUserTag()
        this.methodChannel.invokeMethod("mapViewDidTapAtClusterItemComplete", info)
      })
      marker.infoWindow = {
        componentId: item.customId ?? '',
        infoWindowInfo: item.infoWindowInfo,
        align: Align.Center,
        offsetX: 0,
        offsetY: 0,
        avoidAnnotation: true,
        avoidMarker: true
      }
      marker.updateCollisionMainComponent(marker.infoWindow);
      this.mapController.addMarker(marker);
      this.markerList.push(marker);
    })
    AppStorage.set<Array<TmClusterInfo>>('poiDataList', poiList)
  }

  createMarkerCluster(): void {
    if (this.markerCluster) {
      return
    }
    this.markerCluster = this.mapController.createMarkerCluster({
      distance: this.clusterDistance,
      clusterGroupTag: ClusterGroupTag,
      clusterInvalidCallback: (needRemoveMarker: Marker, clusterInfo: ClusterInfo) => {
        // 这里需要用户手动销毁InfoWindow，即将infowindow对应state数据移除
        let idx = this.clusterMarkerList.indexOf(needRemoveMarker)
        this.clusterMarkerList.splice(idx, 1); // 从state数据中移除聚合Marker
        const _clusterDataList: Array<TmClusterInfo> | undefined = AppStorage.get<Array<TmClusterInfo>>('clusterDataList')
        _clusterDataList?.splice(idx, 1)
        AppStorage.set<Array<TmClusterInfo>>('clusterDataList', _clusterDataList) // 从state数据中移除Infowindow相关UI元素
      }
    })
    // 点聚合创建失败
    if (!this.markerCluster) {
      return
    }
    this.markerCluster.setDistance(this.clusterDistance)
    this.markerCluster.addClusterCreatedListener((event: ClusterCreatedEvent) => {
      const _clusterDataList: Array<TmClusterInfo> | undefined = AppStorage.get<Array<TmClusterInfo>>('clusterDataList')
      // 遍历本次新增的聚合簇，并创建对应样式展示到地图中
      event.clusters.forEach((cInfo: ClusterInfo) => {
        const clusterInfo = new TmClusterInfo(
          new TmLatLng(cInfo.center.lat, cInfo.center.lng),
          this.getSizeText(cInfo.markers.length),
          cInfo.clusterId,
          undefined,
        )

        const marker = new Marker({
          position: cInfo.center,
          icon: { uri: "rawfile://map_cluster.png" },
          width: this.getSizeWidth(cInfo.markers.length),
          height: this.getSizeWidth(cInfo.markers.length),
          avoidAnnotation: false,
          avoidMarker: true,
        });
        marker.infoWindowList = [{
            componentId: clusterInfo.customId ?? '',
            infoWindowInfo: clusterInfo.infoWindowInfo
        }];

        // 设置点聚合点击事件
        marker.setOnClickListener((event: OverlayEvent) => {
          const latLng: TmLatLng = new TmLatLng(event.position.lat, event.position.lng)
          const items: Array<TmClusterInfo> = cInfo.markers.map((m: Marker) => m.getUserTag() as TmClusterInfo)
          const clusterAnnotation: TmClusterAnnotation = new TmClusterAnnotation(latLng, items)
          this.methodChannel.invokeMethod("mapViewDidTapAtClusterComplete", clusterAnnotation)
        })

        event.createClusterMarkerCb(cInfo, marker);
        this.clusterMarkerList.push(marker);
        _clusterDataList?.push(clusterInfo)
      })
      AppStorage.set<Array<TmClusterInfo>>('clusterDataList', _clusterDataList)
    })
  }

  getSizeText(size: number): string {
    if (size > 10000) {
      return "10000+"
    } else if (size > 5000) {
      return "5000+"
    } else if (size > 1000) {
      return "1000+"
    } else if (size > 500) {
      return "500+"
    } else if (size > 100) {
      return "100+"
    } else if (size > 50) {
      return "50+"
    } else if (size > 20) {
      return "20+"
    } else if (size > 10) {
      return "10+"
    } else {
      return `${size}`
    }
  }

  getSizeWidth(size: number): number {
    if (size >= 10000) {
      return 270
    } else if (size >= 1000) {
      return 225
    } else if (size >= 100) {
      return 195
    } else if (size >= 10) {
      return 165
    } else {
      return 150
    }
  }

  dispose(): void {
    if (this.markerCluster) {
      this.mapController.destroyMarkerCluster(this.markerCluster);
      this.markerCluster = undefined;
    }
  }
}