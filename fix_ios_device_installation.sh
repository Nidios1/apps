#!/bin/bash
# Script fix lỗi cài đặt iOS app trên iPhone thực - COMPLETE FIX

echo "🚨 Đang fix lỗi cài đặt iOS app trên iPhone thực..."

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

# 2. Fix Info.plist với Bundle ID mới và cấu hình đúng
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
	<string>com.ppapikey.mobile</string>
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
	<key>ITSAppUsesNonExemptEncryption</key>
	<false/>
	<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleURLName</key>
			<string>com.ppapikey.mobile</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>ppapikey</string>
			</array>
		</dict>
	</array>
</dict>
</plist>
EOF

# 3. Fix Runner.entitlements - minimal cho device installation
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

# 4. Fix Podfile với cấu hình đúng cho device
echo "🔧 Fixing Podfile..."
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
      config.build_settings['DEVELOPMENT_TEAM'] = ''
      config.build_settings['CODE_SIGN_IDENTITY'] = ''
      config.build_settings['CODE_SIGN_STYLE'] = 'Automatic'
    end
  end
end
EOF

# 5. Get dependencies
echo "📥 Getting dependencies..."
flutter pub get

# 6. Install iOS dependencies
echo "🍎 Installing iOS dependencies..."
cd ios
pod install --repo-update
cd ..

# 7. Build for device (không phải simulator)
echo "🏗️ Building for iOS Device..."
flutter build ios --debug --no-codesign

echo "✅ COMPLETE FIX completed!"
echo ""
echo "📋 CÁC BƯỚC TIẾP THEO ĐỂ CÀI ĐẶT TRÊN IPHONE:"
echo ""
echo "🔧 PHƯƠNG PHÁP 1: Sử dụng Xcode (KHUYẾN NGHỊ)"
echo "1. Mở Xcode: open ios/Runner.xcworkspace"
echo "2. Trong Xcode:"
echo "   - Chọn project 'Runner'"
echo "   - Vào tab 'Signing & Capabilities'"
echo "   - Check 'Automatically manage signing'"
echo "   - Chọn Team của bạn (Apple Developer Account)"
echo "   - Bundle ID sẽ tự động là com.ppapikey.mobile"
echo "3. Kết nối iPhone vào máy tính"
echo "4. Chọn iPhone làm target device"
echo "5. Build và Run: Product → Build → Run"
echo ""
echo "🔧 PHƯƠNG PHÁP 2: Sử dụng AltStore/Sideloadly"
echo "1. Build IPA: flutter build ipa --debug"
echo "2. Sử dụng AltStore hoặc Sideloadly để cài đặt"
echo "3. Cần Apple ID để ký app"
echo ""
echo "🔧 PHƯƠNG PHÁP 3: Sử dụng eSign"
echo "1. Build IPA: flutter build ipa --debug --no-codesign"
echo "2. Upload IPA lên eSign"
echo "3. Ký và cài đặt qua eSign"
echo ""
echo "⚠️ LƯU Ý QUAN TRỌNG:"
echo "1. Cần Apple Developer Account để cài đặt trên device"
echo "2. Device phải được trust máy tính"
echo "3. Nếu dùng free Apple ID, app sẽ hết hạn sau 7 ngày"
echo "4. Nếu dùng paid Apple ID, app sẽ hết hạn sau 1 năm"
echo ""
echo "🔍 NẾU VẪN LỖI:"
echo "1. Kiểm tra Apple Developer Account còn active không"
echo "2. Kiểm tra Certificate còn hạn không"
echo "3. Kiểm tra Provisioning Profile có đúng không"
echo "4. Kiểm tra Device UDID có trong profile không"
echo "5. Thử restart Xcode và clean build folder"
