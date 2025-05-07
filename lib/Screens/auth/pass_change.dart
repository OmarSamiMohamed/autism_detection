import 'package:flutter/material.dart';
import 'package:autism_detection/Screens/auth/PassChangeSuccess.dart';

class PassChange extends StatefulWidget {
  const PassChange({super.key});

  @override
  _PassChangeState createState() => _PassChangeState();
}

class _PassChangeState extends State<PassChange> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      _showError("من فضلك املأ جميع الحقول");
    } else if (password != confirmPassword) {
      _showError("كلمة السر غير متطابقة");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PasswordChangedSuccessPage()),
      );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
                  "تغيير كلمة السر",
                  style: TextStyle(
                    fontFamily: "Alexandria",
                    fontSize: 35,
                    color: Colors.blue,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                const SizedBox(height: 150),

                // كلمة السر الجديدة
                TextField(
                  controller: _passwordController,
                  textAlign: TextAlign.end,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'كلمة السر الجديدة',
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

                // تأكيد كلمة السر
                TextField(
                  controller: _confirmPasswordController,
                  textAlign: TextAlign.end,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'تأكيد كلمة السر',
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

                const SizedBox(height: 220),

                ElevatedButton(
                  onPressed: _onNextPressed,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
