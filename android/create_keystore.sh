#!/bin/bash

# سكريبت لإنشاء Keystore للتطبيق
# قم بتشغيل هذا السكريبت من مجلد android

echo "========================================"
echo "إنشاء Keystore للتطبيق"
echo "========================================"
echo ""

# التحقق من وجود keytool
if ! command -v keytool &> /dev/null; then
    echo "خطأ: keytool غير موجود. تأكد من تثبيت JDK."
    exit 1
fi

# معلومات Keystore
KEYSTORE_PATH="app/upload-keystore.jks"
KEY_ALIAS="upload"
VALIDITY="10000"  # 10000 يوم = حوالي 27 سنة

echo "سيتم إنشاء Keystore في: $KEYSTORE_PATH"
echo ""

# طلب كلمة المرور
read -sp "أدخل كلمة مرور Keystore: " STORE_PASSWORD
echo ""
read -sp "أعد إدخال كلمة مرور Keystore: " STORE_PASSWORD_CONFIRM
echo ""

if [ "$STORE_PASSWORD" != "$STORE_PASSWORD_CONFIRM" ]; then
    echo "خطأ: كلمات المرور غير متطابقة!"
    exit 1
fi

read -sp "أدخل كلمة مرور المفتاح (يمكن أن تكون نفس كلمة مرور Keystore): " KEY_PASSWORD
echo ""

if [ -z "$KEY_PASSWORD" ]; then
    KEY_PASSWORD="$STORE_PASSWORD"
fi

echo ""
echo "معلومات Keystore:"
echo "  - المسار: $KEYSTORE_PATH"
echo "  - Alias: $KEY_ALIAS"
echo "  - الصلاحية: $VALIDITY يوم"
echo ""

# معلومات المطور
echo "أدخل معلومات المطور:"
read -p "الاسم الأول: " FIRST_NAME
read -p "اسم العائلة: " LAST_NAME
read -p "القسم التنظيمي (اختياري): " ORG_UNIT
read -p "المنظمة: " ORGANIZATION
read -p "المدينة: " CITY
read -p "الولاية/المحافظة: " STATE
read -p "رمز الدولة (مثل: SA, EG, AE): " COUNTRY_CODE

if [ -z "$ORG_UNIT" ]; then
    ORG_UNIT="Development"
fi

DNAME="CN=$FIRST_NAME $LAST_NAME, OU=$ORG_UNIT, O=$ORGANIZATION, L=$CITY, ST=$STATE, C=$COUNTRY_CODE"

echo ""
echo "جارٍ إنشاء Keystore..."

# إنشاء Keystore
keytool -genkey -v \
    -keystore "$KEYSTORE_PATH" \
    -keyalg RSA \
    -keysize 2048 \
    -validity "$VALIDITY" \
    -alias "$KEY_ALIAS" \
    -storepass "$STORE_PASSWORD" \
    -keypass "$KEY_PASSWORD" \
    -dname "$DNAME"

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ تم إنشاء Keystore بنجاح!"
    echo ""
    
    # إنشاء ملف key.properties
    KEY_PROPERTIES_PATH="key.properties"
    cat > "$KEY_PROPERTIES_PATH" << EOF
storePassword=$STORE_PASSWORD
keyPassword=$KEY_PASSWORD
keyAlias=$KEY_ALIAS
storeFile=$KEYSTORE_PATH
EOF
    
    echo "✓ تم إنشاء ملف key.properties"
    echo ""
    echo "========================================"
    echo "مهم جداً:"
    echo "1. احفظ Keystore في مكان آمن"
    echo "2. احفظ كلمات المرور في مكان آمن"
    echo "3. إذا فقدت Keystore، لن تتمكن من تحديث التطبيق!"
    echo "4. ملف key.properties موجود في: $KEY_PROPERTIES_PATH"
    echo "========================================"
else
    echo "خطأ في إنشاء Keystore"
    exit 1
fi

