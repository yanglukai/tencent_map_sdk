import { MethodCallHandler, MethodCall, MethodResult } from "@ohos/flutter_ohos"
import { AuthService } from "@tencentmap/base"
import { Privacy } from '@tencentmap/map'
import { reqLocationPermission } from "../util/TencentMapUtil"
import { TAG } from "../TencentMapPlugin"
import { TencentLocationSDK } from "@tencentmap/location_sdk"

export default class TencentMapPluginHandlerImpl implements MethodCallHandler {

  static tencentSdkKey: string | null

  async onMethodCall(call: MethodCall, result: MethodResult): Promise<void> {
    console.log(TAG, call.method)

    switch (call.method) {
      case "setPrivacyAgreement":
        {
          const isAgree: boolean = call.args
          TencentLocationSDK.setPrivacyPolicyAgreement(isAgree)
          Privacy.setUserAgreePrivacy(isAgree)
          result.success(null)
          break
        }

      case "setApiKey":
        {
          const key: string = call.args
          AuthService.getInstance().setKey(key)
          TencentMapPluginHandlerImpl.tencentSdkKey = key
          result.success(null)
          break
        }

      case "requestLocationAuthorization":
        {
          const res: boolean = await reqLocationPermission()
          result.success(res)
          break
        }

      default :
        result.notImplemented()
        break
    }
  }
}