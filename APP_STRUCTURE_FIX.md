# 🔧 SỬA LỖI CẤU TRÚC APP iOS

## ❌ **Các lỗi cấu trúc đã phát hiện:**

### **1. Bundle ID không nhất quán**
- **Trước:** `$(PRODUCT_BUNDLE_IDENTIFIER)` (placeholder)
- **Sau:** `com.ppapikey.dev` (cố định)

### **2. Team ID placeholder**
- **Trước:** `YOUR_TEAM_ID` (placeholder)
- **Sau:** Được set tự động trong Xcode

### **3. Thiếu file cấu hình signing**
- **Thêm:** `Config.xcconfig` với cấu hình chuẩn
- **Thêm:** `AppFrameworkInfo.plist` cho Flutter

### **4. Runner.entitlements không đúng**
- **Trước:** Có placeholder Team ID
- **Sau:** Chỉ giữ lại các key cần thiết

## ✅ **CÁC THAY ĐỔI ĐÃ THỰC HIỆN:**

### **1. Cập nhật Info.plist**
```xml
<!-- Trước -->
<key>CFBundleIdentifier</key>
<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>

<!-- Sau -->
<key>CFBundleIdentifier</key>
<string>com.ppapikey.dev</string>
```

### **2. Cập nhật Runner.entitlements**
```xml
<!-- Loại bỏ -->
<key>com.apple.developer.team-identifier</key>
<string>YOUR_TEAM_ID</string>
<key>application-identifier</key>
<string>YOUR_TEAM_ID.com.ppapikey.dev</string>

<!-- Chỉ giữ lại -->
<key>keychain-access-groups</key>
<array>
    <string>$(AppIdentifierPrefix)com.ppapikey.dev</string>
</array>
<key>get-task-allow</key>
<true/>
<key>aps-environment</key>
<string>development</string>
```

### **3. Tạo Config.xcconfig**
```
PRODUCT_BUNDLE_IDENTIFIER = com.ppapikey.dev
CODE_SIGN_STYLE = Automatic
DEVELOPMENT_TEAM = 
CODE_SIGN_IDENTITY = 
PROVISIONING_PROFILE_SPECIFIER = 
IPHONEOS_DEPLOYMENT_TARGET = 12.0
ENABLE_BITCODE = NO
SWIFT_VERSION = 5.0
```

### **4. Tạo AppFrameworkInfo.plist**
```xml
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
  <key>MinimumOSVersion</key>
  <string>12.0</string>
</dict>
</plist>
```

## 🚀 **CÁCH SỬ DỤNG:**

### **Option 1: Sử dụng Script (Khuyến nghị)**
```bash
# Chạy script sửa lỗi cấu trúc
chmod +x fix_app_structure.sh
./fix_app_structure.sh

# Sau đó build
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter build ios --debug --no-codesign
```

### **Option 2: Thủ công**
```bash
# 1. Cập nhật Bundle ID trong Info.plist
# 2. Cập nhật Runner.entitlements
# 3. Tạo Config.xcconfig
# 4. Tạo AppFrameworkInfo.plist
# 5. Build app
```

## 📱 **THIẾT LẬP XCODE:**

### **Bước 1: Mở Xcode**
```bash
open ios/Runner.xcworkspace
```

### **Bước 2: Cấu hình Signing**
1. Chọn project **"Runner"**
2. Chọn target **"Runner"**
3. Vào tab **"Signing & Capabilities"**
4. ✅ Check **"Automatically manage signing"**
5. Chọn **Team** của bạn
6. Bundle Identifier sẽ tự động là `com.ppapikey.dev`

### **Bước 3: Build và Test**
```bash
# Build debug
flutter build ios --debug

# Hoặc run trực tiếp
flutter run --debug
```

## 🍎 **THIẾT LẬP APPLE DEVELOPER:**

### **1. Tạo App ID**
- **Description:** PPAPIKey Mobile
- **Bundle ID:** `com.ppapikey.dev`
- **Capabilities:** Push Notifications, Background Modes

### **2. Tạo Provisioning Profile**
- **Type:** Development
- **App ID:** `com.ppapikey.dev`
- **Certificates:** iPhone Developer
- **Devices:** Thêm device UDID

### **3. Tạo Certificate**
- **Type:** iPhone Developer
- **App ID:** `com.ppapikey.dev`

## 🔍 **KIỂM TRA VÀ DEBUG:**

### **Kiểm tra Bundle ID**
```bash
# Kiểm tra trong Info.plist
grep -A 1 "CFBundleIdentifier" ios/Runner/Info.plist

# Kết quả mong đợi: com.ppapikey.dev
```

### **Kiểm tra cấu trúc app**
```bash
# Kiểm tra các file cấu hình
ls -la ios/Runner/
ls -la ios/Flutter/

# Các file cần có:
# - Info.plist
# - Runner.entitlements
# - Config.xcconfig
# - AppFrameworkInfo.plist
```

### **Kiểm tra build**
```bash
# Build và kiểm tra lỗi
flutter build ios --debug --verbose

# Nếu có lỗi, kiểm tra:
# - Bundle ID khớp với Provisioning Profile
# - Team ID đã được set
# - Certificate còn hạn
```

## ⚠️ **LƯU Ý QUAN TRỌNG:**

1. **Bundle ID phải khớp** giữa app và Apple Developer Portal
2. **Team ID sẽ được set tự động** trong Xcode
3. **Provisioning Profile** phải match với Bundle ID
4. **Certificate** phải còn hạn và đúng loại
5. **Device UDID** phải có trong Provisioning Profile

## 🎯 **KẾT QUẢ MONG ĐỢI:**

Sau khi sửa lỗi cấu trúc:
- ✅ Bundle ID nhất quán: `com.ppapikey.dev`
- ✅ Không còn placeholder Team ID
- ✅ Cấu hình signing chuẩn
- ✅ App có thể build và cài đặt được
- ✅ Không còn lỗi "Không thể cài đặt"

---

**Nếu vẫn gặp lỗi, hãy kiểm tra:**
- Bundle ID có khớp với Provisioning Profile không
- Team ID có được set trong Xcode không
- Certificate có hết hạn không
- Device UDID có trong Provisioning Profile không
