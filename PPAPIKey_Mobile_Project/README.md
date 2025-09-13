# PPAPIKey Mobile

Flutter iOS app for API key management.

## 🚀 Features

- **Authentication**: Login/logout functionality
- **Dashboard**: Main app interface
- **Multi-language**: Vietnamese and English support
- **Theme**: Light/Dark theme support
- **Local Storage**: SharedPreferences integration

## 📱 Platforms

- ✅ **Web**: Build and deploy to web
- ✅ **Android**: Build APK for Android devices
- ⚠️ **iOS**: Build iOS app (requires code signing for device installation)

## 🛠️ Build Instructions

### Web App
```bash
flutter build web
```

### Android APK
```bash
flutter build apk --debug
```

### iOS App
```bash
flutter build ios --debug --no-codesign
```

## 🔧 GitHub Actions

### Available Workflows:

1. **Build Web App** (`build.yml`)
   - Builds Flutter web app
   - Uploads web artifacts

2. **Build Android APK** (`build-apk.yml`)
   - Builds Android APK
   - Uploads APK file

3. **Build iOS App** (`build-ios.yml`)
   - Builds iOS app
   - Creates tar.gz bundle
   - Uploads iOS app bundle

## 📦 Installation

### Web App
1. Download web artifacts from GitHub Actions
2. Deploy to any web server
3. Access via browser

### Android APK
1. Download APK from GitHub Actions
2. Install on Android device
3. Enable "Install from unknown sources"

### iOS App
1. Download iOS bundle from GitHub Actions
2. Extract Runner.app
3. Use Xcode or AltStore to install

## 🎯 Usage

1. **Login**: Enter username and password
2. **Dashboard**: Access main app features
3. **Logout**: Sign out from the app

## 🔧 Development

### Prerequisites
- Flutter SDK 3.16.0+
- Dart SDK 3.0.0+

### Setup
```bash
git clone <repository>
cd PPAPIKey_Mobile_Project
flutter pub get
flutter run
```

### Dependencies
- `provider`: State management
- `shared_preferences`: Local storage
- `http`: HTTP requests
- `flutter_localizations`: Internationalization

## 📝 Notes

- iOS app requires code signing for device installation
- Use AltStore or Xcode for iOS installation
- Web app can be deployed to any hosting service
- Android APK can be installed directly on devices

## 🎉 Success!

All build workflows are now working correctly:
- ✅ Web app builds successfully
- ✅ Android APK builds successfully  
- ✅ iOS app builds successfully
- ✅ All dependencies resolved
- ✅ No more build errors