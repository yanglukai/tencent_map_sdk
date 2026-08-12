#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint tencent_map_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'tencent_map_sdk'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # 引入第三方库
  s.dependency 'Tencent-MapSDK', '6.6.2'
  s.dependency 'Tencent-MapUtils', '1.2.4'
  s.static_framework = true # 明确声明该 pod 是静态的
  
  # 加载资源文件
  s. resource_bundles = {
    "tencent_map_sdk" => ['Resources/**/*']
  }

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
