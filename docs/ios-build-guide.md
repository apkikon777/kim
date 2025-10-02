# Panduan Build Aplikasi iOS

## Prasyarat

1. **macOS** dengan Xcode 14.0 atau lebih tinggi
2. **iOS Deployment Target**: iOS 14.0+
3. **Apple Developer Account** (untuk distribusi)
4. **Firebase Project** (untuk push notifications)

## Setup Firebase untuk iOS

1. Buka [Firebase Console](https://console.firebase.google.com/)
2. Pilih project yang sama dengan Android atau buat baru
3. Tambahkan aplikasi iOS dengan Bundle ID: `com.apkku.webview`
4. Download file `GoogleService-Info.plist`
5. Drag file tersebut ke project Xcode di folder `ApkkuWebview`
6. Pastikan file ditambahkan ke target `ApkkuWebview`

## Konfigurasi Remote JSON

1. Update URL di `ConfigManager.swift` (baris 8):
   ```swift
   private let configURL = "https://your-domain.com/config.json"
   ```

## Build dengan Xcode

### 1. Buka Project
```bash
open ios/ApkkuWebview.xcodeproj
```

### 2. Konfigurasi Project
1. Pilih project `ApkkuWebview` di navigator
2. Pilih target `ApkkuWebview`
3. Di tab **General**:
   - Bundle Identifier: `com.apkku.webview`
   - Version: `1.0`
   - Build: `1`
   - Deployment Target: `iOS 14.0`

### 3. Signing & Capabilities
1. Di tab **Signing & Capabilities**:
   - Enable **Automatically manage signing**
   - Pilih Development Team
   - Pastikan capabilities berikut aktif:
     - Push Notifications
     - Background Modes (Remote notifications)

### 4. Build untuk Testing
1. Pilih device atau simulator
2. Tekan `Cmd + R` untuk build dan run

### 5. Build untuk Distribution
1. Pilih **Any iOS Device** sebagai destination
2. Menu **Product** → **Archive**
3. Setelah archive selesai, pilih **Distribute App**
4. Pilih metode distribusi:
   - **App Store Connect** (untuk App Store)
   - **Ad Hoc** (untuk testing terbatas)
   - **Enterprise** (untuk distribusi internal)

## Build via Command Line

### 1. Build Debug
```bash
cd ios
xcodebuild -project ApkkuWebview.xcodeproj -scheme ApkkuWebview -configuration Debug -destination 'platform=iOS Simulator,name=iPhone 14' build
```

### 2. Build Release
```bash
xcodebuild -project ApkkuWebview.xcodeproj -scheme ApkkuWebview -configuration Release -destination generic/platform=iOS archive -archivePath build/ApkkuWebview.xcarchive
```

### 3. Export IPA
```bash
xcodebuild -exportArchive -archivePath build/ApkkuWebview.xcarchive -exportPath build/ -exportOptionsPlist ExportOptions.plist
```

## Optimasi Ukuran App

Aplikasi iOS sudah dikonfigurasi untuk ukuran minimal:

1. **SwiftUI** - Framework UI yang efisien
2. **Minimal Dependencies** - Hanya framework sistem
3. **Asset Optimization** - Menggunakan SF Symbols
4. **Code Optimization** - Compiler optimizations aktif

## Estimasi Ukuran App

- **Debug Build**: ~2-3 MB
- **Release Build**: ~1-2 MB
- **App Store**: ~500KB - 1MB (setelah App Store optimization)

## Fitur yang Diimplementasikan

✅ **WKWebView dengan URL Remote**
- Konfigurasi dari JSON remote
- Fallback ke konfigurasi lokal

✅ **Splash Screen**
- SwiftUI animation
- Durasi dapat dikonfigurasi

✅ **Network Detection**
- Real-time monitoring
- Automatic retry

✅ **Progress Indicator**
- Linear progress bar
- Smooth animations

✅ **Dark Mode Support**
- Automatic system detection
- Consistent theming

✅ **Pull-to-Refresh**
- Native SwiftUI implementation
- Configurable enable/disable

✅ **File Upload Support**
- Camera integration
- Photo library access
- Document picker
- Multiple file selection

✅ **Push Notifications**
- APNs integration
- Background handling
- User permission management

## Troubleshooting

### Build Errors

**"No such module 'SwiftUI'"**
- Pastikan Deployment Target minimal iOS 13.0
- Update Xcode ke versi terbaru

**Signing Issues**
- Pastikan Bundle ID unik
- Periksa Apple Developer Account
- Reset signing certificates jika perlu

### Firebase Issues

**"GoogleService-Info.plist not found"**
- Pastikan file sudah ditambahkan ke project
- Periksa target membership

**Push notifications tidak bekerja**
- Pastikan APNs key sudah dikonfigurasi di Firebase
- Periksa capabilities di Xcode
- Test di device fisik (tidak bisa di simulator)

### Network Issues

**"App Transport Security"**
- Sudah dikonfigurasi di Info.plist
- Untuk production, gunakan HTTPS

## Testing

### Manual Testing
1. Test di simulator dan device fisik
2. Test semua fitur:
   - Loading webview
   - Pull-to-refresh
   - File upload (camera, photos, files)
   - Dark mode switching
   - Push notifications (device fisik)
   - Network connectivity

### Automated Testing
```bash
# Unit tests
xcodebuild test -project ApkkuWebview.xcodeproj -scheme ApkkuWebview -destination 'platform=iOS Simulator,name=iPhone 14'

# UI tests
xcodebuild test -project ApkkuWebview.xcodeproj -scheme ApkkuWebviewUITests -destination 'platform=iOS Simulator,name=iPhone 14'
```

## App Store Submission

1. **Prepare for Submission**
   - Test thoroughly on multiple devices
   - Prepare app screenshots
   - Write app description
   - Set app pricing

2. **Upload via Xcode**
   - Archive project
   - Validate archive
   - Upload to App Store Connect

3. **App Store Connect**
   - Fill app information
   - Add screenshots
   - Submit for review

## Performance Tips

1. **Memory Management**
   - WebView automatically manages memory
   - Implement proper cleanup in delegates

2. **Battery Optimization**
   - Minimize background processing
   - Use efficient network calls

3. **User Experience**
   - Fast app launch
   - Smooth animations
   - Responsive UI