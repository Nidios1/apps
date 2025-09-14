#!/bin/bash
# Script fix đặc biệt cho eSign compatibility

echo "🔧 Fixing project for eSign compatibility..."

# 1. Clean everything
echo "🧹 Cleaning everything..."
flutter clean
rm -rf ios/Pods
rm -rf ios/Podfile.lock
rm -rf ios/.symlinks
rm -rf build/

# 2. Fix Info.plist với Bundle ID đơn giản hơn
echo "🔧 Fixing Info.plist for eSign..."
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
</dict>
</plist>
EOF

# 3. Fix Runner.entitlements - minimal cho eSign
echo "🔧 Fixing Runner.entitlements for eSign..."
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

# 4. Fix Podfile - tối ưu cho eSign
echo "🔧 Fixing Podfile for eSign..."
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

# 5. Get dependencies
echo "📥 Getting dependencies..."
flutter pub get

# 6. Install iOS dependencies
echo "🍎 Installing iOS dependencies..."
cd ios
pod install --repo-update
cd ..

# 7. Build for eSign
echo "🏗️ Building for eSign..."
flutter build ios --release --no-codesign --no-pub --no-tree-shake-icons --verbose

echo "✅ eSign compatibility fix completed!"
echo ""
echo "📋 CÁC BƯỚC TIẾP THEO:"
echo "1. Push code lên GitHub để trigger workflow mới"
echo "2. Download IPA mới từ GitHub Actions"
echo "3. Upload IPA lên eSign để ký"
echo "4. Cài đặt IPA đã ký trên iPhone"
echo ""
echo "⚠️ LƯU Ý QUAN TRỌNG CHO ESIGN:"
echo "1. Xóa app cũ trên iPhone trước khi cài mới"
echo "2. Đảm bảo Apple ID trong eSign còn active"
echo "3. Kiểm tra Device UDID có trong Provisioning Profile"
echo "4. Nếu vẫn lỗi, thử restart iPhone và máy tính"
echo "5. Thử ký với Apple ID khác nếu cần"
echo ""
echo "🔍 TROUBLESHOOTING ESIGN:"
echo "1. Kiểm tra IPA có Bundle ID đúng không"
echo "2. Kiểm tra Device Management trong Settings"
echo "3. Trust certificate nếu cần"
echo "4. Thử cài đặt bằng iTunes nếu có"
