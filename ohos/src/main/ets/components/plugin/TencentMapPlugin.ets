
import { FlutterPlugin, FlutterPluginBinding, MethodChannel, StandardMessageCodec,} from "@ohos/flutter_ohos";
import TencentMapPluginHandlerImpl from "./handler/TencentMapPluginHandlerImpl";
import { TencentMapFactory } from "./map/TencentMapFactory";

export const TAG = "TencentMapPlugin"

export default  class TencentMapPlugin implements FlutterPlugin {
  private methodChannel: MethodChannel | null = null
  private handler: TencentMapPluginHandlerImpl | null = null

  getUniqueClassName(): string {
    return "TencentMapPlugin"
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    // mapView
    binding.getPlatformViewRegistry()?.registerViewFactory("eplbks.tencent_map_view", new TencentMapFactory(binding.getBinaryMessenger(), StandardMessageCodec.INSTANCE))

    this.methodChannel = new MethodChannel(binding.getBinaryMessenger(), "eplbks.tencent_map_plugin")
    this.handler = new TencentMapPluginHandlerImpl()
    this.methodChannel.setMethodCallHandler(this.handler)
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.methodChannel != null) {
      this.methodChannel.setMethodCallHandler(null)
      this.handler = null
    }
  }

}