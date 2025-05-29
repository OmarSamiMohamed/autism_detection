import 'package:flutter/material.dart';
import 'package:autism_detection/Screens/auth/sucsess_newacc.dart';
import 'package:autism_detection/services/api_service.dart'; // تأكد من المسار

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showMessage("من فضلك املأ جميع الحقول");
      return;
    }

    if (password != confirmPassword) {
      _showMessage("كلمة السر وتأكيدها غير متطابقين");
      return;
    }

    _showMessage("جاري إنشاء الحساب...", isLoading: true);

    final token = await ApiService.registerUser(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    if (token != null) {
      _showMessage("تم إنشاء الحساب بنجاح 🎉");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SucsessNewacc()),
      );
    } else {
      _showMessage("فشل التسجيل. تحقق من البريد أو كلمة المرور أو حاول لاحقًا.");
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
                _buildTextField(
                  controller: _nameController,
                  hintText: 'اسم المستخدم',
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _emailController,
                  hintText: 'البريد الالكتروني',
                  icon: Icons.mail_outline_sharp,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _passwordController,
                  hintText: 'كلمة السر',
                  icon: _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  obscureText: !_isPasswordVisible,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _confirmPasswordController,
                  hintText: 'تأكيد كلمة السر',
                  icon: _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  obscureText: !_isPasswordVisible,
                  isPassword: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
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
                const Text(
                  'أو',
                  style: TextStyle(
                    fontFamily: "Alexandria",
                    fontSize: 26,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 13),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        "Photos/google.png",
                        width: 44,
                        height: 44,
                      ),
                      onPressed: () {
                        print("Google Button Pressed");
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
                        print("Facebook Button Pressed");
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
