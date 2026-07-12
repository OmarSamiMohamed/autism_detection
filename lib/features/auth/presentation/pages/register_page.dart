import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_assets.dart';
import '../../../../core/routing/app_router.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('من فضلك املأ جميع الحقول'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('كلمة السر وتأكيدها غير متطابقين'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('كلمة السر يجب أن تكون 6 أحرف على الأقل'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<AuthCubit>().register(name, email, password);
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
          _showMessage("تم إنشاء الحساب بنجاح 🎉");
          Navigator.pushReplacementNamed(context, AppRouter.home);
        } else if (state is AuthFailure) {
          _showMessage(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBarWidget(
          title: 'إنشاء حساب',
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: _isLoading ? null : () => Navigator.pop(context),
          ),
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
                    style: AppTextStyles.headingLarge,
                  ),
                  const SizedBox(height: 50),
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'اسم المستخدم',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'البريد الالكتروني',
                    icon: Icons.mail_outline_sharp,
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
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: 'تأكيد كلمة السر',
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
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "التالي",
                    onPressed: _register,
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
                        onPressed: _isLoading ? null : () {},
                        tooltip: 'التسجيل عبر Google',
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        iconSize: 55,
                        icon: const Icon(
                          Icons.facebook,
                          color: Colors.blue,
                        ),
                        onPressed: _isLoading ? null : () {},
                        tooltip: 'التسجيل عبر Facebook',
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
