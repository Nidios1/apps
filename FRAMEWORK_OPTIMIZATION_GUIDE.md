# 🎯 HƯỚNG DẪN TỐI ƯU HÓA FRAMEWORKS iOS

## ❓ **Tại sao có 12 frameworks nhưng chỉ thấy 2?**

### **Nguyên nhân:**
1. **Frameworks được embed trong app bundle** - không hiển thị khi giải nén thông thường
2. **Static linking** - một số frameworks được link trực tiếp vào binary
3. **Flutter tự động quản lý** - có thể ẩn frameworks không cần thiết

### **12 Frameworks hiện tại:**
```
audio_session.framework (3 Mục)
App.framework (4 Mục) 
flutter_local_notifications.framework (4 Mục)
flutter_app_badger.framework (3 Mục)
Flutter.framework (7 Mục) ⭐ Core Flutter
image_picker_ios.framework (4 Mục)
just_audio.framework (3 Mục)
url_launcher_ios.framework (4 Mục)
path_provider_foundation.framework (4 Mục)
sqflite_darwin.framework (4 Mục)
package_info_plus.framework (4 Mục)
shared_preferences_foundation.framework (4 Mục)
```

## 🚀 **CÁCH TỐI ƯU HÓA:**

### **Option 1: Sử dụng Script Tự động**
```bash
# Chạy script tối ưu hóa
chmod +x optimize_frameworks.sh
./optimize_frameworks.sh

# Sau đó build
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter build ios --release --no-codesign
```

### **Option 2: Tối ưu hóa Thủ công**

#### **Bước 1: Chỉnh sửa pubspec.yaml**
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # CHỈ GIỮ LẠI CÁC DEPENDENCIES CẦN THIẾT:
  cupertino_icons: ^1.0.2
  http: ^1.1.0
  provider: ^6.1.1
  shared_preferences: ^2.2.2
  sqflite: ^2.3.0
  intl: ^0.19.0
  
  # COMMENT OUT CÁC DEPENDENCIES KHÔNG CẦN:
  # flutter_local_notifications: ^16.3.0
  # just_audio: ^0.9.36
  # audio_session: ^0.1.16
  # image_picker: ^1.0.4
  # url_launcher: ^6.2.2
  # package_info_plus: ^4.2.0
  # path_provider: ^2.1.1
  # flutter_app_badger: ^1.5.0
  # permission_handler: ^11.1.0
```

#### **Bước 2: Cập nhật Podfile**
```ruby
# Thêm vào post_install để tối ưu hóa
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
    
    target.build_configurations.each do |config|
      # Tối ưu hóa size
      config.build_settings['STRIP_INSTALLED_PRODUCT'] = 'YES'
      config.build_settings['GCC_OPTIMIZATION_LEVEL'] = 's'
      config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Osize'
    end
  end
end
```

#### **Bước 3: Build với tối ưu hóa**
```bash
flutter clean
flutter pub get
cd ios && pod install && cd ..
flutter build ios --release --no-codesign --tree-shake-icons
```

## 📊 **KẾT QUẢ MONG ĐỢI:**

### **Trước tối ưu hóa:**
- 12 frameworks
- App size: ~50-100MB
- Build time: ~5-10 phút

### **Sau tối ưu hóa:**
- 4-6 frameworks (chỉ giữ lại cần thiết)
- App size: ~20-40MB
- Build time: ~3-5 phút

### **Frameworks còn lại:**
```
Flutter.framework (Core Flutter)
App.framework (Your app code)
shared_preferences_foundation.framework (Local storage)
sqflite_darwin.framework (Database)
```

## 🔍 **KIỂM TRA FRAMEWORKS:**

### **Cách 1: Sử dụng Xcode**
```bash
open ios/Runner.xcworkspace
# Trong Xcode: Product → Build
# Xem trong Navigator: Frameworks folder
```

### **Cách 2: Sử dụng Terminal**
```bash
# Kiểm tra frameworks trong app bundle
find build/ios/iphoneos/Runner.app -name "*.framework" | wc -l

# Liệt kê tất cả frameworks
find build/ios/iphoneos/Runner.app -name "*.framework"
```

### **Cách 3: Sử dụng otool**
```bash
# Kiểm tra linked frameworks
otool -L build/ios/iphoneos/Runner.app/Runner
```

## ⚠️ **LƯU Ý QUAN TRỌNG:**

1. **Backup trước khi tối ưu hóa:**
   ```bash
   cp pubspec.yaml pubspec_backup.yaml
   cp ios/Podfile ios/Podfile_backup.yaml
   ```

2. **Test kỹ sau khi tối ưu hóa:**
   - Kiểm tra tất cả tính năng hoạt động
   - Test trên device thực
   - Kiểm tra performance

3. **Khôi phục nếu cần:**
   ```bash
   cp pubspec_backup.yaml pubspec.yaml
   cp ios/Podfile_backup.yaml ios/Podfile
   flutter clean && flutter pub get
   ```

## 🎯 **KẾT LUẬN:**

Việc có nhiều frameworks là bình thường với Flutter apps. Để giảm số lượng frameworks:

1. **Loại bỏ dependencies không cần thiết**
2. **Sử dụng tree-shaking**
3. **Tối ưu hóa build settings**
4. **Chỉ giữ lại tính năng core**

Sau khi tối ưu hóa, bạn sẽ có app nhẹ hơn và ít frameworks hơn! 🚀
