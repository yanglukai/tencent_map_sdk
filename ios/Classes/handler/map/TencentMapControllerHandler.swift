//
//  TencentMapControllerHandler.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/1/14.
//

import Flutter
import QMapKit

class TencentMapControllerHandler {
    
    private let methodChannel: FlutterMethodChannel
    private let mapView: QMapView
    
    private lazy var mapViewHandles: Dictionary<String, TencentMapHandlerProtocol> = [
        "TencentMapBasic": TencentMapBasicHandler(mapView: mapView),
        "TencentMapCluster" : TencentMapClusterHandler(mapView: mapView),
        "TencentMapUtil" : TencentMapUtilHandler(mapView: mapView),
    ]
    
    init(methodChannel: FlutterMethodChannel, mapView: QMapView) {
        self.methodChannel = methodChannel
        self.mapView = mapView
        
        methodChannel.setMethodCallHandler {[unowned self] call, result in
            let array = call.method.components(separatedBy: "_")
            if let handleStr = array.first, let handle = mapViewHandles[handleStr] {
                handle.handle(call, result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    }
}

protocol TencentMapHandlerProtocol {
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult)
}
