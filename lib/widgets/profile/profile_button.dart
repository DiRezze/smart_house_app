import 'package:flutter/material.dart';
import 'package:smart_house_app/theme/app_colors.dart';

class ProfileButton extends StatelessWidget {
  final String? label;
  final Icon? icon;
  final VoidCallback? onClick;
  final bool? extend;

  const ProfileButton({
    super.key,
    this.label,
    this.icon,
    this.onClick,
    this.extend = true
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: extend! ? double.infinity : null,
      child: label == null
          ? ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: AppColors.gray,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: icon,
      )
          : ElevatedButton.icon(
        icon: icon,
        label: Text(
          label!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          side: BorderSide(
            color: AppColors.gray,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

}