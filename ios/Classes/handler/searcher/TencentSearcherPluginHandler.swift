//
//  TencentSearcherPluginHandler.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/3/10.
//

import Flutter
import QMapKit

class TencentSearcherPluginHandler: NSObject {
    
    private let channel: FlutterMethodChannel
    
    private lazy var mySearcher: QMSSearcher = QMSSearcher(delegate: self)
    private var _suggestionSearchResult: FlutterResult?
    private var _districtSearchResult: FlutterResult?
    private var _geoCodeSearchResult: FlutterResult?
    private var _reverseGeoCodeSearchResult: FlutterResult?
    private var _poiSearchResult: FlutterResult?
    
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
            
        case "setApiKey":
            guard let arg = call.arguments as? Dictionary<String, Any> else {
                return
            }
            if let apiKey = arg["apiKey"] as? String {
                QMSSearchServices.shared().apiKey = apiKey
            }
            if let secretKey = arg["secretKey"] as? String {
                QMSSearchServices.shared().secretKey = secretKey
            }
            result(nil)
            
        case "searchWithSuggestionSearchOption":
            guard let option = call.arguments as? QMSSuggestionSearchOption else {
                result(nil)
                return
            }
            _suggestionSearchResult = result
            mySearcher.searchWithSuggestionSearchOption(option)
            
        case "searchWithDistrictList":
            _districtSearchResult = result
            let listOpt = QMSDistrictListSearchOption()
            mySearcher.searchWithDistrictListSearchOption(listOpt)
            
        case "searchWithGeoCodeSearchOption":
            guard let option = call.arguments as? QMSGeoCodeSearchOption else {
                result(nil)
                return
            }
            _geoCodeSearchResult = result
            mySearcher.searchWithGeoCodeSearchOption(option)
            
        case "searchWithReverseGeoCodeSearchOption":
            guard let option = call.arguments as? QMSReverseGeoCodeSearchOption else {
                result(nil)
                return
            }
            _reverseGeoCodeSearchResult = result
            mySearcher.searchWithReverseGeoCodeSearchOption(option)
            
        case "searchWithPoiExploreSearchOption":
            guard let option = call.arguments as? QMSPoiExploreSearchOption else {
                result(nil)
                return
            }
            _poiSearchResult = result
            mySearcher.searchWithPoiExploreSearchOption(option)
         
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

extension TencentSearcherPluginHandler: QMSSearchDelegate {
    func search(with suggestionSearchOption: QMSSuggestionSearchOption, didReceive suggestionSearchResult: QMSSuggestionResult) {
        _suggestionSearchResult?(suggestionSearchResult.dataArray)
        _suggestionSearchResult = nil
    }
    
    func search(withDistrictSearchOption districtSearchOption: QMSDistrictBaseSearchOption, didRecevieResult districtSearchResult: QMSDistrictSearchResult) {
        _districtSearchResult?(districtSearchResult.result)
        _districtSearchResult = nil
    }
    
    func search(with geoCodeSearchOption: QMSGeoCodeSearchOption, didReceive geoCodeSearchResult: QMSGeoCodeSearchResult) {
        _geoCodeSearchResult?(geoCodeSearchResult)
        _geoCodeSearchResult = nil
    }
    
    func search(with reverseGeoCodeSearchOption: QMSReverseGeoCodeSearchOption, didReceive reverseGeoCodeSearchResult: QMSReverseGeoCodeSearchResult) {
        _reverseGeoCodeSearchResult?(reverseGeoCodeSearchResult)
        _reverseGeoCodeSearchResult = nil
    }
    
    func search(with poiExploreSearchOption: QMSPoiExploreSearchOption, didReceive poiSearchResult: QMSPoiSearchResult) {
        _poiSearchResult?(poiSearchResult.dataArray)
        _poiSearchResult = nil
    }
    
    func search(with searchOption: QMSSearchOption, didFailWithError error: any Error) {
        print(error.localizedDescription)
        _suggestionSearchResult?(nil)
        _districtSearchResult?(nil)
        _geoCodeSearchResult?(nil)
        _reverseGeoCodeSearchResult?(nil)
        _poiSearchResult?(nil)
    }
}
