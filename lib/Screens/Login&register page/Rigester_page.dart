import 'package:flutter/material.dart';
import 'package:autism_detection/Screens/Login&register%20page/R_verify.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
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
        padding: const EdgeInsets.all(45),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "!..سجل هنا",
                  style: TextStyle(
                    fontFamily: "Alexandria",
                    fontSize: 40,
                    color: Colors.blue,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(height: 50),

                // حقل اسم المستخدم
                TextField(
                  controller: _usernameController,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: 'اسم المستخدم',
                    hintStyle: const TextStyle(
                    fontFamily: "Alexandria",
                      color: Color.fromARGB(255, 96, 96, 96),
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: const Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 96, 96, 96),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 20),
                  TextField(
                  controller: _usernameController,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: 'البريد الالكتروني',
                    hintStyle: const TextStyle(
                      fontFamily: "Alexandria",
                      color: Color.fromARGB(255, 96, 96, 96),
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: const Icon(
                      Icons.mail_outline_sharp,
                      color: Color.fromARGB(255, 96, 96, 96),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                    const SizedBox(height: 20),

                // حقل كلمة السر مع خيار الإظهار/الإخفاء
                TextField(
                  controller: _passwordController,
                  textAlign: TextAlign.end,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'كلمة السر',
                    hintStyle: const TextStyle(
                      fontFamily: "Alexandria",
                      color: Color.fromARGB(255, 96, 96, 96),
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: const Color.fromARGB(255, 57, 57, 57),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                const SizedBox(height: 20),
                // زر تسجيل الدخول
                ElevatedButton(
                  onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (BuildContext content){
                      return  RigesterVerificationScreen();
                    }));
                    // قم بإضافة عملية التحقق من بيانات الدخول هنا
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color.fromARGB(255, 49, 161, 253),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                          "التالي",
                    style: TextStyle(
                      fontFamily: "Alexandria",
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                // النص "أو"
                const Text(
                  'أو',
                  style: TextStyle(
                    fontFamily: "Alexandria",
                    fontSize: 26,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 13),

                // أيقونات تسجيل الدخول عبر منصات أخرى
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                    icon: Image.asset(
    "Photos/google.png",
    width: 44, // عرض الأيقونة
    height: 44, // ارتفاع الأيقونة
  ),
  iconSize: 30, // حجم أيقونة الزر، يمكن تغييره أيضًا
  onPressed: () {
    print("Button Pressed");
  },
),

                    const SizedBox(width: 10),
                    IconButton(
                      iconSize: 55,
                      icon: const Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        // هنا يمكنك إضافة عملية تسجيل الدخول باستخدام حساب فيسبوك
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
