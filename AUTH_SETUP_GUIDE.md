# دليل إعداد نظام المصادقة - Authentication Setup Guide

## ✅ ما تم إنجازه

تم ربط صفحات تسجيل الدخول والتسجيل بـ API بنجاح، مع إضافة خيارات تسجيل الدخول الاجتماعي (Google, Facebook, Apple).

## 📋 المكونات الرئيسية

### 1. خدمة API (`lib/services/api_service.dart`)
- **الرابط الأساسي**: `https://graduation-project-production-6390.up.railway.app/api`
- **تسجيل الدخول**: `POST /api/login`
- **التسجيل**: `POST /api/register`
- **إنشاء طفل**: `POST /api/child/create` (يتطلب توكن)
- **إرسال الإجابات**: `POST /api/child/category-score` (يتطلب توكن)

### 2. خدمة المصادقة (`lib/services/auth_service.dart`)
خدمة جديدة تدير تسجيل الدخول الاجتماعي:
- **Google Sign In**: `signInWithGoogle()`
- **Facebook Sign In**: `signInWithFacebook()`
- **Apple Sign In**: `signInWithApple()`
- **تسجيل الخروج**: `signOut()`
- **التحقق من حالة الدخول**: `isLoggedIn()`

### 3. صفحة تسجيل الدخول (`lib/Screens/auth/login_Page.dart`)
- تسجيل الدخول عبر البريد الإلكتروني وكلمة المرور
- أزرار تسجيل الدخول الاجتماعي (Google, Facebook)
- حفظ التوكن في `SharedPreferences`
- الانتقال إلى الصفحة الرئيسية بعد النجاح

### 4. صفحة التسجيل (`lib/Screens/auth/rigester_page.dart`)
- إنشاء حساب جديد بالبريد الإلكتروني وكلمة المرور
- أزرار التسجيل الاجتماعي (Google, Facebook)
- التحقق من تطابق كلمات المرور
- حفظ التوكن والانتقال للصفحة الرئيسية

## 🔧 المكتبات المستخدمة

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: 1.1.0
  shared_preferences: ^2.2.2
  google_sign_in: 6.2.1
  flutter_facebook_auth: ^7.0.1
  sign_in_with_apple: ^8.1.0
  firebase_core: ^4.11.0
  firebase_auth: ^6.5.4
  crypto: ^3.0.3
```

## 🚀 كيفية الاستخدام

### تسجيل الدخول العادي
```dart
final token = await ApiService.loginUser(
  email: email,
  password: password,
);

if (token != null) {
  // حفظ التوكن
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  
  // الانتقال للصفحة الرئيسية
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
}
```

### تسجيل الدخول عبر Google
```dart
final result = await AuthService().signInWithGoogle();

if (result != null) {
  // تم تسجيل الدخول بنجاح
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
}
```

### تسجيل الدخول عبر Facebook
```dart
final result = await AuthService().signInWithFacebook();

if (result != null) {
  // تم تسجيل الدخول بنجاح
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
}
```

### تسجيل الخروج
```dart
await AuthService().signOut();
```

## ⚙️ إعدادات المنصات

### Android
1. أضف SHA-1 fingerprint في Firebase Console
2. قم بتنزيل `google-services.json` وضعه في `android/app/`

### iOS
1. أضف Bundle ID في Firebase Console
2. قم بتنزيل `GoogleService-Info.plist` وضعه في `ios/Runner/`
3. قم بتكوين URL Schemes لـ Google Sign In

### Facebook
1. أنشئ Facebook App في [Facebook Developers](https://developers.facebook.com/)
2. أضف App ID و App Secret في `android/app/src/main/AndroidManifest.xml`:
```xml
<meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/>
```

## 🔐 معالجة الأخطاء

تم إضافة معالجة شاملة للأخطاء:
- التحقق من اتصال الإنترنت
- عرض رسائل خطأ واضحة للمستخدم
- استخدام `mounted` للتحقق من وجود الويدجت قبل التحديث

## 📱 اختبار التطبيق

لتجربة التطبيق:
1. تأكد من اتصال الإنترنت
2. قم بتشغيل التطبيق: `flutter run`
3. جرب تسجيل الدخول ببيانات صحيحة
4. جرب التسجيل بحساب جديد
5. جرب تسجيل الدخول الاجتماعي

## 🎯 الخطوات التالية

لتحسين النظام أكثر:
1. **إضافة التحقق من البريد الإلكتروني** بعد التسجيل
2. **إضافة إعادة تعيين كلمة المرور** عبر البريد
3. **إضافة التخزين المؤقت** للبيانات
4. **إضافة الإشعارات** للمستخدم

## 📞 الدعم

إذا واجهت أي مشاكل:
1. تحقق من logs في console
2. تأكد من صحة البيانات المرسلة
3. تحقق من اتصال الإنترنت
4. تأكد من إعداد Firebase بشكل صحيح