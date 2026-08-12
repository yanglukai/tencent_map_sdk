//
//  SystemExtension.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/1/16.
//

import Foundation
import QMapKit
import QMapSDKUtils

extension CGPoint {
    static func fromMap(_ map: [String: Any]) -> CGPoint {
        let x = (map["x"] as? Double) ?? 0.0
        let y = (map["y"] as? Double) ?? 0.0
        return CGPoint(x: x, y: y)
    }
    
    func toMap() -> [String: Any] {
        return [
            "x": x,
            "y": y,
        ]
    }
}


extension CLLocationCoordinate2D {
    static func fromMap(_ map: [String: Any]) -> CLLocationCoordinate2D {
        let latitude = (map["latitude"] as? Double) ?? 0.0
        let longitude = (map["longitude"] as? Double) ?? 0.0
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    func toMap() -> [String: Any] {
        return [
            "latitude": latitude,
            "longitude": longitude,
        ]
    }
}

class TmConfig {
    var mapType: UInt?
    var mapStyle: Int32?
    var centerLatLng: CLLocationCoordinate2D?
    var showsUserLocation: Bool?
    var showsScale: Bool?
    var scaleOrigin: CGPoint?
    var showsBuildings: Bool?
    var shows3DBuildings: Bool?
    var showsPoi: Bool?
    var labelSize: Int?
    var showsBaseMap: Bool?
    var showsCompass: Bool?
    var compassOffset: CGPoint?
    var preferredFramesPerSecond: Int?
    var logoCenter: CGPoint?
    var logoScale: CGFloat?
    var zoomLevel: CGFloat?
    var minZoomLevel: CGFloat?
    var maxZoomLevel: CGFloat?
    var zoomEnabled: Bool?
    var keepCenterDuringZoom: Bool?
    var scrollEnabled: Bool?
    var overlookingEnabled: Bool?
    var rotateEnabled: Bool?
    var alwaysTriggerDidTapCoordinateEnabled: Bool?
    
    static func fromMap(_ map: [String: Any]) -> TmConfig {
        let config = TmConfig()
        config.mapType = map["mapType"] as? UInt
        config.mapStyle = map["mapStyle"] as? Int32
        if let centerLatLngMap = map["centerLatLng"] as? [String: Any] {
            config.centerLatLng = CLLocationCoordinate2D.fromMap(centerLatLngMap)
        }
        config.showsUserLocation = map["showsUserLocation"] as? Bool
        config.showsScale = map["showsScale"] as? Bool
        if let scaleOriginMap = map["scaleOrigin"] as? [String: Any] {
            config.scaleOrigin = CGPoint.fromMap(scaleOriginMap)
        }
        config.showsBuildings = map["showsBuildings"] as? Bool
        config.shows3DBuildings = map["shows3DBuildings"] as? Bool
        config.showsPoi = map["showsPoi"] as? Bool
        config.labelSize = map["labelSize"] as? Int
        config.showsBaseMap = map["showsBaseMap"] as? Bool
        config.showsCompass = map["showsCompass"] as? Bool
        if let compassOffsetMap = map["compassOffset"] as? [String: Any] {
            config.compassOffset = CGPoint.fromMap(compassOffsetMap)
        }
        config.preferredFramesPerSecond = map["preferredFramesPerSecond"] as? Int
        if let logoCenterMap = map["logoCenter"] as? [String: Any] {
            config.logoCenter = CGPoint.fromMap(logoCenterMap)
        }
        config.logoScale = map["logoScale"] as? CGFloat
        config.zoomLevel = map["zoomLevel"] as? CGFloat
        config.minZoomLevel = map["minZoomLevel"] as? CGFloat
        config.maxZoomLevel = map["maxZoomLevel"] as? CGFloat
        config.zoomEnabled = map["zoomEnabled"] as? Bool
        config.keepCenterDuringZoom = map["keepCenterDuringZoom"] as? Bool
        config.scrollEnabled = map["scrollEnabled"] as? Bool
        config.overlookingEnabled = map["overlookingEnabled"] as? Bool
        config.rotateEnabled = map["rotateEnabled"] as? Bool
        config.alwaysTriggerDidTapCoordinateEnabled = map["alwaysTriggerDidTapCoordinateEnabled"] as? Bool
        return config
    }
    
    func toMap() -> [String: Any?] {
        let map: [String: Any?] = [
            "mapType": mapType,
            "mapStyle": mapStyle,
            "centerLatLng": centerLatLng?.toMap(),
            "showsUserLocation": showsUserLocation,
            "showsScale": showsScale,
            "scaleOrigin": scaleOrigin?.toMap(),
            "showsBuildings": showsBuildings,
            "shows3DBuildings": shows3DBuildings,
            "showsPoi": showsPoi,
            "labelSize": labelSize,
            "showsBaseMap": showsBaseMap,
            "showsCompass": showsCompass,
            "compassOffset": compassOffset?.toMap(),
            "preferredFramesPerSecond": preferredFramesPerSecond,
            "logoCenter": logoCenter?.toMap(),
            "logoScale": logoScale,
            "zoomLevel": zoomLevel,
            "minZoomLevel": minZoomLevel,
            "maxZoomLevel": maxZoomLevel,
            "zoomEnabled": zoomEnabled,
            "keepCenterDuringZoom": keepCenterDuringZoom,
            "scrollEnabled": scrollEnabled,
            "overlookingEnabled": overlookingEnabled,
            "rotateEnabled": rotateEnabled,
            "alwaysTriggerDidTapCoordinateEnabled": alwaysTriggerDidTapCoordinateEnabled
        ]
        return map
    }
}

class TmClusterInfo: QMUAnnotation {
    
    var custom: Dictionary<String, Any>?
    var customId: String?
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy: TmClusterInfo = super.copy(with: zone) as! TmClusterInfo
        copy.custom = self.custom
        copy.customId = self.customId
        return copy
    }
    
    override func isEqual(_ object: Any!) -> Bool {
        if customId != (object as? TmClusterInfo)?.customId {
            return false
        }
        return super.isEqual(object)
    }
    
    static func fromMap(_ map: [String: Any]) -> TmClusterInfo {
        let info = TmClusterInfo()
        if let latLng = map["latLng"] as? [String: Any] {
            info.setCoordinate(CLLocationCoordinate2D.fromMap(latLng))
        }
        info.title = map["title"] as? String
        info.customId = map["customId"] as? String
        info.custom = map["custom"] as? Dictionary<String, Any>
        return info
    }
    
    func toMap() -> [String: Any?] {
        return [
            "latLng": coordinate.toMap(),
            "title": title,
            "customId": customId,
            "custom": custom
        ]
    }
}

extension QPoiInfo {
    static func fromMap(_ map: [String: Any]) -> QPoiInfo {
        let info = QPoiInfo()
        if let latLng = map["latLng"] as? [String: Any] {
            info.coordinate = CLLocationCoordinate2D.fromMap(latLng)
        }
        info.uid = map["uid"] as? String
        info.name = map["name"] as? String
        return info
    }
    
    func toMap() -> [String: Any?] {
        return [
            "uid": uid,
            "name": name,
            "latLng": coordinate.toMap()
        ]
    }
}

extension QMUClusterAnnotation {
    static func fromMap(_ map: [String: Any]) -> QMUClusterAnnotation {
        let annotation = QMUClusterAnnotation()
        if let latLng = map["latLng"] as? [String: Any] {
            annotation.setCoordinate(CLLocationCoordinate2D.fromMap(latLng))
        }
        var items = NSMutableSet()
        if let itemList = map["items"] as? Array<[String: Any]> {
            itemList.forEach { itemMap in
                items.add(TmClusterInfo.fromMap(itemMap))
            }
        }
        annotation.items = items
        return annotation
    }
    
    func toMap() -> [String: Any?] {
        var mapItems = Array<[String: Any?]>()
        items.forEach { item in
            if let i = item as? TmClusterInfo {
                mapItems.append(i.toMap())
            }
        }
        return [
            "latLng": coordinate.toMap(),
            "items": mapItems,
        ]
    }
}

class TmError {
    var code: Int?
    var message: String?
    
    init(code: Int? = nil, message: String? = nil) {
        self.code = code
        self.message = message
    }
    
    static func fromMap(_ map: [String: Any]) -> TmError {
        let error = TmError()
        error.code = map["code"] as? Int ?? 0
        error.message = map["message"] as? String ?? ""
        return error
    }
    
    func toMap() -> [String: Any?] {
        return [
            "code": code,
            "message": message,
        ]
    }
}
