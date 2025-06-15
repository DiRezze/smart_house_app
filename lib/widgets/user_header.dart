import 'package:flutter/material.dart';
import 'package:smart_house_app/services/meta_service.dart';
import 'package:smart_house_app/services/prefs_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';

class UserHeader extends StatefulWidget {
  final String? location;
  final String? avatarUrl;
  final VoidCallback? onEdit;

  const UserHeader({
    super.key,
    this.location,
    this.avatarUrl,
    this.onEdit,
  });

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {
  String? displayName;

  @override
  void initState() {
    super.initState();
    _loadDisplayName();
  }

  Future<void> _loadDisplayName() async {
    final name = await PrefsService().getString('displayName');
    setState(() {
      displayName = name ?? 'usuário';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.house_rounded, color: Colors.white),
          const SizedBox(width: 8),
          const Text(
            "Olá,",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),
          ),
          const SizedBox(width: 4),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Color(0xFF53A0FD),
                AppColors.primary,
              ],
            ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
            blendMode: BlendMode.srcIn,
            child: Text(
              displayName ?? 'Usuário',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.grid_view_rounded),
            color: Colors.white,
            onPressed:  () async {
              await MetaService().updateMeta();
            },
          ),
        ],
      ),
    );
  }
}