import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_assets.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/services/storage_service.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('من فضلك املأ كل الحقول'),
          backgroundColor: Colors.blue,
        ),
      );
      return;
    }

    context
        .read<AuthCubit>()
        .login(_emailController.text.trim(), _passwordController.text);
  }

  void _showMessage(String message, {bool isLoading = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (isLoading)
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              ),
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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        setState(() => _isLoading = state is AuthLoading);

        if (state is AuthSuccess) {
          _showMessage("تم تسجيل الدخول بنجاح ✅");
          Navigator.pushReplacementNamed(context, AppRouter.home);
        } else if (state is AuthFailure) {
          _showMessage(state.message);
        }
      },
      child: Scaffold(
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
                    style: AppTextStyles.headingLarge,
                  ),
                  const SizedBox(height: 50),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'البريد الإلكتروني',
                    icon: Icons.email,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'كلمة السر',
                    icon: _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    obscureText: !_isPasswordVisible,
                    isPassword: true,
                    onIconTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                Navigator.pushNamed(
                                    context, AppRouter.forgetPassword);
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
                  CustomButton(
                    text: 'تسجيل الدخول',
                    onPressed: _login,
                    isLoading: _isLoading,
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
                          AppAssets.googleLogo,
                          width: 44,
                          height: 44,
                        ),
                        iconSize: 30,
                        onPressed: _isLoading ? null : () {},
                        tooltip: 'تسجيل الدخول عبر Google',
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        iconSize: 55,
                        icon: const Icon(Icons.facebook, color: Colors.blue),
                        onPressed: _isLoading ? null : () {},
                        tooltip: 'تسجيل الدخول عبر Facebook',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                Navigator.pushNamed(
                                    context, AppRouter.register);
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
      ),
    );
  }
}
