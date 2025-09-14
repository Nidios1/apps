#!/bin/bash
# Script fix hoàn chỉnh cho việc cài đặt IPA

echo "🔧 Đang fix hoàn chỉnh cho việc cài đặt IPA..."

# 1. Tạo script kiểm tra device
echo "📱 Tạo script kiểm tra device..."
cat > check_device.sh << 'EOF'
#!/bin/bash
echo "📱 Kiểm tra device iPhone..."

echo "🔍 CÁC BƯỚC KIỂM TRA DEVICE:"
echo ""
echo "1. KIỂM TRA DEVICE MANAGEMENT:"
echo "   - Vào Settings → General → Device Management"
echo "   - Kiểm tra có certificate nào không"
echo "   - Nếu có, tap vào và chọn 'Trust'"
echo ""
echo "2. KIỂM TRA APP CŨ:"
echo "   - Tìm app 'PPAPIKey Mobile' trên iPhone"
echo "   - Nếu có, long press và chọn 'Delete App'"
echo "   - Restart iPhone"
echo ""
echo "3. KIỂM TRA STORAGE:"
echo "   - Vào Settings → General → iPhone Storage"
echo "   - Đảm bảo có đủ dung lượng (ít nhất 100MB)"
echo ""
echo "4. KIỂM TRA INTERNET:"
echo "   - Đảm bảo iPhone có kết nối internet"
echo "   - Cần internet để verify certificate"
echo ""
echo "✅ Device check completed!"
EOF

chmod +x check_device.sh

# 2. Tạo script fix IPA
echo "🔧 Tạo script fix IPA..."
cat > fix_ipa.sh << 'EOF'
#!/bin/bash
echo "🔧 Fixing IPA for installation..."

# Tìm IPA file
if [ -f "PPAPIKey_Mobile_Complete.ipa" ]; then
    IPA_FILE="PPAPIKey_Mobile_Complete.ipa"
elif [ -f "PPAPIKey_Mobile_Device.ipa" ]; then
    IPA_FILE="PPAPIKey_Mobile_Device.ipa"
elif [ -f "PPAPIKey_Mobile_unsigned.ipa" ]; then
    IPA_FILE="PPAPIKey_Mobile_unsigned.ipa"
else
    echo "❌ Không tìm thấy IPA file"
    exit 1
fi

echo "📱 Found IPA: $IPA_FILE"

# Kiểm tra IPA
echo "🔍 Checking IPA..."
mkdir -p temp_check
cd temp_check
unzip -q ../$IPA_FILE

if [ -f "Payload/Runner.app/Info.plist" ]; then
    BUNDLE_ID=$(plutil -p Payload/Runner.app/Info.plist | grep CFBundleIdentifier | cut -d'"' -f4)
    echo "📋 Bundle ID: $BUNDLE_ID"
    
    if [ "$BUNDLE_ID" != "com.ppapikey.mobile" ]; then
        echo "⚠️ WARNING: Bundle ID không đúng!"
        echo "   Cần: com.ppapikey.mobile"
        echo "   Có: $BUNDLE_ID"
    fi
fi

cd ..
rm -rf temp_check

echo "✅ IPA check completed!"
EOF

chmod +x fix_ipa.sh

# 3. Tạo hướng dẫn cài đặt chi tiết
echo "📋 Tạo hướng dẫn cài đặt chi tiết..."
cat > INSTALLATION_GUIDE.md << 'EOF'
# Hướng dẫn cài đặt PPAPIKey Mobile trên iPhone

## 🚨 Lỗi "Không thể cài đặt app" - Giải pháp hoàn chỉnh

### 🔍 Nguyên nhân phổ biến:

1. **App cũ tồn tại trên device**
2. **Certificate không được trust**
3. **Bundle ID không khớp**
4. **Provisioning Profile không đúng**
5. **Device UDID không có trong profile**

### 🛠️ Giải pháp từng bước:

#### **BƯỚC 1: Xóa app cũ (QUAN TRỌNG)**
1. **Tìm app "PPAPIKey Mobile"** trên iPhone
2. **Long press** vào app icon
3. **Chọn "Delete App"**
4. **Restart iPhone**

#### **BƯỚC 2: Kiểm tra Device Management**
1. **Vào Settings** → General → Device Management
2. **Kiểm tra** có certificate nào không
3. **Nếu có certificate:**
   - Tap vào certificate
   - Chọn "Trust [Certificate Name]"
   - Confirm "Trust"

#### **BƯỚC 3: Cài đặt IPA**
1. **Download IPA** từ GitHub Actions
2. **Upload lên eSign** để ký
3. **Download IPA đã ký** từ eSign
4. **Cài đặt IPA** trên iPhone

#### **BƯỚC 4: Nếu vẫn lỗi**
1. **Kiểm tra Apple ID** trong eSign còn active
2. **Kiểm tra Device UDID** có trong Provisioning Profile
3. **Thử ký với Apple ID khác**
4. **Thử restart iPhone và máy tính**

### ⚠️ Lưu ý quan trọng:

1. **Free Apple ID:** App hết hạn sau 7 ngày
2. **Paid Apple ID:** App hết hạn sau 1 năm
3. **Cần internet** để verify certificate
4. **Device phải được trust** máy tính

### 🔍 Troubleshooting:

#### **Lỗi "Untrusted Developer":**
- Vào Settings → General → Device Management
- Trust certificate của bạn

#### **Lỗi "App cannot be installed":**
- Xóa app cũ trên iPhone
- Restart iPhone
- Thử cài đặt lại

#### **Lỗi "Provisioning Profile":**
- Kiểm tra Device UDID có trong profile
- Tạo Provisioning Profile mới
- Thử Apple ID khác

### 📞 Hỗ trợ:

Nếu vẫn gặp vấn đề, hãy:
1. **Kiểm tra Flutter SDK version**
2. **Kiểm tra Xcode version**
3. **Kiểm tra Apple Developer Account**
4. **Thử restart máy tính**
EOF

echo "✅ Complete IPA installation fix completed!"
echo ""
echo "📋 CÁC FILE ĐÃ TẠO:"
echo "1. check_device.sh - Kiểm tra device"
echo "2. fix_ipa.sh - Fix IPA"
echo "3. INSTALLATION_GUIDE.md - Hướng dẫn chi tiết"
echo ""
echo "🛠️ CÁCH SỬ DỤNG:"
echo "1. bash check_device.sh - Kiểm tra device"
echo "2. bash fix_ipa.sh - Fix IPA"
echo "3. Đọc INSTALLATION_GUIDE.md - Hướng dẫn chi tiết"
echo ""
echo "⚠️ LƯU Ý QUAN TRỌNG:"
echo "1. Xóa app cũ trên iPhone trước khi cài mới"
echo "2. Trust certificate trong Device Management"
echo "3. Đảm bảo Apple ID còn active"
echo "4. Kiểm tra Device UDID có trong profile"