import { Any, ByteBuffer, StandardMessageCodec } from "@ohos/flutter_ohos";
import { TmClusterAnnotation, TmClusterInfo,
  TmConfig,
  TmError, TmLatLng, TmPoiInfo, TmPoint } from "../TencentMapModels";

export default class TencentMapCodec extends StandardMessageCodec  {

  readValueOfType(type: number, buffer: ByteBuffer): Any {
    switch (type) {
      case 151: {
        return TmConfig.fromMap(this.readValue(buffer))
      }
      case 152: {
        return TmPoint.fromMap(this.readValue(buffer))
      }
      case 153: {
        return TmLatLng.fromMap(this.readValue(buffer))
      }
      case 154: {
        return TmClusterInfo.fromMap(this.readValue(buffer))
      }
      case 155: {
        return TmPoiInfo.fromMap(this.readValue(buffer))
      }
      case 156: {
        return TmClusterAnnotation.fromMap(this.readValue(buffer))
      }
      case 157: {
        return TmError.fromMap(this.readValue(buffer))
      }
      default:
        return super.readValueOfType(type, buffer)
    }
  }

  writeValue(stream: ByteBuffer, value: Any): Any {
    if (value instanceof TmConfig) {
      stream.writeInt8(151)
      this.writeValue(stream, value.toMap())
    } else if (value instanceof TmPoint) {
      stream.writeInt8(152)
      this.writeValue(stream, value.toMap())
    } else if (value instanceof TmLatLng) {
      stream.writeInt8(153)
      this.writeValue(stream, value.toMap())
    } else if (value instanceof TmClusterInfo) {
      stream.writeInt8(154)
      this.writeValue(stream, value.toMap())
    } else if (value instanceof TmPoiInfo) {
      stream.writeInt8(155)
      this.writeValue(stream, value.toMap())
    } else if (value instanceof TmClusterAnnotation) {
      stream.writeInt8(156)
      this.writeValue(stream, value.toMap())
    } else if (value instanceof TmError) {
      stream.writeInt8(157)
      this.writeValue(stream, value.toMap())
    } else {
      return super.writeValue(stream, value)
    }
  }
}
