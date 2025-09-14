#!/bin/bash
# Script sửa lỗi cấu trúc app iOS

echo "🔧 Đang sửa lỗi cấu trúc app iOS..."

# Tạo file cấu hình signing chuẩn
cat > ios/Runner/Config.xcconfig << 'EOF'
// iOS Signing Configuration
PRODUCT_BUNDLE_IDENTIFIER = com.ppapikey.dev
CODE_SIGN_STYLE = Automatic
DEVELOPMENT_TEAM = 
CODE_SIGN_IDENTITY = 
PROVISIONING_PROFILE_SPECIFIER = 
IPHONEOS_DEPLOYMENT_TARGET = 12.0
ENABLE_BITCODE = NO
SWIFT_VERSION = 5.0
FLUTTER_BUILD_MODE = release
FLUTTER_BUILD_NUMBER = 1
FLUTTER_BUILD_NAME = 1.2.2
EOF

# Cập nhật Info.plist với Bundle ID cố định
sed -i '' 's/$(PRODUCT_BUNDLE_IDENTIFIER)/com.ppapikey.dev/g' ios/Runner/Info.plist

# Cập nhật Runner.entitlements để loại bỏ placeholder
cat > ios/Runner/Runner.entitlements << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>keychain-access-groups</key>
    <array>
        <string>$(AppIdentifierPrefix)com.ppapikey.dev</string>
    </array>
    <key>get-task-allow</key>
    <true/>
    <key>aps-environment</key>
    <string>development</string>
</dict>
</plist>
EOF

# Tạo file cấu hình Flutter iOS
cat > ios/Flutter/AppFrameworkInfo.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleDevelopmentRegion</key>
  <string>en</string>
  <key>CFBundleExecutable</key>
  <string>App</string>
  <key>CFBundleIdentifier</key>
  <string>io.flutter.flutter.app</string>
  <key>CFBundleInfoDictionaryVersion</key>
  <string>6.0</string>
  <key>CFBundleName</key>
  <string>App</string>
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

echo "✅ Đã sửa lỗi cấu trúc app"
echo ""
echo "📋 CÁC THAY ĐỔI ĐÃ THỰC HIỆN:"
echo "1. ✅ Bundle ID cố định: com.ppapikey.dev"
echo "2. ✅ Loại bỏ placeholder Team ID"
echo "3. ✅ Tạo file Config.xcconfig chuẩn"
echo "4. ✅ Cập nhật Runner.entitlements"
echo "5. ✅ Tạo AppFrameworkInfo.plist"
echo ""
echo "🚀 CÁC BƯỚC TIẾP THEO:"
echo "1. Mở Xcode: open ios/Runner.xcworkspace"
echo "2. Chọn project 'Runner'"
echo "3. Vào tab 'Signing & Capabilities'"
echo "4. Chọn 'Automatically manage signing'"
echo "5. Chọn Team của bạn"
echo "6. Build và test: flutter build ios --debug"
echo ""
echo "⚠️ LƯU Ý:"
echo "- Bundle ID đã được cố định: com.ppapikey.dev"
echo "- Cần tạo App ID và Provisioning Profile với Bundle ID này"
echo "- Team ID sẽ được set tự động trong Xcode"
