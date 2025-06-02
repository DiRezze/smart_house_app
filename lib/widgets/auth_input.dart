import 'package:flutter/material.dart';
import 'package:smart_house_app/theme/app_colors.dart';

class AuthInputField extends StatefulWidget {
  final String labelText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final bool obscureText;

  const AuthInputField({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.keyboardType,
    this.validator,
    this.onSaved,
    this.obscureText = false,
    this.controller,
  });

  @override
  State<AuthInputField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<AuthInputField> {
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(widget.prefixIcon, color: AppColors.outline),
        suffixIcon: widget.obscureText
            ? IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_off : Icons.visibility,
            color: AppColors.outline,
          ),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
        )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.outline, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.selectOutline, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorOutline, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorOutline, width: 2),
        ),
        filled: true,
        fillColor: AppColors.background,
      ),
      style: const TextStyle(color: Colors.white),
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onSaved: widget.onSaved,
      obscureText: _obscure,
    );
  }
}
