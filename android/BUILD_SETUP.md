# إعدادات Build للتطبيق

## معلومات التطبيق
- **Package Name**: com.app.falak
- **App Name**: Falak
- **Version**: 1.0.0+2 (versionName: 1.0.0, versionCode: 2)

## إعدادات Android

### 1. إنشاء Keystore للتوقيع

لإنشاء keystore جديد للتطبيق، قم بتنفيذ الأمر التالي:

```bash
keytool -genkey -v -keystore android/app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**ملاحظة مهمة**: احفظ كلمات المرور والمعلومات في مكان آمن. ستحتاجها لرفع التطبيق.

### 2. إعداد ملف key.properties

1. انسخ ملف `key.properties.example` إلى `key.properties`:
```bash
cp android/key.properties.example android/key.properties
```

2. افتح `android/key.properties` واملأ القيم:
```
storePassword=كلمة_مرور_keystore
keyPassword=كلمة_مرور_المفتاح
keyAlias=upload
storeFile=app/upload-keystore.jks
```

### 3. بناء App Bundle

لإنشاء App Bundle للرفع على Google Play:

```bash
flutter build appbundle --release
```

الملف الناتج سيكون في: `build/app/outputs/bundle/release/app-release.aab`

### 4. بناء APK (اختياري)

لإنشاء APK للاختبار:

```bash
flutter build apk --release
```

## إعدادات iOS

### 1. إعدادات Xcode

1. افتح المشروع في Xcode:
```bash
open ios/Runner.xcodeproj
```

2. في Xcode:
   - اختر Target: Runner
   - اذهب إلى Signing & Capabilities
   - اختر Team الخاص بك
   - تأكد من أن Bundle Identifier هو: `com.app.falak`

### 2. بناء App للرفع

لإنشاء App للرفع على App Store:

```bash
flutter build ipa --release
```

أو من Xcode:
- Product → Archive
- ثم ارفع من Organizer

## معلومات الإصدار

الإصدار الحالي: `1.0.0+1`
- Version Name: 1.0.0
- Version Code: 1

لتحديث الإصدار، عدل في `pubspec.yaml`:
```yaml
version: 1.0.1+2  # versionName+versionCode
```

## ملاحظات مهمة

- لا ترفع ملف `key.properties` أو `upload-keystore.jks` إلى Git
- احتفظ بنسخة احتياطية من keystore في مكان آمن
- إذا فقدت keystore، لن تتمكن من تحديث التطبيق على Google Play

