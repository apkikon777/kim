# Contributing to Apkku Webview

Terima kasih atas minat Anda untuk berkontribusi! 🎉

## 🚀 Quick Start

1. **Fork** repository ini
2. **Clone** fork Anda:
   ```bash
   git clone https://github.com/your-username/apkku.git
   cd apkku
   ```
3. **Create** branch baru:
   ```bash
   git checkout -b feature/amazing-feature
   ```
4. **Make** perubahan Anda
5. **Test** perubahan di kedua platform
6. **Commit** dengan pesan yang jelas:
   ```bash
   git commit -m "feat: add amazing feature"
   ```
7. **Push** ke branch Anda:
   ```bash
   git push origin feature/amazing-feature
   ```
8. **Create** Pull Request

## 📋 Guidelines

### Code Style

**Android (Kotlin)**
- Ikuti [Kotlin Coding Conventions](https://kotlinlang.org/docs/coding-conventions.html)
- Gunakan 4 spaces untuk indentasi
- Maksimal 120 karakter per baris
- Gunakan meaningful variable names

**iOS (Swift)**
- Ikuti [Swift Style Guide](https://swift.org/documentation/api-design-guidelines/)
- Gunakan 4 spaces untuk indentasi
- Maksimal 120 karakter per baris
- Gunakan camelCase untuk variables dan functions

### Commit Messages

Gunakan format [Conventional Commits](https://www.conventionalcommits.org/):

```
type(scope): description

[optional body]

[optional footer]
```

**Types:**
- `feat`: fitur baru
- `fix`: bug fix
- `docs`: perubahan dokumentasi
- `style`: formatting, missing semicolons, etc
- `refactor`: code refactoring
- `test`: menambah atau memperbaiki tests
- `chore`: maintenance tasks

**Examples:**
```
feat(android): add file upload progress indicator
fix(ios): resolve webview navigation issue
docs: update setup guide with new Firebase steps
```

### Pull Request Process

1. **Update** dokumentasi jika diperlukan
2. **Test** di kedua platform (Android & iOS)
3. **Pastikan** APK size tetap <500KB
4. **Update** CHANGELOG.md jika perlu
5. **Request** review dari maintainers

### Testing

**Android Testing:**
```bash
cd android
./gradlew test
./gradlew assembleDebug
# Test APK size
ls -lh app/build/outputs/apk/debug/app-debug.apk
```

**iOS Testing:**
```bash
open ios/ApkkuWebview.xcodeproj
# Test di Xcode simulator
# Pastikan build berhasil untuk device
```

## 🎯 Areas for Contribution

### High Priority
- 🐛 Bug fixes
- 📱 Platform-specific optimizations
- 📚 Documentation improvements
- 🔧 Build process improvements

### Medium Priority
- ✨ New features (diskusikan dulu via issue)
- 🎨 UI/UX improvements
- 🔒 Security enhancements
- ⚡ Performance optimizations

### Low Priority
- 🧪 Additional testing
- 🌐 Internationalization
- 📊 Analytics integration
- 🎭 Theming options

## 🐛 Bug Reports

Gunakan template issue untuk bug reports:

```markdown
**Platform:** Android/iOS
**Version:** 1.0.0
**Device:** Samsung Galaxy S21 / iPhone 13
**OS Version:** Android 12 / iOS 15

**Expected Behavior:**
Apa yang seharusnya terjadi

**Actual Behavior:**
Apa yang benar-benar terjadi

**Steps to Reproduce:**
1. Buka app
2. Tap tombol X
3. Error muncul

**Screenshots:**
[Attach screenshots if applicable]

**Additional Context:**
Informasi tambahan yang relevan
```

## 💡 Feature Requests

Sebelum mengajukan fitur baru:

1. **Check** existing issues
2. **Consider** impact terhadap app size
3. **Diskusikan** di issue terlebih dahulu
4. **Provide** use case yang jelas

## 📏 Size Constraints

**PENTING**: Aplikasi ini dirancang ultra-ringan!

- **Android APK**: Maksimal 500KB
- **iOS IPA**: Maksimal 1MB

Setiap kontribusi harus mempertahankan batasan ini.

### Tips Optimasi:
- Gunakan vector drawables (Android)
- Hindari library besar
- Optimize images dan assets
- Gunakan ProGuard/R8 (Android)
- Leverage system frameworks (iOS)

## 🔍 Code Review

Semua PR akan di-review untuk:

- ✅ Code quality
- ✅ Performance impact
- ✅ Size impact
- ✅ Security considerations
- ✅ Documentation updates
- ✅ Test coverage

## 🏆 Recognition

Kontributor akan diakui di:
- README.md credits section
- CHANGELOG.md untuk kontribusi signifikan
- GitHub contributors page

## 📞 Getting Help

- 💬 **Discussions**: Untuk pertanyaan umum
- 🐛 **Issues**: Untuk bug reports dan feature requests
- 📧 **Email**: Untuk pertanyaan sensitif

## 📜 Code of Conduct

Proyek ini mengikuti [Contributor Covenant](https://www.contributor-covenant.org/). Dengan berpartisipasi, Anda diharapkan menjunjung tinggi kode etik ini.

### Our Standards

**Perilaku yang Diharapkan:**
- Menggunakan bahasa yang ramah dan inklusif
- Menghormati sudut pandang dan pengalaman yang berbeda
- Menerima kritik konstruktif dengan baik
- Fokus pada yang terbaik untuk komunitas

**Perilaku yang Tidak Dapat Diterima:**
- Penggunaan bahasa atau gambar yang tidak pantas
- Trolling, komentar menghina, atau serangan pribadi
- Harassment publik atau pribadi
- Mempublikasikan informasi pribadi orang lain

## 🙏 Thank You!

Setiap kontribusi, sekecil apapun, sangat dihargai. Mari bersama-sama membuat aplikasi webview terbaik! 🚀

---

**Happy Coding!** 💻✨