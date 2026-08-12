part of '../../tencent_map_sdk.dart';

class TencentMapPlugin {
  final MethodChannel _channel = const MethodChannel(
      "eplbks.tencent_map_plugin", StandardMethodCodec(TencentMapCodec()));

  TencentMapPlugin._internal() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  /// 隐私合规接口, 必须在地图初始化前调用, 默认为false
  Future<void> setPrivacyAgreement(bool isAgree) async {
    try {
      await _channel.invokeMethod('setPrivacyAgreement', isAgree);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  /// 配置开发秘钥, 必须在地图初始化前调用
  Future<void> setApiKey(String apiKey) async {
    try {
      await _channel.invokeMethod('setApiKey', apiKey);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  /// 申请定位权限
  Future<bool> requestLocationAuthorization() async {
    bool result = false;
    try {
      result = await _channel.invokeMethod('requestLocationAuthorization');
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case '':
        break;
      default:
        throw MissingPluginException();
    }
  }

  factory TencentMapPlugin() => _getInstance();
  static TencentMapPlugin? _instance;
  static TencentMapPlugin get instance => _getInstance();
  static TencentMapPlugin _getInstance() {
    _instance ??= TencentMapPlugin._internal();
    return _instance!;
  }
}
