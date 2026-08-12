//
//  TencentMapBasicHandler.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/1/15.
//

import Flutter
import QMapKit

class TencentMapBasicHandler: TencentMapHandlerProtocol {
    
    private let mapView: QMapView
    
    init(mapView: QMapView) {
        self.mapView = mapView
    }
    
    internal func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        print(call.method)
        
        switch call.method {
        case "TencentMapBasic_updateMapConfig":
            if let config = call.arguments as? TmConfig {
                updateMapConfig(config)
            }
            result(nil)
            
        case "TencentMapBasic_getZoomLevel":
            result(mapView.zoomLevel)
            
        case "TencentMapBasic_setZoomLevel":
            guard let arg = call.arguments as? Dictionary<String, Any> else {
                return
            }
            if let level = arg["level"] as? Double, let animated = arg["animated"] as? Bool {
                mapView.setZoomLevel(level, animated: animated)
                result(level >= mapView.minZoomLevel && level <= mapView.maxZoomLevel)
            } else {
                result(false)
            }
            
        case "TencentMapBasic_changeZoomLevel":
            guard let arg = call.arguments as? Dictionary<String, Any> else {
                return
            }
            if let change = arg["change"] as? Double, let animated = arg["animated"] as? Bool {
                let currentLevel = mapView.zoomLevel
                let level = currentLevel + change
                mapView.setZoomLevel(level, animated: animated)
                result(level >= mapView.minZoomLevel && level <= mapView.maxZoomLevel)
            } else {
                result(false)
            }
            
        case "TencentMapBasic_setCenterLatLng":
            guard let arg = call.arguments as? Dictionary<String, Any> else {
                return
            }
            if let latLng = arg["latLng"] as? CLLocationCoordinate2D, let animated = arg["animated"] as? Bool {
                mapView.setCenter(latLng, animated: animated)
            }
            result(nil)
            
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func updateMapConfig(_ config: TmConfig) {
        if let mapType = config.mapType {
            mapView.mapType = QMapType(rawValue: mapType) ?? .typeStandard
        }
        if let mapStyle = config.mapStyle {
            mapView.setMapStyle(mapStyle)
        }
        if let centerLatLng = config.centerLatLng {
            mapView.centerCoordinate = centerLatLng
        }
        if let showsUserLocation = config.showsUserLocation {
            mapView.showsUserLocation = showsUserLocation
            if showsUserLocation {
                mapView.setUserTrackingMode(.none, animated: true)
            }
        }
        if let showsScale = config.showsScale {
            mapView.showsScale = showsScale
        }
        if let showsBuildings = config.showsBuildings{
            mapView.showsBuildings = showsBuildings
        }
        if let shows3DBuildings = config.shows3DBuildings {
            mapView.shows3DBuildings = shows3DBuildings
        }
        if let showsPoi = config.showsPoi {
            mapView.showsPoi = showsPoi
        }
        if let labelSize = config.labelSize {
            mapView.labelSize = QMapLabelSize(rawValue: labelSize) ?? .normal
        }
        if let showsBaseMap = config.showsBaseMap {
            mapView.showsBaseMap = showsBaseMap
        }
        if let showsCompass = config.showsCompass {
            mapView.showsCompass = showsCompass
        }
        if let compassOffset = config.compassOffset {
            mapView.setCompassOffset(compassOffset)
        }
        if let preferredFramesPerSecond = config.preferredFramesPerSecond {
            mapView.preferredFramesPerSecond = preferredFramesPerSecond
        }
        if let logoCenter = config.logoCenter {
            mapView.logoCenter = logoCenter
        }
        if let logoScale = config.logoScale {
            mapView.setLogoScale(logoScale)
        }
        if let scaleOrigin = config.scaleOrigin {
            mapView.scaleOrigin = scaleOrigin
        }
        if let zoomLevel = config.zoomLevel {
            mapView.zoomLevel = zoomLevel
        }
        mapView.setMinZoomLevel(config.minZoomLevel ?? 3, maxZoomLevel: config.maxZoomLevel ?? 20)
        if let zoomEnabled = config.zoomEnabled {
            mapView.isZoomEnabled = zoomEnabled
        }
        if let keepCenterDuringZoom = config.keepCenterDuringZoom {
            mapView.isKeepCenterDuringZoom = keepCenterDuringZoom
        }
        if let scrollEnabled = config.scrollEnabled {
            mapView.isScrollEnabled = scrollEnabled
        }
        if let overlookingEnabled = config.overlookingEnabled {
            mapView.isOverlookingEnabled = overlookingEnabled
        }
        if let rotateEnabled = config.rotateEnabled {
            mapView.isRotateEnabled = rotateEnabled
        }
        if let alwaysTriggerDidTapCoordinateEnabled = config.alwaysTriggerDidTapCoordinateEnabled {
            mapView.alwaysTriggerDidTapCoordinateEnabled = alwaysTriggerDidTapCoordinateEnabled
        }
    }
}
