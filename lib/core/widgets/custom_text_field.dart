import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final bool isPassword;
  final VoidCallback? onIconTap;
  final String? errorText;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.isPassword = false,
    this.onIconTap,
    this.errorText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textAlign: TextAlign.end,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.hintText,
        errorText: errorText,
        prefixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  icon,
                  color: AppColors.black,
                ),
                onPressed: onIconTap,
              )
            : Icon(
                icon,
                color: AppColors.grey,
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.smallBorderRadius),
        ),
        filled: true,
        fillColor: AppColors.lightGrey,
      ),
    );
  }
}
