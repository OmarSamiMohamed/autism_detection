import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final double height;
  final Widget? leading;
  final List<Widget>? actions;

  const AppBarWidget({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.height = 50,
    this.leading,
    this.actions,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: centerTitle,
      leading: leading ??
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.black),
            onPressed: () => Navigator.pop(context),
          ),
      title: Text(
        title,
        style: AppTextStyles.headingSmall.copyWith(fontSize: 20),
      ),
    );
  }
}
