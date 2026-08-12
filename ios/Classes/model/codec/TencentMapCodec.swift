//
//  TencentMapCodec.swift
//  Runner
//
//  Created by EPBJ00225 on 2026/1/15.
//

import Flutter
import QMapKit
import QMapSDKUtils

class TencentMapMethodCodec: FlutterStandardMethodCodec {
    static let shared = TencentMapMethodCodec(readerWriter: TencentMapCodecReaderWriter())
}

class TencentMapMessageCodec: FlutterStandardMessageCodec {
    static let shared = TencentMapMessageCodec(readerWriter: TencentMapCodecReaderWriter())
}

private class TencentMapCodecReaderWriter: FlutterStandardReaderWriter {
    override func reader(with data: Data) -> FlutterStandardReader {
        return TencentMapCodecReader(data: data)
    }
    
    override func writer(with data: NSMutableData) -> FlutterStandardWriter {
        return TencentMapCodecWriter(data: data)
    }
}

private class TencentMapCodecReader: FlutterStandardReader {
    override func readValue(ofType type: UInt8) -> Any? {
        switch type {
        case 150:
            return QMapType(rawValue: readValue() as! UInt)
        case 151:
            return TmConfig.fromMap(readValue() as! [String: Any])
        case 152:
            return CGPoint.fromMap(readValue() as! [String: Any])
        case 153:
            return CLLocationCoordinate2D.fromMap(readValue() as! [String: Any])
        case 154:
            return TmClusterInfo.fromMap(readValue() as! [String: Any])
        case 155:
            return QPoiInfo.fromMap(readValue() as! [String: Any])
        case 156:
            return QMUClusterAnnotation.fromMap(readValue() as! [String: Any])
        case 157:
            return TmError.fromMap(readValue() as! [String: Any])
        case 158:
            return QMSSuggestionSearchOption.fromMap(readValue() as! [String: Any])
        case 159:
            return QMSSuggestionPoiData.fromMap(readValue() as! [String: Any])
        case 160:
            return QMSDistrictData.fromMap(readValue() as! [String: Any])
        case 161:
            return QMSGeoCodeSearchOption.fromMap(readValue() as! [String: Any])
        case 162:
            return QMSAddressComponent.fromMap(readValue() as! [String: Any])
        case 163:
            return QMSGeoCodeSearchResult.fromMap(readValue() as! [String: Any])
        case 164:
            return QMSReverseGeoCodeSearchOption.fromMap(readValue() as! [String: Any])
        case 165:
            return QMSReverseGeoCodeSearchResult.fromMap(readValue() as! [String: Any])
        case 166:
            return QMSPoiExploreSearchOption.fromMap(readValue() as! [String: Any])
        default:
            return super.readValue(ofType: type)
        }
    }
}

private class TencentMapCodecWriter: FlutterStandardWriter {
    override func writeValue(_ value: Any) {
        if let value = value as? QMapType {
            writeByte(150)
            writeValue(value.rawValue)
        } else if let value = value as? TmConfig {
            writeByte(151)
            writeValue(value.toMap())
        } else if let value = value as? CGPoint {
            writeByte(152)
            writeValue(value.toMap())
        } else if let value = value as? CLLocationCoordinate2D {
            writeByte(153)
            writeValue(value.toMap())
        } else if let value = value as? TmClusterInfo {
            writeByte(154)
            writeValue(value.toMap())
        } else if let value = value as? QPoiInfo {
            writeByte(155)
            writeValue(value.toMap())
        } else if let value = value as? QMUClusterAnnotation {
            writeByte(156)
            writeValue(value.toMap())
        } else if let value = value as? TmError {
            writeByte(157)
            writeValue(value.toMap())
        } else if let value = value as? QMSSuggestionSearchOption {
            writeByte(158)
            writeValue(value.toMap())
        } else if let value = value as? QMSSuggestionPoiData {
            writeByte(159)
            writeValue(value.toMap())
        } else if let value = value as? QMSDistrictData {
            writeByte(160)
            writeValue(value.toMap())
        } else if let value = value as? QMSGeoCodeSearchOption {
            writeByte(161)
            writeValue(value.toMap())
        } else if let value = value as? QMSAddressComponent {
            writeByte(162)
            writeValue(value.toMap())
        } else if let value = value as? QMSGeoCodeSearchResult {
            writeByte(163)
            writeValue(value.toMap())
        } else if let value = value as? QMSReverseGeoCodeSearchOption {
            writeByte(164)
            writeValue(value.toMap())
        } else if let value = value as? QMSReverseGeoCodeSearchResult {
            writeByte(165)
            writeValue(value.toMap())
        } else if let value = value as? QMSPoiExploreSearchOption {
            writeByte(166)
            writeValue(value.toMap())
        } else if let value = value as? QMSPoiData {
            writeByte(159)
            writeValue(value.toMap())
        } else {
            super.writeValue(value)
        }
    }
}


