//
//  TencentMapClusterHandler.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/1/30.
//

import Flutter
import QMapKit
import QMapSDKUtils

class TencentMapClusterHandler: NSObject, TencentMapHandlerProtocol {
    
    private let mapView: QMapView
    private lazy var clusterManager: QMUClusterManager = {
        let manager = QMUClusterManager(map: mapView)
        manager?.delegate = self
        manager?.thresholdZoomlevel = 7
        return manager!
    }()
    
    init(mapView: QMapView) {
        self.mapView = mapView
        
        super.init()
    }
    
    internal func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print(call.method)
        
        switch call.method {
        case "TencentMapCluster_setClusterMaxDistance":
            if let distance = call.arguments as? CGFloat {
                clusterManager.distance = distance
            }
            result(nil)
            
        case "TencentMapCluster_setClusterCoordinates":
            if let arg = call.arguments as? Array<TmClusterInfo> {
                clusterManager.addAnnotations(arg)
            }
            result(nil)
            
        case "TencentMapCluster_clearClusterCoordinates":
            clusterManager.clearAnnotations()
            result(nil)
            
        case "TencentMapCluster_refreshCluster":
            clusterManager.refreshCluster()
            result(nil)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
}

// MARK: QMUClusterProtocol
extension TencentMapClusterHandler: QMUClusterProtocol {
    func clusterAnnotation(_ anno1: QMUAnnotation!, with anno2: QMUAnnotation!) -> Bool {
        return true
    }
}
