# Panduan Build Aplikasi Android

## Prasyarat

1. **Android Studio** (versi terbaru)
2. **Java Development Kit (JDK)** 8 atau lebih tinggi
3. **Android SDK** dengan API level 21-34
4. **Firebase Project** (untuk FCM)

## Setup Firebase

1. Buat project baru di [Firebase Console](https://console.firebase.google.com/)
2. Tambahkan aplikasi Android dengan package name: `com.apkku.webview`
3. Download file `google-services.json`
4. Letakkan file tersebut di `android/app/google-services.json`
5. Aktifkan Firebase Cloud Messaging di console

## Konfigurasi Remote JSON

1. Host file `config/config.json` di server atau GitHub
2. Update URL di `ConfigManager.kt` (baris 15):
   ```kotlin
   private const val CONFIG_URL = "https://your-domain.com/config.json"
   ```

## Build APK

### 1. Clone dan Setup
```bash
cd android
./gradlew clean
```

### 2. Build Debug APK
```bash
./gradlew assembleDebug
```

### 3. Build Release APK (Optimized)
```bash
./gradlew assembleRelease
```

### 4. Lokasi APK
- Debug: `android/app/build/outputs/apk/debug/app-debug.apk`
- Release: `android/app/build/outputs/apk/release/app-release.apk`

## Optimasi Ukuran APK

Aplikasi ini sudah dikonfigurasi untuk menghasilkan APK berukuran minimal:

1. **ProGuard/R8** - Minifikasi dan obfuskasi kode
2. **Resource Shrinking** - Menghapus resource yang tidak digunakan
3. **Minimal Dependencies** - Hanya library yang benar-benar diperlukan
4. **Vector Drawables** - Icon menggunakan format vector
5. **WebP Images** - Format gambar yang lebih efisien

## Estimasi Ukuran APK

- **Debug APK**: ~3-4 MB
- **Release APK**: ~400-500 KB (setelah optimasi)

## Fitur yang Diimplementasikan

✅ **Webview dengan URL Remote**
- Konfigurasi dari JSON remote
- Fallback ke konfigurasi lokal

✅ **Splash Screen Ringan**
- Durasi dapat dikonfigurasi
- Tema yang konsisten

✅ **Deteksi Koneksi Internet**
- Pesan error yang user-friendly
- Tombol retry

✅ **Progress Bar**
- Indikator loading halaman
- Auto-hide saat selesai

✅ **Dark Mode Support**
- Mengikuti pengaturan sistem
- Tema yang konsisten

✅ **Pull-to-Refresh**
- Dapat diaktifkan/nonaktifkan via config
- Smooth animation

✅ **File Upload Support**
- Kamera dan galeri
- Multiple file selection
- Permission handling

✅ **Firebase Cloud Messaging**
- Push notifications
- Background handling

## Troubleshooting

### APK Terlalu Besar
1. Pastikan build menggunakan `assembleRelease`
2. Periksa ProGuard rules
3. Hapus resource yang tidak digunakan

### Firebase Error
1. Pastikan `google-services.json` sudah benar
2. Periksa package name di Firebase console
3. Pastikan FCM sudah diaktifkan

### Network Error
1. Periksa URL konfigurasi remote
2. Pastikan server dapat diakses
3. Periksa format JSON

## Testing

### Manual Testing
1. Install APK di device
2. Test semua fitur:
   - Loading webview
   - Pull-to-refresh
   - File upload
   - Dark mode
   - Push notifications

### Size Testing
```bash
# Check APK size
ls -lh app/build/outputs/apk/release/app-release.apk

# Analyze APK content
./gradlew analyzeReleaseBundle
```