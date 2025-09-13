Pod::Spec.new do |s|
  s.name             = 'Flutter'
  s.version          = '1.0.0'
  s.summary          = 'Flutter'
  s.description      = 'Flutter'
  s.homepage         = 'https://flutter.dev'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Flutter Dev Team' => 'flutter-dev@googlegroups.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  
  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
end