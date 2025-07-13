import 'package:flutter/material.dart';
import 'package:smart_house_app/theme/app_colors.dart';

class BadgeButton extends StatelessWidget{
  final bool selected;
  final String label;
  final IconData? icon;
  final VoidCallback? onClick;

  const BadgeButton({
    super.key,
    required this.selected,
    required this.label,
    this.icon,
    this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.outline,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.secondary : AppColors.outline,
            width: 2,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: selected ? Colors.white : AppColors.gray),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : AppColors.gray,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
