import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'main_app_button.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    required this.label,
    required this.onTap,
    super.key,
  });
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MainAppButton(
      label: label,
      height: 40.h,
      width: double.maxFinite,
      onTap: onTap,
      borderRadius: 12.r,
    );
  }
}
