//
//  TencentMapViewDelegate.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/1/15.
//

import Flutter
import QMapKit
import QMapSDKUtils

class TencentMapViewDelegate: NSObject, QMapViewDelegate {
    
    private let methodChannel: FlutterMethodChannel
    
    init(methodChannel: FlutterMethodChannel) {
        self.methodChannel = methodChannel
        super.init()
    }
    
    // 地图鉴权成功
    func mapViewAuthenticationDidComplete(_ mapView: QMapView!) {
        methodChannel.invokeMethod("mapViewAuthenticationDidComplete", arguments: nil)
    }
    
    // 地图鉴权失败
    func mapViewAuthentication(_ mapView: QMapView!, didFailWithError error: Error) {
        let error: TmError = TmError(code: (error as NSError).code, message: error.localizedDescription)
        methodChannel.invokeMethod("mapViewAuthenticationDidComplete", arguments: error)
    }
    
    // 地图加载完成
    func mapViewFirstRenderDidComplete(_ mapView: QMapView!) {
        methodChannel.invokeMethod("mapViewFirstRenderDidComplete", arguments: nil)
    }
    
    // 用户位置更新后，会调用此函数
    func mapView(_ mapView: QMapView!, didUpdate userLocation: QUserLocation!, fromHeading: Bool) {
        if fromHeading == false {
            methodChannel.invokeMethod("userLocationChangedComplete", arguments: userLocation.location.coordinate)
        }
    }
    
    // 地图区域改变完成
    func mapView(_ mapView: QMapView!, regionDidChangeAnimated animated: Bool, gesture bGesture: Bool) {
        let argMap: [String : Any] = ["latLng" : mapView.centerCoordinate, "gesture": bGesture]
        methodChannel.invokeMethod("mapViewRegionDidChangeComplete", arguments: argMap)
    }
    
    // 根据anntation生成对应的View
    func mapView(_ mapView: QMapView!, viewFor annotation: (any QAnnotation)!) -> QAnnotationView? {
        guard let clusterAnnotation = annotation as? QMUClusterAnnotation else {
            return nil
        }
        if clusterAnnotation.count <= 1 {
            guard let clusterInfo = clusterAnnotation.items.anyObject() as? TmClusterInfo else {
                return nil
            }
            
            let pointReuseIndetifier = "pointReuseIndetifier"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: pointReuseIndetifier)
            if annotationView == nil {
                annotationView = QAnnotationView(annotation: clusterAnnotation, reuseIdentifier: pointReuseIndetifier)
                annotationView?.isDraggable = false
                annotationView?.canShowCallout = false
            }
            annotationView?.image = TencentMapUtil.pointAnnotationView(clusterInfo.title).toImage()
            annotationView?.centerOffset = CGPointMake(0, -20)
            return annotationView
        } else {
            let clusterReuseIndetifier = "clusterIndetifier"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: clusterReuseIndetifier) as? QMUClusterAnnotationView
            if annotationView == nil {
                annotationView = QMUClusterAnnotationView(annotation: clusterAnnotation, reuseIdentifier: clusterReuseIndetifier)
                annotationView?.isDraggable = false
                annotationView?.canShowCallout = false
            }
            let annotationCount = clusterAnnotation.count
            let width = TencentMapUtil.clusterAnnotationViewWidth(annotationCount)
            let text = TencentMapUtil.clusterAnnotationViewText(annotationCount)
            annotationView?.backgroundColor = UIColor(0x2C5CEE, alpha: 0.7)
            annotationView?.displayText.font = UIFont.systemFont(ofSize: 18)
            annotationView?.bounds = CGRect(x: 0, y: 0, width: width, height: width)
            annotationView?.displayText.text = text
            annotationView?.layer.cornerRadius = width/2
            annotationView?.zIndex = Int32(annotationCount)
            return annotationView
        }
    }
    
    // 点击地图空白处会调用此接口.
    func mapView(_ mapView: QMapView!, didTapAt coordinate: CLLocationCoordinate2D) {
        methodChannel.invokeMethod("mapViewDidTapAtLatLngComplete", arguments: coordinate)
    }
    
    // 点击地图poi图标处会调用此接口.
    func mapView(_ mapView: QMapView!, didTapPoi poi: QPoiInfo!) {
        methodChannel.invokeMethod("mapViewDidTapAtPoiComplete", arguments: poi)
    }
    
    // 当annotation view时被手势单击后，调用此接口
    func mapView(_ mapView: QMapView!, didAnnotationViewTapped view: QAnnotationView!) {
        guard let clusterAnnotation = view.annotation as? QMUClusterAnnotation else {
            return
        }
        if clusterAnnotation.count > 1 {
            methodChannel.invokeMethod("mapViewDidTapAtClusterComplete", arguments: clusterAnnotation)
        } else {
            methodChannel.invokeMethod("mapViewDidTapAtClusterItemComplete", arguments: clusterAnnotation.items.anyObject())
        }
    }
}
