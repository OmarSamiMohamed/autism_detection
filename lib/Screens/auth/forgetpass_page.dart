import 'package:flutter/material.dart';
import 'forget_verify_code.dart';

class ForgetPassPage extends StatelessWidget {
  ForgetPassPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'نسيت كلمة السر',
              style: TextStyle(
                fontFamily: "Alexandria",
                fontSize: 34,
                fontWeight: FontWeight.w700,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'من فضلك، ارسل حساب جوجل الخاص بك، حتى يصلك الرابط لإنشاء رقم سر جديد',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Alexandria",
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: '******@gmail.com',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(17),
                    borderSide: BorderSide.none,
                  ),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 44),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: ElevatedButton(
                  onPressed: () {
                    if (emailController.text.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ForgetVerificationScreen();
                          },
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('الرجاء إدخال البريد الإلكتروني',
                          style:TextStyle(
                            fontFamily: "Alexandria",
                          ),)
                          ,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 49, 161, 253),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: const Text(
                    'التالي',
                    style: TextStyle(
                      fontFamily: "Alexandria",
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
