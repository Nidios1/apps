#!/bin/bash
# Script để sửa lỗi cài đặt iOS app

echo "🔧 Đang sửa lỗi cài đặt iOS app..."

# Tạo file cấu hình development
cat > ios/Runner/Config.xcconfig << 'EOF'
// Development configuration
DEVELOPMENT_TEAM = 
CODE_SIGN_STYLE = Automatic
CODE_SIGN_IDENTITY = iPhone Developer
PROVISIONING_PROFILE_SPECIFIER = 
EOF

# Cập nhật ExportOptions.plist cho development
cat > ios/ExportOptions.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>development</string>
    <key>uploadBitcode</key>
    <false/>
    <key>uploadSymbols</key>
    <true/>
    <key>compileBitcode</key>
    <false/>
    <key>signingStyle</key>
    <string>automatic</string>
    <key>signingCertificate</key>
    <string>iPhone Developer</string>
    <key>stripSwiftSymbols</key>
    <true/>
    <key>thinning</key>
    <string>&lt;none&gt;</string>
    <key>destination</key>
    <string>export</string>
    <key>manageAppVersionAndBuildNumber</key>
    <false/>
    <key>stripDebugSymbols</key>
    <true/>
</dict>
</plist>
EOF

echo "✅ Đã tạo file cấu hình development"
echo ""
echo "📋 HƯỚNG DẪN THIẾT LẬP:"
echo "1. Mở Xcode: open ios/Runner.xcworkspace"
echo "2. Chọn project 'Runner'"
echo "3. Vào tab 'Signing & Capabilities'"
echo "4. Chọn 'Automatically manage signing'"
echo "5. Chọn Team của bạn từ dropdown"
echo "6. Bundle Identifier sẽ tự động được tạo"
echo "7. Build và test trên device"
echo ""
echo "🚀 Sau khi thiết lập xong, chạy:"
echo "flutter build ios --debug"
echo "flutter install"
