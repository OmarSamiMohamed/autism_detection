import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // مهم جدًا لاستدعاء SharedPreferences
import 'package:autism_detection/Screens/home/home_page.dart';
import 'Rigester_page.dart';
import 'forgetpass_page.dart';
import 'package:autism_detection/services/api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage("من فضلك املأ كل الحقول");
      return;
    }

    _showMessage("جاري تسجيل الدخول...", isLoading: true);

    final token = await ApiService.loginUser(
      email: email,
      password: password,
    );

    if (token != null) {
      // حفظ التوكن في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      _showMessage("تم تسجيل الدخول بنجاح ✅");

      // الانتقال إلى الصفحة الرئيسية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      _showMessage("فشل في تسجيل الدخول. تأكد من البيانات.");
    }
  }

  void _showMessage(String message, {bool isLoading = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (isLoading) const CircularProgressIndicator(color: Colors.white),
            if (isLoading) const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.blue,
      ),
    );
  }

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

                // حقل البريد الإلكتروني
                _buildTextField(
                  controller: _emailController,
                  hintText: 'البريد الإلكتروني',
                  icon: Icons.email,
                ),
                const SizedBox(height: 20),

                // حقل كلمة السر
                _buildTextField(
                  controller: _passwordController,
                  hintText: 'كلمة السر',
                  icon: _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  obscureText: !_isPasswordVisible,
                  isPassword: true,
                ),
                const SizedBox(height: 10),

                // رابط نسيت كلمة المرور
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ForgetPassPage()),
                        );
                      },
                      child: const Text(
                        ' اضغط هنا',
                        style: TextStyle(
                          fontFamily: "Alexandria",
                          color: Colors.blue,
                          fontSize: 14,
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
                  onPressed: _login,
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

                const Text(
                  'أو',
                  style: TextStyle(
                    fontFamily: "Alexandria",
                    fontSize: 26,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 13),

                // أيقونات تسجيل الدخول البديل
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        "Photos/google.png",
                        width: 44,
                        height: 44,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        print("Google login pressed");
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
                        print("Facebook login pressed");
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterPage()),
                        );
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.end,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: "Alexandria",
          color: Color.fromARGB(255, 96, 96, 96),
          fontSize: 19,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  icon,
                  color: const Color.fromARGB(255, 57, 57, 57),
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : Icon(
                icon,
                color: const Color.fromARGB(255, 96, 96, 96),
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}
