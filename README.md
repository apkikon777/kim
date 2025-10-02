# 📱 Aplikasi Webview Ultra-Ringan

> Aplikasi webview modern untuk Android & iOS dengan ukuran super kecil (<500KB APK)

## ✨ Fitur Utama

- 🚀 **Ultra Ringan**: APK Android <500KB, iOS <1MB
- 🌐 **Konfigurasi Remote**: Update app tanpa rebuild
- 🎨 **Dark Mode**: Otomatis mengikuti sistem
- 🔄 **Pull-to-Refresh**: Refresh konten dengan gesture
- 📁 **File Upload**: Camera, galeri, dan file picker
- 🔔 **Push Notifications**: Firebase Cloud Messaging
- 📶 **Deteksi Internet**: Tampilan offline yang elegan
- ⚡ **Splash Screen**: Loading yang dapat dikustomisasi

## 🏗️ Teknologi

| Platform | Framework | Language | Size Target |
|----------|-----------|----------|-------------|
| Android  | Native    | Kotlin   | <500KB      |
| iOS      | SwiftUI   | Swift    | <1MB        |

## 🚀 Quick Start

### Prerequisites
- **Android**: Android Studio, Java 8+
- **iOS**: Xcode 14+, macOS
- **Firebase**: Project dengan FCM enabled

### 1. Clone & Setup
```bash
git clone <repository-url>
cd apkku
```

### 2. Firebase Setup
1. Buat project di [Firebase Console](https://console.firebase.google.com/)
2. Download config files:
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/ApkkuWebview/`

### 3. Remote Config
1. Host `config/config.json` di server
2. Update URL di `ConfigManager` files

### 4. Build

**Android:**
```bash
cd android
.\gradlew assembleRelease
```

**iOS:**
```bash
open ios/ApkkuWebview.xcodeproj
# Build di Xcode
```

## 📋 Konfigurasi Remote

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

## 📁 Struktur Proyek

```
apkku/
├── 🤖 android/          # Android app (Kotlin)
├── 🍎 ios/              # iOS app (SwiftUI)
├── ⚙️ config/           # Remote configuration
├── 📚 docs/             # Documentation
└── 📖 README.md         # This file
```

## 🎯 Optimasi Ukuran

### Android (<500KB)
- ✅ ProGuard/R8 minification
- ✅ Resource shrinking
- ✅ Vector drawables only
- ✅ Minimal dependencies

### iOS (<1MB)
- ✅ SwiftUI framework
- ✅ System frameworks only
- ✅ SF Symbols
- ✅ Compiler optimizations

## 🔧 Development

### Android Development
```bash
cd android
.\gradlew assembleDebug
adb install app/build/outputs/apk/debug/app-debug.apk
```

### iOS Development
```bash
open ios/ApkkuWebview.xcodeproj
# Run di Xcode simulator
```

## 📖 Dokumentasi

- 📋 [Setup Guide](docs/setup-guide.md) - Panduan lengkap
- 🤖 [Android Build Guide](docs/android-build-guide.md) - Android specific
- 🍎 [iOS Build Guide](docs/ios-build-guide.md) - iOS specific

## 🚀 Deployment

### Google Play Store
1. Build release APK
2. Sign dengan keystore
3. Upload ke Play Console

### Apple App Store
1. Archive di Xcode
2. Upload ke App Store Connect
3. Submit for review

## 🐛 Troubleshooting

**APK terlalu besar?**
- Pastikan build `release`, bukan `debug`
- Check ProGuard enabled
- Remove unused resources

**Push notifications tidak bekerja?**
- Test di device fisik
- Pastikan FCM configured
- Check app permissions

**Build failed?**
- Check Java/Xcode version
- Pastikan config files exists
- Clean build cache

## 🤝 Contributing

1. Fork repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

## 📄 License

MIT License - bebas digunakan untuk proyek komersial dan non-komersial.

## 🙏 Credits

- Firebase untuk push notifications
- Material Design untuk Android UI
- SF Symbols untuk iOS icons

---

**Made with ❤️ for ultra-lightweight mobile apps**