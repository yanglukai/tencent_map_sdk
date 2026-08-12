import { PlatformView, PlatformViewFactory, BinaryMessenger, MessageCodec, Any } from "@ohos/flutter_ohos";
import common from "@ohos.app.ability.common";
import TencentMapView from "./TencentMapView";

export class TencentMapFactory extends PlatformViewFactory {

  private message: BinaryMessenger

  constructor(message: BinaryMessenger, createArgsCodes: MessageCodec<Object>) {
    super(createArgsCodes)
    this.message = message
  }

  public create(context: common.Context, viewId: number, args: Any): PlatformView {
    return new TencentMapView(context, viewId, args, this.message)
  }
}