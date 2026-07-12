# 🔥 دليل إعداد Firebase - حل مشكلة "NO FIREBASE APP"

## المشكلة
الشاشة الحمراء التي تظهر برسالة "NO FIREBASE APP" تعني أن Firebase لم يتم إعداده بشكل صحيح في المشروع.

## ✅ الحل - خطوات الإعداد

### الخطوة 1: إنشاء مشروع Firebase

1. اذهب إلى [Firebase Console](https://console.firebase.google.com/)
2. سجل الدخول بحساب Google
3. اضغط على **"Add project"** أو **"+ Create a project"**
4. أدخل اسم المشروع (مثال: `autism-detection`)
5. اتبع التعليمات لإنشاء المشروع

### الخطوة 2: إضافة تطبيق Android

1. في Firebase Console, اضغط على أيقونة **Android** ➕
2. أدخل **Package name** من مشروعك:
   ```
   com.example.autism_detection
   ```
   (يمكنك إيجاد الـ package name في ملف `android/app/src/main/AndroidManifest.xml`)
3. أدخل اسم التطبيق (اختياري)
4. اضغط **Register app**
5. **مهم جداً**: قم بتنزيل ملف `google-services.json`
6. ضع الملف في المجلد: `android/app/google-services.json`

### الخطوة 3: إضافة تطبيق iOS (إذا كنت تستخدم iOS)

1. في Firebase Console, اضغط على أيقونة **iOS** ➕
2. أدخل **Bundle ID** من مشروعك:
   ```
   com.example.autismDetection
   ```
   (يمكنك إيجاد الـ Bundle ID في Xcode → Target → General → Identity)
3. أدخل اسم التطبيق (اختياري)
4. اضغط **Register app**
5. **مهم جداً**: قم بتنزيل ملف `GoogleService-Info.plist`
6. ضع الملف في المجلد: `ios/Runner/GoogleService-Info.plist`
7. في Xcode, تأكد أن الملف مضاف إلى Target

### الخطوة 4: تحديث ملفات Gradle (Android)

#### ملف `android/build.gradle`:
```gradle
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // أضف هذا السطر
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

#### ملف `android/app/build.gradle`:
```gradle
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
    // أضف هذا السطر في النهاية
    id "com.google.gms.google-services"
}
```

### الخطوة 5: تفعيل المصادقة في Firebase

1. في Firebase Console, اذهب إلى **Authentication**
2. اضغط **Get started**
3. فعل طرق التسجيل التي تريدها:
   - ✅ **Email/Password** - للتسجيل العادي
   - ✅ **Google** - لتسجيل الدخول عبر Google
   - ✅ **Facebook** - لتسجيل الدخول عبر Facebook
   - ✅ **Apple** - لتسجيل الدخول عبر Apple

### الخطوة 6: إعداد Facebook Login (إذا كنت تستخدمه)

1. اذهب إلى [Facebook Developers](https://developers.facebook.com/)
2. أنشئ تطبيق جديد
3. أضف منصة Android:
   - Package name: `com.example.autism_detection`
   - Class name: `com.example.autism_detection.MainActivity`
   - Activity name: `MainActivity`
4. انقل **App ID** و **App Secret**
5. أضف في `android/app/src/main/AndroidManifest.xml`:
```xml
<meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/>
```
6. أضف في `android/app/src/main/res/values/strings.xml`:
```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <string name="facebook_app_id">YOUR_FACEBOOK_APP_ID</string>
    <string name="fb_login_protocol_scheme">fbYOUR_FACEBOOK_APP_ID</string>
</resources>
```

### الخطوة 7: الحصول على SHA-1 Fingerprint (Android)

لتفعيل Google Sign-In, تحتاج إلى SHA-1:

```bash
cd android
./gradlew signingReport
```

انسخ SHA-1 وأضفه في Firebase Console:
- Project Settings → Your apps → Add fingerprint

## 🧪 اختبار الإعداد

بعد اتباع جميع الخطوات:

1. قم بتنظيف المشروع:
```bash
flutter clean
```

2. احصل على المكتبات:
```bash
flutter pub get
```

3. شغل التطبيق:
```bash
flutter run
```

## ❗ مشاكل شائعة وحلولها

### المشكلة: "NO FIREBASE APP"
**الحل**: تأكد من:
- وجود ملف `google-services.json` في `android/app/`
- وجود ملف `GoogleService-Info.plist` في `ios/Runner/` (لـ iOS)
- إضافة `Firebase.initializeApp()` في `main.dart`

### المشكلة: "Connection failed" في Google Sign-In
**الحل**: 
- تأكد من إضافة SHA-1 fingerprint في Firebase
- تأكد من تفعيل Google Sign-In في Firebase Authentication

### المشكلة: Facebook Login لا يعمل
**الحل**:
- تأكد من إضافة Facebook App ID في AndroidManifest.xml
- تأكد من تفعيل Facebook Login في Firebase Console
- تحقق من Hash Key في Facebook Developers

## 📞 للدعم

إذا واجهت مشكلة:
1. تحقق من Firebase Console → Project Settings
2. تأكد من تنزيل ملفات التكوين الصحيحة
3. تحقق من logs في terminal
4. تأكد من اتصال الإنترنت

## 🎉 بعد نجاح الإعداد

بعد إعداد Firebase بنجاح, ستعمل:
- ✅ تسجيل الدخول عبر البريد الإلكتروني
- ✅ تسجيل الدخول عبر Google
- ✅ تسجيل الدخول عبر Facebook
- ✅ تسجيل الدخول عبر Apple (iOS فقط)

التطبيق جاهز للاستخدام! 🚀