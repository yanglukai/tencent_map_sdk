package com.tencent_map.bean

import com.tencent.lbssearch.httpresponse.AdInfo
import com.tencent.lbssearch.httpresponse.Poi
import com.tencent.lbssearch.`object`.param.Address2GeoParam
import com.tencent.lbssearch.`object`.param.ExploreParam
import com.tencent.lbssearch.`object`.param.Geo2AddressParam
import com.tencent.lbssearch.`object`.param.SuggestionParam
import com.tencent.lbssearch.`object`.result.Address2GeoResultObject.Address2GeoResult
import com.tencent.lbssearch.`object`.result.AddressComponent
import com.tencent.lbssearch.`object`.result.DistrictResultObject.DistrictResult
import com.tencent.lbssearch.`object`.result.ExploreResultObject
import com.tencent.lbssearch.`object`.result.Geo2AddressResultObject.ReverseAddressResult
import com.tencent.lbssearch.`object`.result.SuggestionResultObject.SuggestionData

fun SuggestionParam.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    return map
}

fun SuggestionParam(map: Map<String, Any?>): SuggestionParam {
    val keyword = map["keyword"] as? String
    val region = map["region"] as? String
    val locationMap = map["location"] as? Map<String, Any>
    val pageIndex = map["pageIndex"] as? Int
    val pageSize = map["pageSize"] as? Int

    val params = SuggestionParam(keyword, region)
    locationMap?.let { params.location(LatLng(it)) }
    pageIndex?.let { params.pageIndex(it) }
    pageSize?.let { params.pageSize(it) }
    return params
}

fun SuggestionData.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    map["id"] = id
    map["location"] = latLng.toMap()
    map["title"] = title
    map["address"] = address
    map["adcode"] = adcode.toIntOrNull()
    map["province"] = province
    map["city"] = city
    map["district"] = district
    return map
}

fun SuggestionData(map: Map<String, Any?>): SuggestionData {
    val id = map["id"] as? String
    val locationMap = map["location"] as? Map<String, Any>
    val title = map["title"] as? String
    val address = map["address"] as? String
    val adcode = map["adcode"] as? Int
    val province = map["province"] as? String
    val city = map["city"] as? String
    val district = map["district"] as? String

    val data = SuggestionData()
    data.id = id
    locationMap?.let { data.latLng = LatLng(it) }
    data.title = title
    data.address = address
    data.adcode = adcode.toString()
    data.province = province
    data.city = city
    data.district = district
    return data
}

fun DistrictResult.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    map["id"] = id.toString();
    map["name"] = name;
    map["fullName"] = fullname;
    map["location"] = latLng?.toMap();
    map["pinyin"] = pinyin;
    return map
}

fun DistrictResult(map: Map<String, Any?>): DistrictResult {
    val id = map["id"] as? String
    val name = map["name"] as? String
    val fullName = map["fullName"] as? String
    val locationMap = map["location"] as? Map<String, Any>
    val pinyin = map["pinyin"] as? List<String>

    val data = DistrictResult()
    id?.let { data.id = it.toInt() }
    data.name = name
    data.fullname = fullName
    locationMap?.let { data.latLng = LatLng(it) }
    data.pinyin = pinyin
    return data
}

fun Address2GeoParam.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    return map
}

fun Address2GeoParam(map: Map<String, Any?>): Address2GeoParam {
    val region = map["region"] as? String
    val address = map["address"] as? String

    val param = Address2GeoParam()
    region?.let { param.region( it ) }
    address?.let { param.address( it ) }
    return param
}

fun AddressComponent.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    map["nation"] = nation
    map["province"] = province
    map["city"] = city
    map["district"] = district
    map["street"] = street
    map["streetNumber"] = street_number
    return map
}

fun AddressComponent(map: Map<String, Any?>): AddressComponent {
    val nation = map["nation"] as? String
    val province = map["province"] as? String
    val city = map["city"] as? String
    val district = map["district"] as? String
    val street = map["street"] as? String
    val streetNumber = map["streetNumber"] as? String

    val address = AddressComponent()
    address.nation = nation
    address.province = province
    address.city = city
    address.district = district
    address.street = street
    address.street_number = streetNumber
    return address
}

fun Address2GeoResult.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    map["location"] = latLng.toMap()
    map["addressComponents"] = address_components.toMap()
    return map
}

fun Address2GeoResult(map: Map<String, Any?>): Address2GeoResult {
    val location = map["location"] as? Map<String, Any>
    val addressComponents = map["addressComponents"] as? Map<String, Any>

    val result = Address2GeoResult()
    location?.let { result.latLng = LatLng(it) }
    addressComponents?.let { result.address_components = AddressComponent(it) }
    return result
}

fun Geo2AddressParam.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    return map
}

fun Geo2AddressParam(map: Map<String, Any?>): Geo2AddressParam {
    val location = map["location"] as? Map<String, Any>
    val getPoi = map["getPoi"] as? Boolean

    val param = Geo2AddressParam()
    location?.let { param.location(LatLng(it)) }
    getPoi?.let { param.getPoi(it) }
    return param
}

fun ReverseAddressResult.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    map["address"] = address
    map["addressComponents"] = address_component.toMap()
    map["poisArray"] = pois.map { it.toMap() }
    map["poiCount"] = poi_count
    return map
}

fun ReverseAddressResult(map: Map<String, Any?>): ReverseAddressResult {
    val address = map["address"] as? String
    val addressComponents = map["addressComponents"] as? Map<String, Any>
    val poisArray = map["poisArray"] as? Array<Map<String, Any>>
    val poiCount = map["poiCount"] as? Int

    val result = ReverseAddressResult()
    result.address = address
    addressComponents?.let { result.address_component = AddressComponent(it) }
    poisArray?.let { result.pois = it.map { Poi(it) } }
    poiCount?.let { result.poi_count = it }
    return result
}

fun Poi.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    map["id"] = id
    map["location"] = latLng.toMap()
    map["title"] = title
    map["address"] = address
    map["adcode"] = ad_info.adcode.toIntOrNull()
    map["province"] = ad_info.province
    map["city"] = ad_info.city
    map["district"] = ad_info.district
    return map
}

fun Poi(map: Map<String, Any?>): Poi {
    val id = map["id"] as? String
    val location = map["location"] as? Map<String, Any>
    val title = map["title"] as? String
    val address = map["address"] as? String
    val adcode = map["adcode"] as? Number
    val province = map["province"] as? String
    val city = map["city"] as? String
    val district = map["district"] as? String

    val poi = Poi()
    poi.id = id
    location?.let { poi.latLng = LatLng(it) }
    poi.title = title
    poi.address = address
    val adInfo = AdInfo()
    adInfo.adcode = adcode.toString()
    adInfo.province = province
    adInfo.city = city
    adInfo.district = district
    poi.ad_info = adInfo
    return poi
}

fun ExploreParam.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    return map
}

fun ExploreParam(map: Map<String, Any?>): ExploreParam {
    val location = map["location"] as? Map<String, Any> ?: mutableMapOf()
    val radius = map["radius"] as? Int ?: 500
    val autoExtend = map["autoExtend"] as? Boolean ?: true
    val policy = map["policy"] as? Int
    val orderbyDistance = map["orderbyDistance"] as? Boolean
    val pageSize = map["pageSize"] as? Int
    val pageIndex = map["pageIndex"] as? Int
    val nearby = ExploreParam.Nearby(LatLng(location ), radius).autoExtend(autoExtend)
    val param = ExploreParam(nearby)
    policy?.let {
        param.policy(when (it) {
            1 -> ExploreParam.Policy.DEFAULT
            2 -> ExploreParam.Policy.SHARE_LOCATION
            else -> ExploreParam.Policy.DEFAULT
        })
    }
    orderbyDistance?.let { param.orderby(it) }
    pageSize?.let { param.pageSize(it) }
    pageIndex?.let { param.pageIndex(it) }
    return param
}

fun ExploreResultObject.SearchResultData.toMap(): Map<String, Any?> {
    val map: MutableMap<String, Any?> = mutableMapOf()
    map["id"] = id
    map["location"] = latLng.toMap()
    map["title"] = title
    map["address"] = address
    map["adcode"] = ad_info.adcode.toIntOrNull()
    map["province"] = ad_info.province
    map["city"] = ad_info.city
    map["district"] = ad_info.district
    return map
}

fun SearchResultData(map: Map<String, Any?>): ExploreResultObject.SearchResultData {
    val id = map["id"] as? String
    val location = map["location"] as? Map<String, Any>
    val title = map["title"] as? String
    val address = map["address"] as? String
    val adcode = map["adcode"] as? Number
    val province = map["province"] as? String
    val city = map["city"] as? String
    val district = map["district"] as? String

    val poi = ExploreResultObject.SearchResultData()
    poi.id = id
    location?.let { poi.latLng = LatLng(it) }
    poi.title = title
    poi.address = address
    val adInfo = AdInfo()
    adInfo.adcode = adcode.toString()
    adInfo.province = province
    adInfo.city = city
    adInfo.district = district
    poi.ad_info = adInfo
    return poi
}