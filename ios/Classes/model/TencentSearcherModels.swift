//
//  TencentMapConfig.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/1/15.
//

import QMapKit

extension QMSSuggestionSearchOption {
    static func fromMap(_ map: [String: Any]) -> QMSSuggestionSearchOption {
        let option = QMSSuggestionSearchOption()
        option.keyword = map["keyword"] as? String
        option.region = map["region"] as? String
        let location = map["location"] as? [String: Any]
        if let latitude = location?["latitude"] as? Double, let longitude = location?["longitude"] as? Double {
            option.location = "\(latitude),\(longitude)"
        }
        option.page_index = map["pageIndex"] as? NSNumber
        option.page_size = map["pageSize"] as? NSNumber
        return option
    }
    
    func toMap() -> [String: Any?] {
        let array = location.split(separator: ",")
        var map: [String: Any?] = [
            "keyword": keyword,
            "region": region,
            "pageIndex": page_index,
            "pageSize" : page_size
        ]
        var locationMap = [String: Any]()
        if array.count == 2 {
            locationMap["latitude"] = array[0]
            locationMap["longitude"] = array[1]
            map["location"] = locationMap
        }
        return map
    }
}

extension QMSSuggestionPoiData {
    
    static func fromMap(_ map: [String: Any]) -> QMSSuggestionPoiData {
        let poiData = QMSSuggestionPoiData()
        if let id = map["id"] as? String {
            poiData.id_ = id
        }
        if let locationMap = map["location"] as? [String: Any] {
            poiData.location = CLLocationCoordinate2D.fromMap(locationMap)
        }
        if let title = map["title"] as? String {
            poiData.title = title
        }
        if let address = map["address"] as? String {
            poiData.address = address
        }
        if let adcode = map["adcode"] as? NSNumber {
            poiData.adcode = adcode
        }
        if let province = map["province"] as? String {
            poiData.province = province
        }
        if let city = map["city"] as? String {
            poiData.city = city
        }
        if let district = map["district"] as? String {
            poiData.district = district
        }   
        return poiData
    }
    
    func toMap() -> [String: Any?] {
        let map: [String: Any?] = [
            "id": id_,
            "location": location.toMap(),
            "title": title,
            "address": address,
            "adcode": adcode,
            "province": province,
            "city": city,
            "district": district
        ]
        return map
    }
}

extension QMSDistrictData {
    static func fromMap(_ map: [String: Any]) -> QMSDistrictData {
        let data = QMSDistrictData()
        if let id = map["id"] as? String {
            data.id_ = id
        }
        if let locationMap = map["location"] as? [String: Any] {
            data.location = CLLocationCoordinate2D.fromMap(locationMap)
        }
        if let name = map["name"] as? String {
            data.name = name
        }
        if let fullname = map["fullName"] as? String {
            data.fullname = fullname
        }
        if let pinyin = map["pinyin"] as? Array<String> {
            data.pinyin = pinyin
        }
        return data
    }
    
    func toMap() -> [String: Any?] {
        let map: [String: Any?] = [
            "id": id_,
            "location": location.toMap(),
            "name": name,
            "fullName": fullname,
            "pinyin": pinyin
        ]
        return map
    }
}

extension QMSGeoCodeSearchOption {
    static func fromMap(_ map: [String: Any]) -> QMSGeoCodeSearchOption {
        let option = QMSGeoCodeSearchOption()
        if let address = map["address"] as? String {
            option.address = address
        }
        if let region = map["region"] as? String {
            option.region = region
        }
        return option
    }
    
    func toMap() -> [String: Any?] {
        let map: [String: Any?] = [
            "address": address,
            "region": region
        ]
        return map
    }
}

extension QMSAddressComponent {
    static func fromMap(_ map: [String: Any]) -> QMSAddressComponent {
        let address = QMSAddressComponent()
        if let nation = map["nation"] as? String {
            address.nation = nation
        }
        if let province = map["province"] as? String {
            address.province = province
        }
        if let city = map["city"] as? String {
            address.city = city
        }
        if let district = map["district"] as? String {
            address.district = district
        }
        if let street = map["street"] as? String {
            address.street = street
        }
        if let streetNumber = map["streetNumber"] as? String {
            address.street_number = streetNumber
        }
        return address
    }
    
    func toMap() -> [String: Any?] {
        let map: [String: Any?] = [
            "nation": nation,
            "province": province,
            "city": city,
            "district": district,
            "street": street,
            "streetNumber": street_number
        ]
        return map
    }
}

extension QMSGeoCodeSearchResult {
    static func fromMap(_ map: [String: Any]) -> QMSGeoCodeSearchResult {
        let result = QMSGeoCodeSearchResult()
        if let location = map["location"] as? [String: Any] {
            result.location = CLLocationCoordinate2D.fromMap(location)
        }
        if let addressComponents = map["addressComponents"] as? [String: Any] {
            result.address_components = QMSAddressComponent.fromMap(addressComponents)
        }
        return result
    }
    
    func toMap() -> [String: Any?] {
        let map: [String: Any?] = [
            "location": location.toMap(),
            "addressComponents": address_components.toMap()
        ]
        return map
    }
}


extension QMSReverseGeoCodeSearchOption {
    static func fromMap(_ map: [String: Any]) -> QMSReverseGeoCodeSearchOption {
        let option = QMSReverseGeoCodeSearchOption()
        if let location = map["location"] as? [String: Any] {
            option.setLocationWithCenter(CLLocationCoordinate2D.fromMap(location))
        }
        if let getPoi = map["getPoi"] as? Bool {
            option.get_poi = getPoi
        }
        return option
    }
    
    func toMap() -> [String: Any?] {
        // location=lat<纬度>,lng<经度>
        let latitude = location.split(separator: ",").first
        let longitude = location.split(separator: ",").last
        var map: [String: Any?] = [String: Any?]()
        if location.isEmpty == false {
            map["location"] = ["latitude": latitude, "longitude": longitude]
        }
        map["getPoi"] = get_poi
        return map
    }
}

extension QMSReverseGeoCodeSearchResult {
    static func fromMap(_ map: [String: Any]) -> QMSReverseGeoCodeSearchResult {
        let result = QMSReverseGeoCodeSearchResult()
        if let address = map["address"] as? String {
            result.address = address
        }
        if let addressComponents = map["addressComponents"] as? [String: Any] {
            result.address_component = QMSAddressComponent.fromMap(addressComponents)
        }
        if let poisArray = map["poisArray"] as? Array<[String: Any]> {
            result.poisArray = poisArray.map { QMSReGeoCodePoi.fromMap($0) }
        }
        if let poiCount = map["poiCount"] as? UInt {
            result.poi_count = poiCount
        }
        return result
    }
    
    func toMap() -> [String: Any?] {
        let map: [String: Any?] = [
            "address": address,
            "addressComponents": address_component.toMap(),
            "poisArray": poisArray?.map{ $0.toMap() },
            "poiCount": poi_count
        ]
        return map
    }
}

extension QMSReGeoCodePoi {
    static func fromMap(_ map: [String: Any]) -> QMSReGeoCodePoi {
        let poi = QMSReGeoCodePoi()
        if let id = map["id"] as? String {
            poi.id_ = id
        }
        if let location = map["location"] as? [String: Any] {
            poi.location = CLLocationCoordinate2D.fromMap(location)
        }
        if let title = map["title"] as? String {
            poi.title = title
        }
        if let address = map["address"] as? String {
            poi.address = address
        }
        let adInfo = QMSReGeoCodePoiAdInfo()
        if let adcode = map["adcode"] as? NSNumber {
            adInfo.adcode = adcode.stringValue
        }
        if let province = map["province"] as? String {
            adInfo.province = province
        }
        if let city = map["city"] as? String {
            adInfo.city = city
        }
        if let district = map["district"] as? String {
            adInfo.district = district
        }
        poi.ad_info = adInfo
        return poi
    }
    
    func toMap() -> [String: Any?] {
        let map: [String: Any?] = [
            "id": id_,
            "location": location.toMap(),
            "title": title,
            "address": address,
            "adcode": Int(ad_info?.adcode ?? "0"),
            "province": ad_info?.province,
            "city": ad_info?.city,
            "district": ad_info?.district
        ]
        return map
    }
}

extension QMSPoiExploreSearchOption {
    static func fromMap(_ map: [String: Any]) -> QMSPoiExploreSearchOption {
        let option = QMSPoiExploreSearchOption()
        var location: CLLocationCoordinate2D = CLLocationCoordinate2D()
        var radius: UInt = 500
        var autoExtend: Bool = true
        if let _location = map["location"] as? [String: Any] {
            location = CLLocationCoordinate2D.fromMap(_location)
        }
        if let _radius = map["radius"] as? UInt {
            radius = _radius
        }
        if let _autoExtend = map["autoExtend"] as? Bool {
            autoExtend = _autoExtend
        }
        option.setBoundaryByNearbyWithCenter(location, radius: radius, autoExtend: autoExtend)
        if let policy = map["policy"] as? Int32 {
            option.policy = policy
        }
        if let orderbyDistance = map["orderbyDistance"] as? Bool, orderbyDistance == true {
            option.orderby = "_distance"
        }
        if let pageSize = map["pageSize"] as? UInt {
            option.page_size = pageSize
        }
        if let pageIndex = map["pageIndex"] as? UInt {
            option.page_index = pageIndex
        }
        return option
    }
    
    func toMap() -> [String: Any?] {
        let map: [String: Any?] = [String: Any?]()
        return map
    }
}

extension QMSPoiData {
    static func fromMap(_ map: [String: Any]) -> QMSPoiData {
        let poi = QMSPoiData()
        if let id = map["id"] as? String {
            poi.id_ = id
        }
        if let location = map["location"] as? [String: Any] {
            poi.location = CLLocationCoordinate2D.fromMap(location)
        }
        if let title = map["title"] as? String {
            poi.title = title
        }
        if let address = map["address"] as? String {
            poi.address = address
        }
        let adInfo = QMSPoiAdInfo()
        if let adcode = map["adcode"] as? NSNumber {
            adInfo.adcode = adcode
        }
        if let province = map["province"] as? String {
            adInfo.province = province
        }
        if let city = map["city"] as? String {
            adInfo.city = city
        }
        if let district = map["district"] as? String {
            adInfo.district = district
        }
        poi.ad_info = adInfo
        return poi
    }
    
    func toMap() -> [String: Any?] {
        let map: [String: Any?] = [
            "id": id_,
            "location": location.toMap(),
            "title": title,
            "address": address,
            "adcode": ad_info.adcode.intValue,
            "province": ad_info.province,
            "city": ad_info.city,
            "district": ad_info.district
        ]
        return map
    }
}
