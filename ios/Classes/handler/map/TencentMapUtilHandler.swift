//
//  TencentMapUtilHandler.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/3/25.
//

import Flutter
import QMapKit

class TencentMapUtilHandler: NSObject, TencentMapHandlerProtocol {
    
    private let mapView: QMapView
    
    init(mapView: QMapView) {
        self.mapView = mapView
    }
    
    internal func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print(call.method)
        
        switch call.method {
        case "TencentMapUtil_convertCoordinateToPoint":
            guard let location = call.arguments as? CLLocationCoordinate2D else {
                result(nil)
                return
            }
            let point = mapView.convert(location, toPointTo: mapView)
            result(point)
            
        case "TencentMapUtil_convertPointToCoordinate":
            guard let point = call.arguments as? CGPoint else {
                result(nil)
                return
            }
            let location = mapView.convert(point, toCoordinateFrom: mapView)
            result(location)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
