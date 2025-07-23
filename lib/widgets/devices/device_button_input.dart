import 'package:flutter/material.dart';
import 'package:smart_house_app/theme/app_colors.dart';

class DeviceButtonInput extends StatelessWidget {
  final String text;
  final bool primary;
  final VoidCallback? onPressed;
  final Widget? child;

  const DeviceButtonInput({
    super.key,
    required this.text,
    required this.primary,
    required this.onPressed,
    this.child
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary ? AppColors.primary : Colors.transparent,
          foregroundColor: primary ? Colors.white : AppColors.primary,
          side: primary ? null : BorderSide(color: AppColors.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: primary ? 2 : 0,
        ),
        onPressed: onPressed,
        child: child ??
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: primary ? Colors.white : AppColors.primary,
              ),
            ),
      ),
    );
  }

}