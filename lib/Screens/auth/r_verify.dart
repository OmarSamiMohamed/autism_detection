import 'package:flutter/material.dart';

import 'sucsess_newacc.dart';

class RigesterVerificationScreen extends StatelessWidget {
  RigesterVerificationScreen({super.key});

  final List<TextEditingController> _codeControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              'رمز التحقق',
              style: TextStyle(
                fontFamily: "Alexandria",
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              ' تم إرسال رمز تحقق مكون من أربعة أرقام إلى\nحساب ******gmail.com (أدخل الرقم في الخانة)'
              
              ,
              textAlign: TextAlign.center,
              style: TextStyle(

                fontFamily: "Alexandria",
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => _buildCodeField(index),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'إعادة الإرسال',
                  style: TextStyle(
                    fontFamily: "Alexandria",
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // أعد إرسال الكود هنا
                  },
                  child: const Text(
                    'لم يصلك الرمز؟',
                    style: TextStyle(
                      fontFamily: "Alexandria",
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 33),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const SucsessNewacc();
                          },
                        ),
                      );
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

  Widget _buildCodeField(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: _codeControllers[index],
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          counterText: '',
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
