import 'package:flutter/material.dart';
import '../../../../core/routing/app_router.dart';

class SucsessNewacc extends StatelessWidget {
  const SucsessNewacc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/success.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 30),
            const Text(
              'تم إنشاء الحساب بنجاح',
              style: TextStyle(
                fontFamily: "Alexandria",
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRouter.login);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 49, 161, 253),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              child: const Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontFamily: "Alexandria",
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
