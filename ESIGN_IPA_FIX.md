# 🔧 HƯỚNG DẪN SỬA LỖI KÝ IPA BẰNG ESIGN

## ❌ **Vấn đề hiện tại:**
- Lỗi "Không thể cài đặt" khi ký IPA bằng eSign
- App "PPAPIKey Mobile" không thể cài đặt được
- Nguyên nhân: Code signing và provisioning profile không đúng

## ✅ **GIẢI PHÁP:**

### **Bước 1: Tạo IPA tương thích với eSign**

```bash
# Clean project
flutter clean

# Get dependencies
flutter pub get

# Install iOS dependencies
cd ios
pod install
cd ..

# Build IPA cho eSign (không ký)
flutter build ios --release --no-codesign --no-pub --no-tree-shake-icons

# Tạo IPA file
cd build/ios/iphoneos
mkdir Payload
cp -r Runner.app Payload/
zip -r ../../../PPAPIKey_Mobile_unsigned.ipa Payload/
cd ../../..
```

### **Bước 2: Cấu hình Bundle ID cho eSign**

#### **Kiểm tra Bundle ID hiện tại:**
```bash
# Xem Bundle ID trong Info.plist
grep -A 1 "CFBundleIdentifier" ios/Runner/Info.plist
```

#### **Cập nhật Bundle ID (nếu cần):**
```xml
<!-- Trong ios/Runner/Info.plist -->
<key>CFBundleIdentifier</key>
<string>com.ppapikey.dev</string>
```

### **Bước 3: Tạo Provisioning Profile cho eSign**

#### **Trong Apple Developer Portal:**
1. Vào [Apple Developer Portal](https://developer.apple.com/account/)
2. **Certificates, Identifiers & Profiles**
3. **Identifiers** → Tạo App ID mới:
   - **Description:** PPAPIKey Mobile
   - **Bundle ID:** `com.ppapikey.dev`
   - **Capabilities:** Chọn các tính năng cần thiết

4. **Profiles** → Tạo Provisioning Profile:
   - **Type:** Development hoặc Ad Hoc
   - **App ID:** Chọn `com.ppapikey.dev`
   - **Certificates:** Chọn certificate của bạn
   - **Devices:** Thêm device UDID của bạn

### **Bước 4: Cấu hình eSign**

#### **Trong eSign:**
1. **Upload IPA:** `PPAPIKey_Mobile_unsigned.ipa`
2. **Bundle ID:** `com.ppapikey.dev`
3. **Provisioning Profile:** Upload file .mobileprovision
4. **Certificate:** Upload certificate .p12
5. **Password:** Nhập password certificate

### **Bước 5: Kiểm tra Device Settings**

#### **Trên iPhone:**
1. **Settings** → **General** → **Device Management**
2. Tìm **Developer App** của bạn
3. **Trust** the developer certificate
4. Restart iPhone và thử cài đặt lại

## 🚨 **CÁC LỖI THƯỜNG GẶP VÀ CÁCH SỬA:**

### **Lỗi 1: "Untrusted Developer"**
```bash
# Giải pháp:
# 1. Settings → General → Device Management
# 2. Trust developer certificate
# 3. Restart device
```

### **Lỗi 2: "App Installation Failed"**
```bash
# Nguyên nhân: Bundle ID không khớp
# Giải pháp: Kiểm tra Bundle ID trong:
# - Info.plist
# - Provisioning Profile
# - eSign configuration
```

### **Lỗi 3: "Provisioning Profile Mismatch"**
```bash
# Nguyên nhân: Provisioning Profile không đúng
# Giải pháp:
# 1. Tạo Provisioning Profile mới
# 2. Đảm bảo Bundle ID khớp
# 3. Thêm device UDID vào profile
```

### **Lỗi 4: "Certificate Expired"**
```bash
# Nguyên nhân: Certificate đã hết hạn
# Giải pháp:
# 1. Tạo certificate mới
# 2. Cập nhật Provisioning Profile
# 3. Re-sign IPA với certificate mới
```

## 🔍 **KIỂM TRA VÀ DEBUG:**

### **Kiểm tra IPA file:**
```bash
# Xem thông tin IPA
unzip -l PPAPIKey_Mobile_unsigned.ipa

# Kiểm tra Bundle ID trong IPA
unzip -p PPAPIKey_Mobile_unsigned.ipa Payload/Runner.app/Info.plist | grep -A 1 "CFBundleIdentifier"
```

### **Kiểm tra Provisioning Profile:**
```bash
# Xem thông tin Provisioning Profile
security cms -D -i your_profile.mobileprovision

# Kiểm tra Bundle ID trong profile
security cms -D -i your_profile.mobileprovision | grep -A 1 "application-identifier"
```

### **Kiểm tra Certificate:**
```bash
# Xem thông tin Certificate
openssl pkcs12 -in your_certificate.p12 -noout -info

# Kiểm tra Certificate có hợp lệ không
openssl x509 -in your_certificate.pem -text -noout
```

## 📱 **HƯỚNG DẪN ESIGN CHI TIẾT:**

### **Cấu hình eSign:**
1. **App Name:** PPAPIKey Mobile
2. **Bundle ID:** com.ppapikey.dev
3. **Version:** 1.2.2
4. **Build:** 1
5. **Team ID:** [Your Team ID]
6. **Provisioning Profile:** Development/Ad Hoc
7. **Certificate:** iPhone Developer

### **Upload Files:**
- **IPA File:** PPAPIKey_Mobile_unsigned.ipa
- **Provisioning Profile:** .mobileprovision file
- **Certificate:** .p12 file
- **Password:** Certificate password

## 🎯 **WORKFLOW HOÀN CHỈNH:**

```bash
# 1. Build IPA không ký
flutter build ios --release --no-codesign

# 2. Tạo IPA file
cd build/ios/iphoneos
mkdir Payload && cp -r Runner.app Payload/
zip -r ../../../PPAPIKey_Mobile_unsigned.ipa Payload/

# 3. Upload lên eSign với:
# - Bundle ID: com.ppapikey.dev
# - Provisioning Profile: Development
# - Certificate: iPhone Developer

# 4. Download IPA đã ký từ eSign

# 5. Cài đặt lên device
# - Sử dụng Xcode, Apple Configurator, hoặc AltStore
```

## ⚠️ **LƯU Ý QUAN TRỌNG:**

1. **Bundle ID phải khớp** giữa app, provisioning profile, và eSign
2. **Device UDID** phải có trong provisioning profile
3. **Certificate** phải còn hạn và đúng loại
4. **Provisioning Profile** phải match với certificate
5. **App phải được build đúng cách** trước khi ký

---

**Nếu vẫn gặp lỗi, hãy kiểm tra:**
- Bundle ID có khớp không
- Provisioning Profile có đúng không
- Certificate có hết hạn không
- Device UDID có trong profile không
