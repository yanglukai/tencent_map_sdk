part of '../../tencent_map_sdk.dart';

class TencentMapLifecycleDispatcher {
  /// onStart
  Future<void> _resumed(MethodChannel mapChannel) async {
    try {
      await mapChannel.invokeMethod("TencentMapLifecycle_resumed");
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  /// paused
  Future<void> _paused(MethodChannel mapChannel) async {
    try {
      await mapChannel.invokeMethod("TencentMapLifecycle_paused");
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  /// detached
  Future<void> _detached(MethodChannel mapChannel) async {
    try {
      await mapChannel.invokeMethod("TencentMapLifecycle_detached");
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }
}
