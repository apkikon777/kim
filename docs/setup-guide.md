# Panduan Setup Lengkap Aplikasi Webview

## Overview

Aplikasi webview ringan untuk Android & iOS dengan ukuran APK maksimal 500KB yang mendukung:
- Konfigurasi remote JSON
- Splash screen
- Dark mode otomatis
- Pull-to-refresh
- File upload (camera, galeri, files)
- Push notifications (FCM)
- Deteksi koneksi internet

## Struktur Proyek

```
apkku/
├── android/                 # Proyek Android (Kotlin)
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── java/com/apkku/webview/
│   │   │   │   ├── MainActivity.kt
│   │   │   │   ├── SplashActivity.kt
│   │   │   │   ├── model/AppConfig.kt
│   │   │   │   ├── utils/
│   │   │   │   └── fcm/FCMService.kt
│   │   │   ├── res/
│   │   │   └── AndroidManifest.xml
│   │   ├── build.gradle
│   │   └── google-services.json.template
│   ├── build.gradle
│   ├── settings.gradle
│   └── gradle.properties
├── ios/                     # Proyek iOS (SwiftUI)
│   ├── ApkkuWebview/
│   │   ├── App.swift
│   │   ├── ContentView.swift
│   │   ├── WebViewManager.swift
│   │   ├── ConfigManager.swift
│   │   ├── NetworkUtils.swift
│   │   ├── AppConfig.swift
│   │   └── Info.plist
│   └── ApkkuWebview.xcodeproj/
├── config/
│   └── config.json          # Konfigurasi remote
└── docs/
    ├── android-build-guide.md
    ├── ios-build-guide.md
    └── setup-guide.md
```

## Quick Start

### 1. Setup Firebase

#### Android
1. Buat project di [Firebase Console](https://console.firebase.google.com/)
2. Tambahkan app Android dengan package: `com.apkku.webview`
3. Download `google-services.json` → `android/app/`
4. Aktifkan Cloud Messaging

#### iOS
1. Tambahkan app iOS dengan Bundle ID: `com.apkku.webview`
2. Download `GoogleService-Info.plist` → `ios/ApkkuWebview/`
3. Upload APNs key di Firebase Console

### 2. Setup Remote Config

1. Host file `config/config.json` di server/GitHub
2. Update URL di:
   - Android: `ConfigManager.kt` line 15
   - iOS: `ConfigManager.swift` line 8

### 3. Build Android

```bash
cd android

# Debug build
.\gradlew assembleDebug

# Release build (optimized)
.\gradlew assembleRelease
```

**Output**: `android/app/build/outputs/apk/release/app-release.apk`

### 4. Build iOS

```bash
# Buka di Xcode
open ios/ApkkuWebview.xcodeproj

# Atau via command line
cd ios
xcodebuild -project ApkkuWebview.xcodeproj -scheme ApkkuWebview -configuration Release archive
```

## Konfigurasi Remote JSON

### Format Config

```json
{
  "url": "https://your-website.com",
  "title": "App Name",
  "enablePullToRefresh": true,
  "enableFileUpload": true,
  "enableNotifications": true,
  "userAgent": "CustomApp/1.0",
  "backgroundColor": "#FFFFFF",
  "splashDuration": 2000
}
```

### Hosting Options

1. **GitHub Pages** (Gratis)
   ```
   https://username.github.io/repo/config.json
   ```

2. **Firebase Hosting** (Gratis)
   ```
   https://project-id.web.app/config.json
   ```

3. **Custom Server**
   ```
   https://your-domain.com/config.json
   ```

## Optimasi Ukuran

### Android (Target: <500KB)

✅ **Sudah Diimplementasi:**
- ProGuard/R8 minification
- Resource shrinking
- Vector drawables only
- Minimal dependencies
- Optimized build settings

### iOS (Target: <1MB)

✅ **Sudah Diimplementasi:**
- SwiftUI (efficient UI)
- System frameworks only
- SF Symbols for icons
- Compiler optimizations

## Testing

### Android
```bash
# Install debug APK
adb install android/app/build/outputs/apk/debug/app-debug.apk

# Check APK size
ls -lh android/app/build/outputs/apk/release/app-release.apk
```

### iOS
```bash
# Run in simulator
xcodebuild -project ios/ApkkuWebview.xcodeproj -scheme ApkkuWebview -destination 'platform=iOS Simulator,name=iPhone 14' build
```

## Deployment

### Android - Google Play Store
1. Build release APK
2. Sign dengan release keystore
3. Upload ke Google Play Console
4. Submit for review

### iOS - App Store
1. Archive di Xcode
2. Upload ke App Store Connect
3. Fill app information
4. Submit for review

## Troubleshooting

### Common Issues

**Android Build Failed**
- Pastikan Java 8+ installed
- Check `google-services.json` exists
- Clean build: `./gradlew clean`

**iOS Build Failed**
- Pastikan Xcode 14+ installed
- Check `GoogleService-Info.plist` added to target
- Clean build: `Cmd+Shift+K`

**APK Too Large**
- Pastikan build release, bukan debug
- Check ProGuard enabled
- Remove unused resources

**Push Notifications Not Working**
- Test di device fisik (tidak bisa di simulator)
- Pastikan FCM key configured
- Check app permissions

## Support

Untuk bantuan lebih lanjut:
1. Baca dokumentasi lengkap di folder `docs/`
2. Check troubleshooting di build guides
3. Pastikan semua dependencies ter-install

## License

MIT License - bebas digunakan untuk proyek komersial dan non-komersial.