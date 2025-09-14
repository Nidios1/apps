#!/bin/bash
echo "🔧 Fixing Bundle ID for eSign compatibility..."

# Fix Info.plist
cat > ios/Runner/Info.plist << 'INFO_EOF'
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
INFO_EOF

echo "✅ Fixed Info.plist with correct Bundle ID"

# Fix Runner.entitlements
cat > ios/Runner/Runner.entitlements << 'ENTITLEMENTS_EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>get-task-allow</key>
    <true/>
</dict>
</plist>
ENTITLEMENTS_EOF

echo "✅ Fixed Runner.entitlements"

# Clean and rebuild
echo "🧹 Cleaning and rebuilding..."
flutter clean
flutter pub get

echo "✅ Bundle ID fix completed!"
echo ""
echo "📋 CÁC BƯỚC TIẾP THEO:"
echo "1. Push code lên GitHub để trigger workflow mới"
echo "2. Download IPA mới từ GitHub Actions"
echo "3. Upload IPA mới lên eSign để ký"
echo "4. Cài đặt IPA đã ký trên iPhone"
echo ""
echo "⚠️ LƯU Ý QUAN TRỌNG:"
echo "1. Xóa app cũ trên iPhone trước khi cài mới"
echo "2. Đảm bảo Apple ID trong eSign còn active"
echo "3. Kiểm tra Device UDID có trong Provisioning Profile"
echo "4. Nếu vẫn lỗi, thử restart iPhone và máy tính"
