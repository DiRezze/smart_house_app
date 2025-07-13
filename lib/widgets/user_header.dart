import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  double _nameOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _loadDisplayName();
  }

  Future<void> _loadDisplayName() async {
    final name = await PrefsService().getString('displayName');
    setState(() {
      displayName = name ?? 'usuário';
      _nameOpacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: Row(
        children: [
          const Icon(CupertinoIcons.house_fill, color: Colors.white),
          const SizedBox(width: 8),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 100),
            opacity: _nameOpacity,
            curve: Curves.easeIn,
              child: Text(
                "Olá,",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600
                ),
              ),
          ),
          const SizedBox(width: 4),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _nameOpacity,
            curve: Curves.easeIn,
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [
                  AppColors.analogPrimary,
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
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.grid_view_rounded),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed('/devices');
            },
          ),
        ],
      ),
    );
  }
}