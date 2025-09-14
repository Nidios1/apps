#!/bin/bash
# Script fix lỗi cài đặt iOS app - FINAL FIX

echo "🚨 Đang fix lỗi cài đặt iOS app - FINAL FIX..."

# 1. Clean everything completely
echo "🧹 Cleaning everything completely..."
flutter clean
rm -rf ios/Pods
rm -rf ios/Podfile.lock
rm -rf ios/.symlinks
rm -rf ios/Flutter/Flutter.framework
rm -rf ios/Flutter/Flutter.podspec
rm -rf ios/Flutter/Generated.xcconfig
rm -rf build/

# 2. Recreate Flutter project structure
echo "📱 Recreating Flutter project structure..."
flutter create --platforms=ios --project-name=ppapikey_mobile .

# 3. Fix Info.plist with correct Bundle ID and version
echo "🔧 Fixing Info.plist..."
cat > ios/Runner/Info.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDevelopmentRegion</key>
	<string>en</string>
	<key>CFBundleDisplayName</key>
	<string>PPAPIKey Mobile</string>
	<key>CFBundleExecutable</key>
	<string>$(EXECUTABLE_NAME)</string>
	<key>CFBundleIdentifier</key>
	<string>com.ppapikey.dev</string>
	<key>CFBundleInfoDictionaryVersion</key>
	<string>6.0</string>
	<key>CFBundleName</key>
	<string>ppapikey_mobile</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>1.2.2</string>
	<key>CFBundleSignature</key>
	<string>????</string>
	<key>CFBundleVersion</key>
	<string>1</string>
	<key>LSRequiresIPhoneOS</key>
	<true/>
	<key>UILaunchStoryboardName</key>
	<string>LaunchScreen</string>
	<key>UIMainStoryboardFile</key>
	<string>Main</string>
	<key>UISupportedInterfaceOrientations</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UISupportedInterfaceOrientations~ipad</key>
	<array>
		<string>UIInterfaceOrientationPortrait</string>
		<string>UIInterfaceOrientationPortraitUpsideDown</string>
		<string>UIInterfaceOrientationLandscapeLeft</string>
		<string>UIInterfaceOrientationLandscapeRight</string>
	</array>
	<key>UIViewControllerBasedStatusBarAppearance</key>
	<false/>
	<key>CADisableMinimumFrameDurationOnPhone</key>
	<true/>
	<key>UIApplicationSupportsIndirectInputEvents</key>
	<true/>
	<key>NSCameraUsageDescription</key>
	<string>This app needs access to camera to take photos.</string>
	<key>NSContactsUsageDescription</key>
	<string>This app needs access to contacts to manage your contacts.</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>This app needs access to location when in use.</string>
	<key>NSMicrophoneUsageDescription</key>
	<string>This app needs access to microphone to record audio.</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>This app needs access to photo library to select photos.</string>
	<key>ITSAppUsesNonExemptEncryption</key>
	<false/>
	<key>UIBackgroundModes</key>
	<array>
		<string>background-processing</string>
	</array>
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleURLName</key>
			<string>com.ppapikey.dev</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>ppapikey</string>
			</array>
		</dict>
	</array>
</dict>
</plist>
EOF

# 4. Fix Runner.entitlements - minimal for development
echo "🔧 Fixing Runner.entitlements..."
cat > ios/Runner/Runner.entitlements << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>get-task-allow</key>
    <true/>
</dict>
</plist>
EOF

# 5. Create minimal Podfile
echo "🔧 Creating minimal Podfile..."
cat > ios/Podfile << 'EOF'
platform :ios, '12.0'

ENV['COCOAPODS_DISABLE_STATS'] = 'true'

project 'Runner', {
  'Debug' => :debug,
  'Profile' => :release,
  'Release' => :release,
}

def flutter_root
  generated_xcode_build_settings_path = File.expand_path(File.join('..', 'Flutter', 'Generated.xcconfig'), __FILE__)
  unless File.exist?(generated_xcode_build_settings_path)
    raise "#{generated_xcode_build_settings_path} must exist. If you're running pod install manually, make sure flutter pub get is executed first"
  end

  File.foreach(generated_xcode_build_settings_path) do |line|
    matches = line.match(/FLUTTER_ROOT\=(.*)/)
    return matches[1].strip if matches
  end
  raise "FLUTTER_ROOT not found in #{generated_xcode_build_settings_path}. Try deleting Generated.xcconfig, then run flutter pub get"
end

require File.expand_path(File.join('packages', 'flutter_tools', 'bin', 'podhelper'), flutter_root)

flutter_ios_podfile_setup

target 'Runner' do
  use_frameworks!
  use_modular_headers!

  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['STRIP_INSTALLED_PRODUCT'] = 'YES'
      config.build_settings['COPY_PHASE_STRIP'] = 'NO'
      config.build_settings['STRIP_STYLE'] = 'all'
    end
  end
end
EOF

# 6. Get dependencies
echo "📥 Getting dependencies..."
flutter pub get

# 7. Install iOS dependencies
echo "🍎 Installing iOS dependencies..."
cd ios
pod install --repo-update
cd ..

# 8. Build for simulator first
echo "🏗️ Building for iOS Simulator..."
flutter build ios --debug --simulator

echo "✅ FINAL FIX completed!"
echo ""
echo "📋 CÁC BƯỚC TIẾP THEO:"
echo "1. Test trên Simulator: flutter run --debug"
echo "2. Nếu Simulator OK, mở Xcode: open ios/Runner.xcworkspace"
echo "3. Trong Xcode:"
echo "   - Chọn project 'Runner'"
echo "   - Vào tab 'Signing & Capabilities'"
echo "   - Check 'Automatically manage signing'"
echo "   - Chọn Team của bạn"
echo "   - Bundle ID sẽ tự động là com.ppapikey.dev"
echo "4. Build và Run: Product → Build → Run"
echo ""
echo "🔍 NẾU VẪN LỖI:"
echo "1. Kiểm tra Apple Developer Account còn active không"
echo "2. Kiểm tra Certificate còn hạn không"
echo "3. Kiểm tra Provisioning Profile có đúng không"
echo "4. Kiểm tra Device UDID có trong profile không"
echo "5. Thử cài đặt bằng AltStore hoặc Sideloadly"
