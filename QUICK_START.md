# دليل سريع لرفع التطبيق على Google Play

## الخطوات السريعة

### 1️⃣ إنشاء Keystore (مرة واحدة فقط)

**على Windows:**
```powershell
cd android
.\create_keystore.ps1
```

**على Mac/Linux:**
```bash
cd android
chmod +x create_keystore.sh
./create_keystore.sh
```

### 2️⃣ بناء App Bundle

```bash
flutter build appbundle --release
```

الملف سيكون في: `build/app/outputs/bundle/release/app-release.aab`

### 3️⃣ رفع على Google Play Console

1. اذهب إلى [Google Play Console](https://play.google.com/console)
2. أنشئ تطبيق جديد
3. ارفع ملف `app-release.aab`
4. املأ المعلومات المطلوبة
5. أرسل للمراجعة

---

## معلومات التطبيق

- **Package Name**: `sa.falakalkhayer.app`
- **Version**: `1.0.0+2`
- **App Name**: Falak

---

## ⚠️ مهم جداً

- **احفظ Keystore في مكان آمن** - إذا فقدته، لن تتمكن من تحديث التطبيق!
- **لا ترفع `key.properties` أو `upload-keystore.jks` إلى Git**

---

## دليل مفصل

للحصول على دليل مفصل، راجع: [GOOGLE_PLAY_UPLOAD_GUIDE.md](GOOGLE_PLAY_UPLOAD_GUIDE.md)

