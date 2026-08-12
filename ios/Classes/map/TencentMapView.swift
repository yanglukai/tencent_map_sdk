//
//  TencentMapView.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/1/14.
//


import Flutter
import QMapKit

class TencentMapView: NSObject, FlutterPlatformView {
    
    private let mapView: QMapView
    private var handler: TencentMapControllerHandler?
    private var delegate: TencentMapViewDelegate?
    
    init(frame: CGRect, viewId: Int64, registrar: FlutterPluginRegistrar, args: Any?) {
        mapView = QMapView(frame: frame)
        super.init()
        
        let channel = FlutterMethodChannel(name: "eplbks.tencent_map_controller_\(viewId)", binaryMessenger: registrar.messenger(), codec: TencentMapMethodCodec.shared)
        handler = TencentMapControllerHandler(methodChannel: channel, mapView: mapView)
        delegate = TencentMapViewDelegate(methodChannel: channel)
        mapView.delegate = delegate
    }
    
    func view() -> UIView { return mapView }
    
    deinit {
        print("TencentMapView----deinit")
    }
    
}
