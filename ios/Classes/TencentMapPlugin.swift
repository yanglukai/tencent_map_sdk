//
//  TencentMapPlugin.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/1/14.
//

import Flutter

public class TencentMapPlugin: NSObject, FlutterPlugin {
        
    static var mapHandler: TencentMapPluginHandler?
    static var searcherHandler: TencentSearcherPluginHandler?
    
    public static func register(with registrar: any FlutterPluginRegistrar) {
        // mapView
        registrar.register(TencentMapFactory(registrar: registrar), withId: "eplbks.tencent_map_view")
        
        let mapChannel = FlutterMethodChannel(name: "eplbks.tencent_map_plugin", binaryMessenger: registrar.messenger(), codec: TencentMapMethodCodec.shared)
        mapHandler = TencentMapPluginHandler(channel: mapChannel)
        let searcherChannel = FlutterMethodChannel(name: "eplbks.tencent_searcher_plugin", binaryMessenger: registrar.messenger(), codec: TencentMapMethodCodec.shared)
        searcherHandler = TencentSearcherPluginHandler(channel: searcherChannel)
    }
    
    
}
