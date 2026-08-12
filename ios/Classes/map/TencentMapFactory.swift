//
//  TencentMapFactory.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/1/14.
//

import Flutter

class TencentMapFactory: NSObject, FlutterPlatformViewFactory {
    
    let registrar: FlutterPluginRegistrar
    
    
    init(registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }
    
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> any FlutterPlatformView {
        // 每次初始化都会创建
        TencentMapView(frame: frame, viewId: viewId, registrar: registrar, args: args)
    }
    
    func createArgsCodec() -> any FlutterMessageCodec & NSObjectProtocol {
        TencentMapMessageCodec.shared
    }
}
