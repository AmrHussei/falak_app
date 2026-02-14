# سكريبت لإنشاء Keystore للتطبيق
# قم بتشغيل هذا السكريبت من مجلد android

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "إنشاء Keystore للتطبيق" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# التحقق من وجود keytool
$keytoolPath = Get-Command keytool -ErrorAction SilentlyContinue
if (-not $keytoolPath) {
    Write-Host "خطأ: keytool غير موجود. تأكد من تثبيت JDK." -ForegroundColor Red
    exit 1
}

# معلومات Keystore
$keystorePath = "app\upload-keystore.jks"
$keyAlias = "upload"
$validity = "10000"  # 10000 يوم = حوالي 27 سنة

Write-Host "سيتم إنشاء Keystore في: $keystorePath" -ForegroundColor Yellow
Write-Host ""

# طلب كلمة المرور
$storePassword = Read-Host "أدخل كلمة مرور Keystore (سيتم طلبها مرة أخرى للتأكيد)" -AsSecureString
$storePasswordConfirm = Read-Host "أعد إدخال كلمة مرور Keystore" -AsSecureString

$storePasswordPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($storePassword))
$storePasswordConfirmPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($storePasswordConfirm))

if ($storePasswordPlain -ne $storePasswordConfirmPlain) {
    Write-Host "خطأ: كلمات المرور غير متطابقة!" -ForegroundColor Red
    exit 1
}

$keyPassword = Read-Host "أدخل كلمة مرور المفتاح (يمكن أن تكون نفس كلمة مرور Keystore)" -AsSecureString
$keyPasswordPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($keyPassword))

if ([string]::IsNullOrWhiteSpace($keyPasswordPlain)) {
    $keyPasswordPlain = $storePasswordPlain
}

Write-Host ""
Write-Host "معلومات Keystore:" -ForegroundColor Green
Write-Host "  - المسار: $keystorePath"
Write-Host "  - Alias: $keyAlias"
Write-Host "  - الصلاحية: $validity يوم"
Write-Host ""

# معلومات المطور
Write-Host "أدخل معلومات المطور:" -ForegroundColor Yellow
$firstName = Read-Host "الاسم الأول"
$lastName = Read-Host "اسم العائلة"
$orgUnit = Read-Host "القسم التنظيمي (اختياري)" 
$organization = Read-Host "المنظمة"
$city = Read-Host "المدينة"
$state = Read-Host "الولاية/المحافظة"
$countryCode = Read-Host "رمز الدولة (مثل: SA, EG, AE)" 

if ([string]::IsNullOrWhiteSpace($orgUnit)) {
    $orgUnit = "Development"
}

$dname = "CN=$firstName $lastName, OU=$orgUnit, O=$organization, L=$city, ST=$state, C=$countryCode"

Write-Host ""
Write-Host "جارٍ إنشاء Keystore..." -ForegroundColor Yellow

# إنشاء Keystore
$keytoolArgs = @(
    "-genkey",
    "-v",
    "-keystore", $keystorePath,
    "-keyalg", "RSA",
    "-keysize", "2048",
    "-validity", $validity,
    "-alias", $keyAlias,
    "-storepass", $storePasswordPlain,
    "-keypass", $keyPasswordPlain,
    "-dname", $dname
)

try {
    & keytool $keytoolArgs
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✓ تم إنشاء Keystore بنجاح!" -ForegroundColor Green
        Write-Host ""
        
        # إنشاء ملف key.properties
        $keyPropertiesPath = "key.properties"
        $keyPropertiesContent = @"
storePassword=$storePasswordPlain
keyPassword=$keyPasswordPlain
keyAlias=$keyAlias
storeFile=$keystorePath
"@
        
        Set-Content -Path $keyPropertiesPath -Value $keyPropertiesContent -Encoding UTF8
        
        Write-Host "✓ تم إنشاء ملف key.properties" -ForegroundColor Green
        Write-Host ""
        Write-Host "========================================" -ForegroundColor Cyan
        Write-Host "مهم جداً:" -ForegroundColor Red
        Write-Host "1. احفظ Keystore في مكان آمن" -ForegroundColor Yellow
        Write-Host "2. احفظ كلمات المرور في مكان آمن" -ForegroundColor Yellow
        Write-Host "3. إذا فقدت Keystore، لن تتمكن من تحديث التطبيق!" -ForegroundColor Red
        Write-Host "4. ملف key.properties موجود في: $keyPropertiesPath" -ForegroundColor Yellow
        Write-Host "========================================" -ForegroundColor Cyan
    } else {
        Write-Host "خطأ في إنشاء Keystore" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "خطأ: $_" -ForegroundColor Red
    exit 1
}

