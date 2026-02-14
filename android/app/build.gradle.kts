plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties

android {
    namespace = "com.app.falak"
    compileSdk = flutter.compileSdkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        // Enable core library desugaring for Java 8+ features
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.app.falak"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        val keystorePropertiesFile = rootProject.layout.projectDirectory.file("key.properties").asFile
        val keystoreProperties = Properties()
        
        if (keystorePropertiesFile.exists()) {
            keystorePropertiesFile.inputStream().use {
                keystoreProperties.load(it)
            }
        }
        
        create("release") {
            // استخدام key.properties إذا كان موجوداً
            if (keystorePropertiesFile.exists()) {
                val storeFileProperty = keystoreProperties["storeFile"] as String?
                storeFile = if (storeFileProperty != null) {
                    // المسار نسبي من مجلد app
                    file(storeFileProperty)
                } else {
                    file("upload-keystore.jks")
                }
                storePassword = keystoreProperties["storePassword"] as String? ?: ""
                keyAlias = keystoreProperties["keyAlias"] as String? ?: "upload"
                keyPassword = keystoreProperties["keyPassword"] as String? ?: ""
            } else {
                // استخدام متغيرات البيئة كبديل
                val keystorePath = System.getenv("KEYSTORE_PATH") ?: "${project.rootDir}/app/upload-keystore.jks"
                storeFile = file(keystorePath)
                storePassword = System.getenv("KEYSTORE_PASSWORD") ?: ""
                keyAlias = System.getenv("KEY_ALIAS") ?: "upload"
                keyPassword = System.getenv("KEY_PASSWORD") ?: ""
            }
        }
    }

    buildTypes {
        release {
            // استخدام release signing config إذا كان موجوداً، وإلا استخدم debug مؤقتاً
            val keystorePropertiesFile = rootProject.layout.projectDirectory.file("key.properties").asFile
            val keystorePath = System.getenv("KEYSTORE_PATH") ?: "${project.rootDir}/app/upload-keystore.jks"
            signingConfig = if (keystorePropertiesFile.exists() || file(keystorePath).exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

dependencies {
    // Add the desugaring library for Java 8+ features
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}

flutter {
    source = "../.."
}