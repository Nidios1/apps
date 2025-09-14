#!/bin/bash
# Script kiểm tra và fix lỗi IPA đã ký bằng eSign

echo "🔍 Đang kiểm tra lỗi IPA đã ký bằng eSign..."

# 1. Kiểm tra Bundle ID trong IPA
echo "📱 Kiểm tra Bundle ID trong IPA..."
if [ -f "PPAPIKey_Mobile_unsigned.ipa" ]; then
    echo "✅ Tìm thấy IPA file"
    
    # Extract IPA để kiểm tra
    mkdir -p temp_ipa_check
    cd temp_ipa_check
    unzip -q ../PPAPIKey_Mobile_unsigned.ipa
    
    if [ -f "Payload/Runner.app/Info.plist" ]; then
        BUNDLE_ID=$(plutil -p Payload/Runner.app/Info.plist | grep CFBundleIdentifier | cut -d'"' -f4)
        echo "📋 Bundle ID trong IPA: $BUNDLE_ID"
        
        if [ "$BUNDLE_ID" != "com.ppapikey.mobile" ]; then
            echo "⚠️ WARNING: Bundle ID không khớp!"
            echo "   IPA có: $BUNDLE_ID"
            echo "   Cần có: com.ppapikey.mobile"
        else
            echo "✅ Bundle ID đúng: com.ppapikey.mobile"
        fi
    fi
    
    cd ..
    rm -rf temp_ipa_check
else
    echo "❌ Không tìm thấy IPA file"
fi

# 2. Kiểm tra cấu hình iOS project
echo ""
echo "🔧 Kiểm tra cấu hình iOS project..."

# Kiểm tra Info.plist
if [ -f "ios/Runner/Info.plist" ]; then
    CURRENT_BUNDLE_ID=$(grep -A1 CFBundleIdentifier ios/Runner/Info.plist | tail -1 | sed 's/.*<string>\(.*\)<\/string>.*/\1/')
    echo "📋 Bundle ID trong project: $CURRENT_BUNDLE_ID"
    
    if [ "$CURRENT_BUNDLE_ID" != "com.ppapikey.mobile" ]; then
        echo "⚠️ WARNING: Bundle ID trong project không đúng!"
        echo "   Project có: $CURRENT_BUNDLE_ID"
        echo "   Cần có: com.ppapikey.mobile"
    else
        echo "✅ Bundle ID trong project đúng"
    fi
else
    echo "❌ Không tìm thấy Info.plist"
fi

# 3. Tạo script fix Bundle ID
echo ""
echo "🛠️ Tạo script fix Bundle ID..."
cat > fix_bundle_id.sh << 'EOF'
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
EOF

chmod +x fix_bundle_id.sh

# 4. Tạo hướng dẫn troubleshooting
echo ""
echo "📋 HƯỚNG DẪN TROUBLESHOOTING:"
echo ""
echo "🔍 KIỂM TRA IPA ĐÃ KÝ:"
echo "1. Mở IPA bằng 7-Zip hoặc WinRAR"
echo "2. Kiểm tra Payload/Runner.app/Info.plist"
echo "3. Xem CFBundleIdentifier có đúng không"
echo ""
echo "🔍 KIỂM TRA DEVICE:"
echo "1. Vào Settings → General → Device Management"
echo "2. Kiểm tra có certificate nào không"
echo "3. Trust certificate nếu cần"
echo ""
echo "🔍 KIỂM TRA APP CŨ:"
echo "1. Xóa app cũ trên iPhone"
echo "2. Restart iPhone"
echo "3. Cài đặt app mới"
echo ""
echo "🔍 KIỂM TRA ESIGN:"
echo "1. Đảm bảo Apple ID còn active"
echo "2. Kiểm tra Device UDID có trong profile"
echo "3. Thử ký lại với Apple ID khác"
echo ""
echo "🛠️ CHẠY SCRIPT FIX:"
echo "bash fix_bundle_id.sh"
echo ""
echo "✅ Script kiểm tra hoàn thành!"
