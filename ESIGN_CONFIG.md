# 🔧 CẤU HÌNH BUNDLE ID CHO ESIGN

## 📱 **Thông tin App:**
- **App Name:** PPAPIKey Mobile
- **Bundle ID:** com.ppapikey.dev
- **Version:** 1.2.2
- **Build:** 1
- **Team ID:** [Your Team ID]

## 🍎 **Apple Developer Portal Setup:**

### **1. Tạo App ID:**
```
Description: PPAPIKey Mobile
Bundle ID: com.ppapikey.dev
Capabilities:
- Push Notifications
- Background Modes
- Associated Domains (nếu cần)
```

### **2. Tạo Provisioning Profile:**
```
Type: Development hoặc Ad Hoc
App ID: com.ppapikey.dev
Certificates: iPhone Developer
Devices: [Thêm device UDID của bạn]
```

### **3. Tạo Certificate:**
```
Type: iPhone Developer
App ID: com.ppapikey.dev
Validity: 1 year
```

## 🔧 **eSign Configuration:**

### **Upload Files:**
- **IPA File:** PPAPIKey_Mobile_unsigned.ipa
- **Provisioning Profile:** .mobileprovision
- **Certificate:** .p12
- **Password:** [Certificate password]

### **App Settings:**
- **App Name:** PPAPIKey Mobile
- **Bundle ID:** com.ppapikey.dev
- **Version:** 1.2.2
- **Build:** 1
- **Team ID:** [Your Team ID]

## 📋 **Checklist trước khi ký:**

- [ ] Bundle ID khớp với Provisioning Profile
- [ ] Device UDID có trong Provisioning Profile
- [ ] Certificate còn hạn và đúng loại
- [ ] Provisioning Profile match với Certificate
- [ ] IPA được build đúng cách (unsigned)

## 🚨 **Các lỗi thường gặp:**

### **"Untrusted Developer"**
- Settings → General → Device Management → Trust

### **"App Installation Failed"**
- Kiểm tra Bundle ID khớp
- Kiểm tra Provisioning Profile đúng

### **"Provisioning Profile Mismatch"**
- Tạo Provisioning Profile mới
- Đảm bảo Bundle ID khớp

### **"Certificate Expired"**
- Tạo certificate mới
- Cập nhật Provisioning Profile
