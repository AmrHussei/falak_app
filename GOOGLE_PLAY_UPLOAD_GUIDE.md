# دليل رفع التطبيق على Google Play Store

## متطلبات ما قبل الرفع

### 1. حساب Google Play Console
- أنشئ حساب مطور على [Google Play Console](https://play.google.com/console)
- ادفع رسوم التسجيل (25 دولار - مرة واحدة فقط)
- أكمل معلومات الحساب

### 2. إعدادات التطبيق الأساسية

#### معلومات التطبيق المطلوبة:
- ✅ اسم التطبيق: **Falak**
- ✅ Package Name: **sa.falakalkhayer.app**
- ✅ Version: **1.0.0** (versionName)
- ✅ Version Code: **1** (versionCode)

## الخطوة 1: إنشاء Keystore

### على Windows (PowerShell):
```powershell
cd android
.\create_keystore.ps1
```

### على Mac/Linux:
```bash
cd android
chmod +x create_keystore.sh
./create_keystore.sh
```

### يدوياً:
```bash
cd android/app
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

**معلومات مهمة:**
- احفظ كلمة مرور Keystore في مكان آمن
- احفظ Keystore في مكان آمن (مثل: Google Drive مشفر، USB مشفر)
- **إذا فقدت Keystore، لن تتمكن من تحديث التطبيق على Google Play!**

## الخطوة 2: إعداد ملف key.properties

بعد إنشاء Keystore، سيتم إنشاء ملف `android/key.properties` تلقائياً. إذا لم يتم إنشاؤه، أنشئه يدوياً:

```properties
storePassword=كلمة_مرور_keystore
keyPassword=كلمة_مرور_المفتاح
keyAlias=upload
storeFile=app/upload-keystore.jks
```

**تحذير:** لا ترفع ملف `key.properties` أو `upload-keystore.jks` إلى Git!

## الخطوة 3: بناء App Bundle

```bash
flutter build appbundle --release
```

الملف الناتج سيكون في:
```
build/app/outputs/bundle/release/app-release.aab
```

## الخطوة 4: رفع التطبيق على Google Play Console

### 4.1 إنشاء تطبيق جديد
1. اذهب إلى [Google Play Console](https://play.google.com/console)
2. اضغط على "إنشاء تطبيق"
3. املأ المعلومات:
   - **اسم التطبيق**: Falak
   - **اللغة الافتراضية**: العربية
   - **نوع التطبيق**: تطبيق
   - **مجاني أم مدفوع**: اختر حسب التطبيق

### 4.2 إعدادات المحتوى
1. اذهب إلى **المحتوى** → **لوحة المعلومات**
2. املأ المعلومات المطلوبة:
   - **الوصف القصير**: وصف مختصر للتطبيق
   - **الوصف الكامل**: وصف تفصيلي
   - **لقطات الشاشة**: أضف لقطات شاشة للتطبيق (مطلوب)
   - **الأيقونة**: أيقونة التطبيق (512x512 بكسل)
   - **صورة الميزة**: صورة مميزة (1024x500 بكسل)

### 4.3 رفع App Bundle
1. اذهب إلى **الإنتاج** → **الإصدارات**
2. اضغط على **إنشاء إصدار جديد**
3. اضغط على **رفع** واختر ملف `app-release.aab`
4. املأ **ملاحظات الإصدار**
5. اضغط على **حفظ**

### 4.4 إعدادات التطبيق
1. **التصنيف**: اختر التصنيف المناسب
2. **التصنيفات**: أضف التصنيفات المناسبة
3. **الخصوصية**: املأ سياسة الخصوصية إذا لزم الأمر
4. **الهدف الجماهيري**: حدد الفئة العمرية

### 4.5 إعدادات التسعير والتوزيع
1. **التسعير**: حدد إذا كان التطبيق مجاني أو مدفوع
2. **الدول**: اختر الدول التي سيتم توزيع التطبيق فيها
3. **الأجهزة**: اختر أنواع الأجهزة المدعومة

### 4.6 إرسال للمراجعة
1. راجع جميع المعلومات
2. اضغط على **إرسال للمراجعة**
3. انتظر موافقة Google (عادة 1-3 أيام)

## نصائح مهمة

### قبل الرفع:
- ✅ اختبر التطبيق جيداً على أجهزة مختلفة
- ✅ تأكد من عدم وجود أخطاء في Logcat
- ✅ تأكد من أن جميع الأذونات مبررة
- ✅ تأكد من وجود سياسة خصوصية إذا كان التطبيق يجمع بيانات

### بعد الرفع:
- 📱 راقب تقييمات المستخدمين
- 🐛 راقب تقارير الأخطاء في Play Console
- 📊 راقب إحصائيات التطبيق
- 🔄 خطط للتحديثات المستقبلية

## تحديث التطبيق لاحقاً

عند تحديث التطبيق:

1. **حدّث الإصدار في `pubspec.yaml`**:
```yaml
version: 1.0.1+2  # versionName+versionCode
```

2. **ابنِ App Bundle جديد**:
```bash
flutter build appbundle --release
```

3. **ارفع الإصدار الجديد** في Play Console

**ملاحظة:** يجب أن يكون `versionCode` أكبر من الإصدار السابق دائماً.

## استكشاف الأخطاء

### خطأ: "Upload failed"
- تأكد من أن App Bundle تم بناؤه بشكل صحيح
- تأكد من أن Keystore صحيح
- تأكد من أن versionCode أكبر من الإصدار السابق

### خطأ: "Missing privacy policy"
- أضف رابط سياسة الخصوصية في إعدادات التطبيق

### خطأ: "Missing content rating"
- أكمل استبيان تصنيف المحتوى في Play Console

## روابط مفيدة

- [Google Play Console](https://play.google.com/console)
- [دليل Flutter للرفع](https://docs.flutter.dev/deployment/android)
- [دليل Google Play](https://support.google.com/googleplay/android-developer)

---

**حظاً موفقاً في رفع التطبيق! 🚀**

