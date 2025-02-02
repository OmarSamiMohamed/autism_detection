import 'package:flutter/material.dart';
import 'package:autism_detection/Screens/AppContent/home_page.dart';
import 'Rigester_page.dart';
import 'forgetpass_page.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(45),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "!..أهلا بيك",
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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
                      fontSize: 18,
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: const Color.fromARGB(255, 96, 96, 96),
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
                const SizedBox(height: 10),

                // رابط "نسيت كلمة السر"
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                          return ForgetPassPage();
                        }));
                      },
                      child: const Text(
                        ' اضغط هنا',
                        style: TextStyle( 
                          fontFamily: "Alexandria",
                          color: Colors.blue,
                          fontSize: 14
                        ),
                      ),
                    ),
                    const Text(
                      'نسيت كلمة المرور؟',
                      style: TextStyle(
                        fontFamily: "Alexandria",
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // زر تسجيل الدخول
                ElevatedButton(
                  onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
            ); },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: const Color.fromARGB(255, 49, 161, 253),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'تسجيل الدخول',
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
    "Photos/google-play.png",
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
                const SizedBox(height: 20),

                // رابط "ليس لديك حساب؟"
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                          return const RegisterPage();
                        }));
                        
                      },
                      child: const Text(
                        'أنشئ حساب',
                        style: TextStyle(
                          fontFamily: "Alexandria",
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Text(
                      'ليس لديك حساب؟',
                      style: TextStyle(
                        fontFamily: "Alexandria",
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
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
