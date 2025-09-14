#!/bin/bash
# Script để tạo IPA tương thích với eSign

echo "🔧 Đang tạo IPA tương thích với eSign..."

# Clean project
echo "📦 Cleaning project..."
flutter clean

# Get dependencies
echo "📥 Getting dependencies..."
flutter pub get

# Install iOS dependencies
echo "🍎 Installing iOS dependencies..."
cd ios
pod install
cd ..

# Build iOS app (không ký)
echo "🏗️ Building iOS app (unsigned)..."
flutter build ios --release --no-codesign --no-pub --no-tree-shake-icons --verbose

# Tạo IPA file
echo "📱 Creating IPA file..."
cd build/ios/iphoneos
mkdir Payload
cp -r Runner.app Payload/
zip -r ../../../PPAPIKey_Mobile_unsigned.ipa Payload/
cd ../../..

echo "✅ IPA file đã được tạo: PPAPIKey_Mobile_unsigned.ipa"
echo ""
echo "📋 THÔNG TIN CHO ESIGN:"
echo "App Name: PPAPIKey Mobile"
echo "Bundle ID: com.ppapikey.dev"
echo "Version: 1.2.2"
echo "Build: 1"
echo "IPA File: PPAPIKey_Mobile_unsigned.ipa"
echo ""
echo "🔧 CÁC BƯỚC TIẾP THEO:"
echo "1. Upload PPAPIKey_Mobile_unsigned.ipa lên eSign"
echo "2. Cấu hình Bundle ID: com.ppapikey.dev"
echo "3. Upload Provisioning Profile (.mobileprovision)"
echo "4. Upload Certificate (.p12)"
echo "5. Nhập password certificate"
echo "6. Ký và download IPA đã ký"
echo "7. Cài đặt lên device"
echo ""
echo "⚠️ LƯU Ý:"
echo "- Đảm bảo Bundle ID khớp với Provisioning Profile"
echo "- Device UDID phải có trong Provisioning Profile"
echo "- Certificate phải còn hạn và đúng loại"
