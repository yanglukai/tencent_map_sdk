import 'package:flutter_test/flutter_test.dart';
import 'package:tencent_map_sdk/tencent_map.dart';
import 'package:tencent_map_sdk/tencent_map_platform_interface.dart';
import 'package:tencent_map_sdk/tencent_map_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTencentMapPlatform
    with MockPlatformInterfaceMixin
    implements TencentMapPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TencentMapPlatform initialPlatform = TencentMapPlatform.instance;

  test('$MethodChannelTencentMap is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTencentMap>());
  });

  test('getPlatformVersion', () async {
    TencentMap tencentMapPlugin = TencentMap();
    MockTencentMapPlatform fakePlatform = MockTencentMapPlatform();
    TencentMapPlatform.instance = fakePlatform;

    expect(await tencentMapPlugin.getPlatformVersion(), '42');
  });
}
