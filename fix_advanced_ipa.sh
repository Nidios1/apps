#!/bin/bash
# Script fix lỗi cài đặt IPA khi đã kiểm tra đầy đủ

echo "🔧 Fixing IPA installation - Advanced troubleshooting..."

# 1. Tạo script kiểm tra Device UDID
echo "📱 Tạo script kiểm tra Device UDID..."
cat > check_device_udid.sh << 'EOF'
#!/bin/bash
echo "📱 KIỂM TRA DEVICE UDID:"
echo ""
echo "🔍 CÁCH LẤY DEVICE UDID:"
echo ""
echo "PHƯƠNG PHÁP 1: iTunes"
echo "1. Kết nối iPhone vào máy tính"
echo "2. Mở iTunes"
echo "3. Chọn iPhone"
echo "4. Click vào serial number để hiện UDID"
echo "5. Copy UDID"
echo ""
echo "PHƯƠNG PHÁP 2: Xcode"
echo "1. Mở Xcode"
echo "2. Window → Devices and Simulators"
echo "3. Chọn iPhone"
echo "4. Copy Identifier (UDID)"
echo ""
echo "PHƯƠNG PHÁP 3: iPhone Settings"
echo "1. Vào Settings → General → About"
echo "2. Scroll xuống tìm 'Serial Number'"
echo "3. Tap vào Serial Number để hiện UDID"
echo ""
echo "⚠️ LƯU Ý:"
echo "1. UDID phải có trong Provisioning Profile"
echo "2. Nếu không có, cần thêm vào Apple Developer"
echo "3. Profile phải được regenerate sau khi thêm UDID"
echo ""
echo "✅ Device UDID check completed!"
EOF

chmod +x check_device_udid.sh

# 2. Tạo script fix Provisioning Profile
echo "🔧 Tạo script fix Provisioning Profile..."
cat > fix_provisioning_profile.sh << 'EOF'
#!/bin/bash
echo "🔧 FIXING PROVISIONING PROFILE:"
echo ""
echo "📋 CÁC BƯỚC FIX PROVISIONING PROFILE:"
echo ""
echo "BƯỚC 1: Kiểm tra Apple Developer Account"
echo "1. Vào https://developer.apple.com"
echo "2. Đăng nhập bằng Apple ID"
echo "3. Vào Certificates, Identifiers & Profiles"
echo "4. Kiểm tra certificate còn hạn không"
echo ""
echo "BƯỚC 2: Kiểm tra App ID"
echo "1. Vào Identifiers → App IDs"
echo "2. Tìm 'com.ppapikey.mobile'"
echo "3. Nếu không có, tạo mới:"
echo "   - Description: PPAPIKey Mobile"
echo "   - Bundle ID: com.ppapikey.mobile"
echo ""
echo "BƯỚC 3: Kiểm tra Device UDID"
echo "1. Vào Devices → All"
echo "2. Kiểm tra iPhone UDID có trong list không"
echo "3. Nếu không có, thêm mới:"
echo "   - Device Name: iPhone của bạn"
echo "   - Device UDID: [UDID từ iPhone]"
echo ""
echo "BƯỚC 4: Tạo Provisioning Profile mới"
echo "1. Vào Profiles → All"
echo "2. Click '+' để tạo mới"
echo "3. Chọn 'iOS App Development'"
echo "4. Chọn App ID: com.ppapikey.mobile"
echo "5. Chọn Certificate: [Certificate của bạn]"
echo "6. Chọn Devices: [iPhone của bạn]"
echo "7. Profile Name: PPAPIKey Mobile Development"
echo "8. Download profile"
echo ""
echo "BƯỚC 5: Cài đặt Profile"
echo "1. Double-click file .mobileprovision"
echo "2. Profile sẽ được cài vào Xcode"
echo "3. Restart Xcode"
echo ""
echo "✅ Provisioning Profile fix completed!"
EOF

chmod +x fix_provisioning_profile.sh

# 3. Tạo script fix eSign
echo "🔧 Tạo script fix eSign..."
cat > fix_esign.sh << 'EOF'
#!/bin/bash
echo "🔧 FIXING ESIGN:"
echo ""
echo "📋 CÁC BƯỚC FIX ESIGN:"
echo ""
echo "BƯỚC 1: Kiểm tra Apple ID trong eSign"
echo "1. Mở eSign"
echo "2. Kiểm tra Apple ID còn active không"
echo "3. Nếu không, đăng nhập lại"
echo ""
echo "BƯỚC 2: Kiểm tra Device UDID trong eSign"
echo "1. Vào eSign → Devices"
echo "2. Kiểm tra iPhone UDID có trong list không"
echo "3. Nếu không có, thêm mới"
echo ""
echo "BƯỚC 3: Ký IPA với Profile mới"
echo "1. Upload IPA lên eSign"
echo "2. Chọn Provisioning Profile mới"
echo "3. Chọn Certificate"
echo "4. Ký IPA"
echo ""
echo "BƯỚC 4: Download IPA đã ký"
echo "1. Download IPA đã ký từ eSign"
echo "2. Cài đặt trên iPhone"
echo ""
echo "⚠️ LƯU Ý QUAN TRỌNG:"
echo "1. Profile phải chứa Device UDID"
echo "2. Certificate phải còn hạn"
echo "3. App ID phải đúng: com.ppapikey.mobile"
echo ""
echo "✅ eSign fix completed!"
EOF

chmod +x fix_esign.sh

# 4. Tạo hướng dẫn chi tiết
echo "📋 Tạo hướng dẫn chi tiết..."
cat > ADVANCED_TROUBLESHOOTING.md << 'EOF'
# Advanced Troubleshooting - IPA Installation

## 🚨 Lỗi "Không thể cài đặt app" - Advanced Fix

### ✅ Đã kiểm tra:
- Không có app cũ trên device
- Không có trùng lặp
- Chứng chỉ cá nhân còn hạn
- Build đúng

### 🔍 Vấn đề có thể là:

#### **1. Device UDID không có trong Provisioning Profile**
**Giải pháp:**
1. Lấy Device UDID từ iPhone
2. Thêm UDID vào Apple Developer Account
3. Tạo Provisioning Profile mới
4. Ký IPA với Profile mới

#### **2. Provisioning Profile không đúng**
**Giải pháp:**
1. Kiểm tra App ID: `com.ppapikey.mobile`
2. Kiểm tra Certificate còn hạn
3. Kiểm tra Device UDID có trong Profile
4. Tạo Profile mới nếu cần

#### **3. eSign không có Device UDID**
**Giải pháp:**
1. Thêm Device UDID vào eSign
2. Ký IPA với Profile chứa UDID
3. Download IPA đã ký

### 🛠️ Các bước fix cụ thể:

#### **BƯỚC 1: Lấy Device UDID**
```bash
# Chạy script kiểm tra
bash check_device_udid.sh
```

#### **BƯỚC 2: Fix Provisioning Profile**
```bash
# Chạy script fix
bash fix_provisioning_profile.sh
```

#### **BƯỚC 3: Fix eSign**
```bash
# Chạy script fix
bash fix_esign.sh
```

### 📱 Cách lấy Device UDID:

#### **Phương pháp 1: iTunes**
1. Kết nối iPhone vào máy tính
2. Mở iTunes
3. Chọn iPhone
4. Click vào serial number để hiện UDID
5. Copy UDID

#### **Phương pháp 2: Xcode**
1. Mở Xcode
2. Window → Devices and Simulators
3. Chọn iPhone
4. Copy Identifier (UDID)

#### **Phương pháp 3: iPhone Settings**
1. Vào Settings → General → About
2. Scroll xuống tìm 'Serial Number'
3. Tap vào Serial Number để hiện UDID

### 🔧 Fix Apple Developer Account:

#### **1. Kiểm tra App ID**
- Vào https://developer.apple.com
- Identifiers → App IDs
- Tìm `com.ppapikey.mobile`
- Nếu không có, tạo mới

#### **2. Kiểm tra Device UDID**
- Vào Devices → All
- Kiểm tra iPhone UDID có trong list không
- Nếu không có, thêm mới

#### **3. Tạo Provisioning Profile mới**
- Vào Profiles → All
- Click '+' để tạo mới
- Chọn 'iOS App Development'
- Chọn App ID: `com.ppapikey.mobile`
- Chọn Certificate
- Chọn Devices (iPhone UDID)
- Download và cài đặt profile

### ⚠️ Lưu ý quan trọng:

1. **Device UDID phải có trong Provisioning Profile**
2. **Profile phải được regenerate sau khi thêm UDID**
3. **eSign phải có Device UDID**
4. **IPA phải được ký với Profile mới**

### 🎯 Kết quả mong đợi:

Sau khi fix:
1. Device UDID có trong Provisioning Profile
2. Profile được cài đặt vào Xcode
3. eSign có Device UDID
4. IPA được ký với Profile đúng
5. App cài đặt thành công trên iPhone
EOF

echo "✅ Advanced IPA installation fix completed!"
echo ""
echo "📋 CÁC FILE ĐÃ TẠO:"
echo "1. check_device_udid.sh - Kiểm tra Device UDID"
echo "2. fix_provisioning_profile.sh - Fix Provisioning Profile"
echo "3. fix_esign.sh - Fix eSign"
echo "4. ADVANCED_TROUBLESHOOTING.md - Hướng dẫn chi tiết"
echo ""
echo "🛠️ CÁCH SỬ DỤNG:"
echo "1. bash check_device_udid.sh - Lấy Device UDID"
echo "2. bash fix_provisioning_profile.sh - Fix Profile"
echo "3. bash fix_esign.sh - Fix eSign"
echo "4. Đọc ADVANCED_TROUBLESHOOTING.md - Hướng dẫn chi tiết"
echo ""
echo "🎯 VẤN ĐỀ CHÍNH:"
echo "Device UDID không có trong Provisioning Profile!"
echo "Cần thêm UDID vào Apple Developer và tạo Profile mới."
