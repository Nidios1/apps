#!/bin/bash
# Script kiểm tra và fix lỗi cài đặt IPA sau khi ký

echo "🔍 Đang kiểm tra lỗi cài đặt IPA sau khi ký..."

# 1. Kiểm tra IPA files hiện tại
echo "📱 Kiểm tra IPA files hiện tại..."
if [ -f "PPAPIKey_Mobile_Complete.ipa" ]; then
    echo "✅ Tìm thấy PPAPIKey_Mobile_Complete.ipa"
    IPA_FILE="PPAPIKey_Mobile_Complete.ipa"
elif [ -f "PPAPIKey_Mobile_Device.ipa" ]; then
    echo "✅ Tìm thấy PPAPIKey_Mobile_Device.ipa"
    IPA_FILE="PPAPIKey_Mobile_Device.ipa"
elif [ -f "PPAPIKey_Mobile_unsigned.ipa" ]; then
    echo "✅ Tìm thấy PPAPIKey_Mobile_unsigned.ipa"
    IPA_FILE="PPAPIKey_Mobile_unsigned.ipa"
else
    echo "❌ Không tìm thấy IPA file nào"
    echo "📋 Vui lòng download IPA từ GitHub Actions trước"
    exit 1
fi

# 2. Kiểm tra Bundle ID trong IPA
echo "🔍 Kiểm tra Bundle ID trong IPA..."
mkdir -p temp_ipa_check
cd temp_ipa_check
unzip -q ../$IPA_FILE

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
else
    echo "❌ Không tìm thấy Info.plist trong IPA"
fi

cd ..
rm -rf temp_ipa_check

# 3. Tạo hướng dẫn troubleshooting
echo ""
echo "📋 HƯỚNG DẪN TROUBLESHOOTING CHI TIẾT:"
echo ""
echo "🔍 KIỂM TRA DEVICE:"
echo "1. Vào Settings → General → Device Management"
echo "2. Kiểm tra có certificate nào không"
echo "3. Nếu có certificate, tap vào và chọn 'Trust'"
echo "4. Nếu không có certificate, có thể IPA chưa được ký đúng"
echo ""
echo "🔍 KIỂM TRA APP CŨ:"
echo "1. Tìm app 'PPAPIKey Mobile' trên iPhone"
echo "2. Nếu có, long press và chọn 'Delete App'"
echo "3. Restart iPhone"
echo "4. Thử cài đặt app mới"
echo ""
echo "🔍 KIỂM TRA ESIGN:"
echo "1. Đảm bảo Apple ID trong eSign còn active"
echo "2. Kiểm tra Device UDID có trong Provisioning Profile"
echo "3. Thử ký lại với Apple ID khác"
echo "4. Kiểm tra IPA có được ký thành công không"
echo ""
echo "🔍 KIỂM TRA IPA:"
echo "1. Mở IPA bằng 7-Zip hoặc WinRAR"
echo "2. Kiểm tra Payload/Runner.app/Info.plist"
echo "3. Xem CFBundleIdentifier có đúng không"
echo "4. Kiểm tra có file _CodeSignature không"
echo ""
echo "🛠️ CÁCH FIX CỤ THỂ:"
echo ""
echo "BƯỚC 1: Xóa app cũ (nếu có)"
echo "1. Tìm app 'PPAPIKey Mobile' trên iPhone"
echo "2. Long press → Delete App"
echo "3. Restart iPhone"
echo ""
echo "BƯỚC 2: Trust certificate"
echo "1. Cài đặt IPA lên iPhone"
echo "2. Vào Settings → General → Device Management"
echo "3. Tìm certificate của bạn"
echo "4. Tap vào certificate → Trust"
echo ""
echo "BƯỚC 3: Thử cài đặt lại"
echo "1. Mở IPA file trên iPhone"
echo "2. Tap 'Install'"
echo "3. Nếu vẫn lỗi, thử restart iPhone"
echo ""
echo "BƯỚC 4: Nếu vẫn không được"
echo "1. Thử ký với Apple ID khác"
echo "2. Kiểm tra Device UDID có trong profile"
echo "3. Thử cài đặt bằng iTunes (nếu có)"
echo ""
echo "⚠️ LƯU Ý QUAN TRỌNG:"
echo "1. Free Apple ID: App hết hạn sau 7 ngày"
echo "2. Paid Apple ID: App hết hạn sau 1 năm"
echo "3. Cần internet để verify certificate"
echo "4. Device phải được trust máy tính"
echo ""
echo "✅ Script kiểm tra hoàn thành!"
