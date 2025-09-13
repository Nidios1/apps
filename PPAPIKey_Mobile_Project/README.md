# PPAPIKey Mobile - Flutter iOS App

## 📱 Thông tin ứng dụng
- **Tên**: PPAPIKey Mobile
- **Bundle ID**: com.ppapikey.dev
- **Phiên bản**: 1.2.2
- **Build**: 1
- **iOS tối thiểu**: 13.0
- **Framework**: Flutter
- **Ngôn ngữ**: Dart

## 🎯 Mô tả
Ứng dụng quản lý API keys với các tính năng:
- Quản lý và tạo API keys
- Hệ thống đăng nhập/đăng ký
- Dashboard với thống kê chi tiết
- Quản lý packages và thành viên
- Hệ thống thông báo
- Hỗ trợ đa ngôn ngữ (VI/EN)

## 🏗️ Cấu trúc dự án
```
PPAPIKey_Mobile_Project/
├── ios/                    # iOS native code
├── android/                # Android native code  
├── lib/                    # Flutter source code
│   ├── main.dart
│   ├── screens/
│   ├── widgets/
│   ├── services/
│   └── utils/
├── assets/                 # Assets và resources
│   ├── images/
│   ├── fonts/
│   ├── audio/
│   └── translations/
├── pubspec.yaml            # Flutter dependencies
├── README.md
└── .github/workflows/      # GitHub Actions
```

## 🚀 Hướng dẫn build

### Yêu cầu hệ thống
- Flutter SDK 3.0+
- Dart SDK 3.0+
- Xcode 14.0+
- iOS 13.0+
- macOS (để build iOS)

### Cài đặt dependencies
```bash
flutter pub get
```

### Build cho iOS
```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release

# Build IPA
flutter build ipa --release
```

### Cấu hình signing
1. Mở `ios/Runner.xcworkspace` trong Xcode
2. Chọn team và provisioning profile
3. Cấu hình Bundle Identifier: `com.ppapikey.dev`
4. Build và archive

## 🔧 GitHub Actions (Không cần signing)

### Workflows có sẵn
- `build.yml` - Workflow chính (Debug + Release IPA)
- `build-simple.yml` - Workflow chi tiết với Xcode
- `build-ipa-only.yml` - Workflow đơn giản nhất

### Tính năng
- ✅ Build IPA tự động khi push code
- ✅ Upload artifacts
- ✅ Chạy tests và code analysis
- ❌ **KHÔNG CẦN** Apple Developer Account
- ❌ **KHÔNG CẦN** Certificate signing
- ❌ **KHÔNG CẦN** Provisioning Profile

### Lưu ý quan trọng
- IPAs được tạo **KHÔNG SIGNED** - không thể cài trên device thật
- Chỉ dùng cho **iOS Simulator** và **development**
- Để cài trên device thật cần Apple Developer Account

## 📦 Dependencies chính
- `flutter_local_notifications`: Thông báo local
- `just_audio`: Phát audio
- `image_picker_ios`: Chọn hình ảnh
- `sqflite_darwin`: Database SQLite
- `shared_preferences_foundation`: Lưu preferences
- `url_launcher_ios`: Mở URL
- `package_info_plus`: Thông tin package
- `path_provider_foundation`: Đường dẫn file
- `audio_session`: Quản lý audio session
- `flutter_app_badger`: Badge app icon

## 🌐 API Endpoints
Ứng dụng kết nối với:
- API Server: Quản lý keys chính
- CTV Server: Quản lý cộng tác viên

## 🔐 Permissions
- Camera: Chụp ảnh
- Photo Library: Chọn hình ảnh
- Microphone: Ghi âm
- Location: Vị trí
- Contacts: Danh bạ

## 📱 Supported Devices
- iPhone (arm64)
- iPad (arm64)
- iOS 13.0+

## 🎨 UI/UX Features
- Dark/Light theme
- Responsive design
- Material Design
- Custom fonts (Roboto)
- Multilingual support

## 📋 TODO
- [ ] Thiết lập Flutter project structure
- [ ] Cấu hình iOS project
- [ ] Setup dependencies
- [ ] Cấu hình signing
- [ ] Test build process
- [ ] Setup GitHub Actions
- [ ] Deploy to TestFlight

## 📞 Support
Liên hệ để được hỗ trợ về:
- Cấu hình build
- Signing và provisioning
- GitHub Actions setup
- Deployment process
