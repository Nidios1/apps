# 🔧 HƯỚNG DẪN SỬA LỖI CÀI ĐẶT iOS APP

## ❌ Vấn đề hiện tại:
- App "PPAPIKey Mobile" không thể cài đặt được
- Lỗi: "Không thể cài đặt" - "Vui lòng thử lại sau"
- Nguyên nhân: Code signing và provisioning profile chưa được thiết lập đúng

## ✅ Giải pháp:

### 1. **Thiết lập Xcode Project**

```bash
# Mở project trong Xcode
open ios/Runner.xcworkspace
```

**Trong Xcode:**
1. Chọn project **"Runner"** ở sidebar trái
2. Chọn target **"Runner"** 
3. Vào tab **"Signing & Capabilities"**
4. ✅ Check **"Automatically manage signing"**
5. Chọn **Team** của bạn từ dropdown (Apple Developer Account)
6. Bundle Identifier sẽ tự động được tạo: `com.ppapikey.dev`

### 2. **Build và Install App**

```bash
# Clean project
flutter clean

# Get dependencies
flutter pub get

# Install iOS dependencies
cd ios
pod install
cd ..

# Build debug version (không cần code signing)
flutter build ios --debug --no-codesign

# Install lên device đã kết nối
flutter install
```

### 3. **Nếu vẫn lỗi, thử cách khác:**

#### Option A: Build với Xcode
```bash
# Mở Xcode và build trực tiếp
open ios/Runner.xcworkspace
# Trong Xcode: Product -> Build (Cmd+B)
# Sau đó: Product -> Run (Cmd+R)
```

#### Option B: Sử dụng Flutter với device
```bash
# Kiểm tra device đã kết nối
flutter devices

# Run trực tiếp lên device
flutter run --debug
```

### 4. **Kiểm tra Device Settings**

**Trên iPhone:**
1. Settings → General → Device Management
2. Tìm Developer App của bạn
3. Trust the developer certificate
4. Thử cài đặt lại app

### 5. **Troubleshooting**

#### Lỗi "Untrusted Developer":
1. Settings → General → Device Management
2. Trust your developer certificate

#### Lỗi "App Installation Failed":
1. Xóa app cũ nếu có
2. Restart iPhone
3. Thử cài đặt lại

#### Lỗi Code Signing:
1. Kiểm tra Apple Developer Account còn active
2. Kiểm tra certificate chưa hết hạn
3. Tạo lại provisioning profile nếu cần

## 🚀 **Workflow GitHub Actions**

Workflow đã được cập nhật để:
- Build debug version thay vì release
- Sử dụng `--no-codesign` để tránh lỗi signing
- Tạo IPA file có thể cài đặt thủ công

## 📱 **Cài đặt IPA từ GitHub Actions**

1. Vào GitHub Actions: `https://github.com/Nidios1/apps/actions`
2. Download file `ios-app-debug.ipa`
3. Sử dụng Xcode hoặc Apple Configurator để cài đặt
4. Hoặc sử dụng tools như AltStore, Sideloadly

---

**Lưu ý:** Để cài đặt app lên device thực, bạn cần Apple Developer Account ($99/năm) hoặc sử dụng free developer account (giới hạn 7 ngày).
