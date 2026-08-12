import { abilityAccessCtrl, PermissionRequestResult, Permissions } from "@kit.AbilityKit"
import bundleManager from '@ohos.bundle.bundleManager'

// 申请定位权限
export async function reqLocationPermission(): Promise<boolean> {
  const context = getContext()
  if (!context) {
    console.error("[定位] 获取全局上下文失败")
    return false
  }
  const permissions: Array<Permissions> = ['ohos.permission.APPROXIMATELY_LOCATION', 'ohos.permission.LOCATION']
  const atManager = abilityAccessCtrl.createAtManager()
  let result: PermissionRequestResult | null | undefined
  try {
    result = await atManager.requestPermissionsFromUser(context, permissions)
  } catch (error) {
    console.error("定位权限申请异常: ", JSON.stringify(error))
    return false
  }
  if (!result) return false
  let isGranted = true
  result.permissions.forEach((permission, index) => {
    if (result?.authResults[index] !== bundleManager.PermissionGrantState.PERMISSION_GRANTED) {
      isGranted = false
      console.error(`权限【${permission}】申请失败`)
    }
  })
  return isGranted
}