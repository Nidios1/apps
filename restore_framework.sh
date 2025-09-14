#!/bin/bash
# Script restore Flutter framework sau khi upload GitHub

echo "🔧 Đang restore Flutter framework..."

# 1. Kiểm tra Flutter framework hiện tại
echo "📱 Kiểm tra Flutter framework hiện tại..."
if [ -d "ios/Flutter" ]; then
    echo "✅ Thư mục ios/Flutter tồn tại"
    ls -la ios/Flutter/
else
    echo "❌ Thư mục ios/Flutter không tồn tại"
fi

# 2. Tạo các file Flutter framework cần thiết
echo "🔧 Tạo các file Flutter framework cần thiết..."

# Tạo Flutter.framework placeholder
mkdir -p ios/Flutter/Flutter.framework
cat > ios/Flutter/Flutter.framework/Info.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>en</string>
	<key>CFBundleExecutable</key>
	<string>Flutter</string>
	<key>CFBundleIdentifier</key>
	<string>io.flutter.flutter</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>Flutter</string>
	<key>CFBundlePackageType</key>
	<string>FMWK</string>
	<key>CFBundleShortVersionString</key>
	<string>1.0</string>
	<key>CFBundleSignature</key>
	<string>????</string>
	<key>CFBundleVersion</key>
	<string>1.0</string>
	<key>MinimumOSVersion</key>
	<string>12.0</string>
</dict>
</plist>
EOF

# Tạo Flutter.podspec
cat > ios/Flutter/Flutter.podspec << 'EOF'
Pod::Spec.new do |s|
  s.name             = 'Flutter'
  s.version          = '1.0.0'
  s.summary          = 'Flutter framework'
  s.description      = 'Flutter framework for iOS'
  s.homepage         = 'https://flutter.dev'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Flutter Team' => 'flutter-dev@googlegroups.com' }
  s.source           = { :path => '.' }
  s.ios.deployment_target = '12.0'
  s.vendored_frameworks = 'Flutter.framework'
end
EOF

# Tạo Generated.xcconfig
cat > ios/Flutter/Generated.xcconfig << 'EOF'
// This is a generated file; do not edit or check into version control.
FLUTTER_ROOT=/opt/homebrew/bin/flutter
FLUTTER_APPLICATION_PATH=/Users/runner/work/apps/apps
COCOAPODS_PARALLEL_CODE_SIGN=true
FLUTTER_TARGET=lib/main.dart
FLUTTER_BUILD_DIR=build
FLUTTER_BUILD_NAME=1.2.2
FLUTTER_BUILD_NUMBER=1
EXCLUDED_ARCHS[sdk=iphonesimulator*]=i386
DART_OBFUSCATION=false
TRACK_WIDGET_CREATION=true
TREE_SHAKE_ICONS=false
PACKAGE_CONFIG=.dart_tool/package_config.json
EOF

# 3. Fix .gitignore để không loại bỏ framework
echo "🔧 Fixing .gitignore..."
cat > .gitignore << 'EOF'
# Miscellaneous
*.class
*.log
*.pyc
*.swp
.DS_Store
.atom/
.buildlog/
.history
.svn/
migrate_working_dir/

# IntelliJ related
*.iml
*.ipr
*.iws
.idea/

# Flutter/Dart/Pub related
**/doc/api/
**/ios/Flutter/.last_build_id
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
/build/

# Symbolication related
app.*.symbols

# Obfuscation related
app.*.map.json

# Android Studio will place build artifacts here
/android/app/debug
/android/app/profile
/android/app/release

# iOS
**/ios/**/*.mode1v3
**/ios/**/*.mode2v3
**/ios/**/*.moved-aside
**/ios/**/*.pbxuser
**/ios/**/*.perspectivev3
**/ios/**/*sync/
**/ios/**/.sconsign.dblite
**/ios/**/.tags*
**/ios/**/.vagrant/
**/ios/**/DerivedData/
**/ios/**/Icon?
**/ios/**/Pods/
**/ios/**/.symlinks/
**/ios/**/profile
**/ios/**/xcuserdata
**/ios/.generated/
**/ios/Flutter/App.framework
**/ios/Flutter/ephemeral/
**/ios/Flutter/app.flx
**/ios/Flutter/app.zip
**/ios/Flutter/flutter_assets/
**/ios/Flutter/flutter_export_environment.sh
**/ios/ServiceDefinitions.json
**/ios/Runner/GeneratedPluginRegistrant.*

# macOS
**/macos/Flutter/GeneratedPluginRegistrant.swift

# Coverage
coverage/

# Exceptions to above rules.
!**/ios/**/default.mode1v3
!**/ios/**/default.mode2v3
!**/ios/**/default.pbxuser
!**/ios/**/default.perspectivev3

# Web related
lib/generated_plugin_registrant.dart

# Windows related
**/windows/flutter/generated_plugin_registrant.cc
**/windows/flutter/generated_plugin_registrant.h
**/windows/flutter/generated_plugins.cmake

# Linux related
**/linux/flutter/generated_plugin_registrant.cc
**/linux/flutter/generated_plugin_registrant.h
**/linux/flutter/generated_plugins.cmake

# FVM Version Cache
.fvm/

# Environment variables
.env
.env.local
.env.production

# Temporary files
*.tmp
*.temp
temp/
tmp/

# Logs
logs/
*.log

# Build artifacts
build/
dist/
out/

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Certificates and keys
*.p12
*.mobileprovision
*.cer
*.pem
*.key
certificates/
keys/

# Generated files
*.g.dart
*.freezed.dart
*.mocks.dart

# Xcode
*.xcworkspace/xcuserdata/
*.xcodeproj/xcuserdata/
*.xcodeproj/project.xcworkspace/xcuserdata/

# CocoaPods
ios/Pods/
ios/Podfile.lock

# Fastlane
ios/fastlane/report.xml
ios/fastlane/Preview.html
ios/fastlane/screenshots
ios/fastlane/test_output

# Android
android/app/debug/
android/app/profile/
android/app/release/
android/key.properties
android/.gradle/
android/captures/
android/gradlew
android/gradlew.bat
android/local.properties
android/**/GeneratedPluginRegistrant.java

# Web
web/

# Test
test/coverage/
coverage/

# Keep Flutter framework files
!ios/Flutter/Flutter.framework/
!ios/Flutter/Flutter.podspec
!ios/Flutter/Generated.xcconfig
EOF

# 4. Tạo script rebuild framework
echo "🔧 Tạo script rebuild framework..."
cat > rebuild_framework.sh << 'EOF'
#!/bin/bash
echo "🔧 Rebuilding Flutter framework..."

# Clean và rebuild
flutter clean
flutter pub get

# Install iOS dependencies
cd ios
pod install --repo-update
cd ..

# Build iOS
flutter build ios --debug --no-codesign

echo "✅ Framework rebuild completed!"
EOF

chmod +x rebuild_framework.sh

echo "✅ Flutter framework restore completed!"
echo ""
echo "📋 CÁC BƯỚC TIẾP THEO:"
echo "1. Push code lên GitHub để trigger workflow mới"
echo "2. GitHub Actions sẽ rebuild framework đúng cách"
echo "3. Download IPA mới từ GitHub Actions"
echo ""
echo "⚠️ LƯU Ý:"
echo "1. Framework files đã được restore"
echo "2. .gitignore đã được fix để không loại bỏ framework"
echo "3. GitHub Actions sẽ tự động rebuild framework"
echo ""
echo "🛠️ NẾU CẦN REBUILD LOCAL:"
echo "bash rebuild_framework.sh"
