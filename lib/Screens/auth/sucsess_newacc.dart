import 'package:flutter/material.dart';
import 'login_page.dart'; // تأكد إنك كتب المسار الصحيح للـ LoginPage

class SucsessNewacc extends StatefulWidget {
  const SucsessNewacc({super.key});

  @override
  State<SucsessNewacc> createState() => _SucsessNewaccState();
}

class _SucsessNewaccState extends State<SucsessNewacc> {
  @override
  void initState() {
    super.initState();
    // بعد 3 ثواني، روح لصفحة تسجيل الدخول
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // الدائرة مع علامة التحقق
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 24, 141, 237),
              ),
              child: const Center(
                child: Icon(
                  Icons.check,
                  size: 100,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 60),
            // نص التأكيد
            const Text(
              "!..تم انشاء حسابك بنجاح",
              style: TextStyle(
                fontFamily: "Alexandria",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
