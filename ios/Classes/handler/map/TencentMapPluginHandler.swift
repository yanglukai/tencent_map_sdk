//
//  TencentMapPluginHandler.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/1/14.
//

import Flutter
import QMapKit

class TencentMapPluginHandler: NSObject {
    
    private let channel: FlutterMethodChannel
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    private var authorizationResult: FlutterResult?
    
    init(channel: FlutterMethodChannel) {
        self.channel = channel
        super.init()
        
        channel.setMethodCallHandler {[weak self] call, result in
            self?.handle(call, result: result)
        }
    }
    
    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print(call.method)
        switch (call.method) {
            
        case "setPrivacyAgreement":
            if let isAgree = call.arguments as? Bool {
                QMapServices.shared().setPrivacyAgreement(isAgree)
            }
            result(nil)
            
        case "setApiKey":
            if let apiKey = call.arguments as? String {
                QMapServices.shared().apiKey = apiKey
            }
            result(nil)
            
        case "requestLocationAuthorization":
            requestLocationAuthorization(result)
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    // 请求定位权限
    private func requestLocationAuthorization(_ result: @escaping FlutterResult) {
        
        if CLLocationManager.locationServicesEnabled() == false {
            result(false)
            return
        }
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            result(true)
        } else if status == .notDetermined {
            authorizationResult = result
            if Bundle.main.object(forInfoDictionaryKey: "NSLocationWhenInUseUsageDescription") != nil {
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            result(false)
        }
    }
}

// MARK: CLLocationManagerDelegate
extension TencentMapPluginHandler : CLLocationManagerDelegate {
    // 定位权限状态改变时回调函数 iOS 13
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // 权限已授予，可获取定位
            authorizationResult?(true)
            authorizationResult = nil
        case .denied, .restricted:
            // 权限被拒绝/受限
            authorizationResult?(false)
            authorizationResult = nil
        case .notDetermined:
            // 权限未确定（理论上不会走到这里）
            break
        @unknown default:
            break
        }
    }
    
    // 定位权限状态改变时回调函数 iOS 14+
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                // 权限已授予，可获取定位
                authorizationResult?(true)
                authorizationResult = nil
            case .denied, .restricted:
                // 权限被拒绝/受限
                authorizationResult?(false)
                authorizationResult = nil
            case .notDetermined:
                // 权限未确定（理论上不会走到这里）
                break
            @unknown default:
                break
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
