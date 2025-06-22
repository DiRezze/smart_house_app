import 'package:flutter/material.dart';
import 'package:smart_house_app/services/prefs_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  String? displayName;
  double _nameOpacity = 0.0;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();

    _loadDisplayName();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadDisplayName() async {
    final name = await PrefsService().getString('displayName');
    setState(() {
      displayName = name ?? 'Usuário';
      _nameOpacity = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Perfil',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [AppColors.primary, AppColors.analogPrimary],                             begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                          Icon(Icons.person_rounded, color: Colors.white, size: 42),
                        ],
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: AnimatedOpacity(
                            opacity: _nameOpacity,
                            duration: const Duration(milliseconds: 200),
                          child: Text(
                            displayName ?? "Usuário",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(width: 8,),
                        Icon(Icons.pin_drop_rounded, color: Colors.white, size: 18),
                        Text(
                          "Garça, São Paulo | BRASIL",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  (displayName == null || displayName!.isEmpty)
                      ? AnimatedOpacity(
                      opacity: _nameOpacity,
                      duration: const Duration(milliseconds: 200),
                      child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Card(
                        color: AppColors.inputBackground,
                        margin: EdgeInsets.all(0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: Icon(Icons.error_outline_outlined, color: AppColors.primary,),
                              title: Text('Seu perfil está incompleto', style: TextStyle(color: Colors.white),),
                              subtitle: Text('Edite-o agora mesmo', style: TextStyle(color: AppColors.gray),),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  )
                  )
                      : const SizedBox.shrink(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.gray,
                        size: 18,
                      ),
                      onPressed: () => Navigator.of(context).pushNamed("/edit-profile"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: BorderSide(
                          color: AppColors.gray,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      label: const Text(
                        'Editar perfil',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Divider(
                    color: AppColors.gray,
                    height: 1,
                    thickness: 1,
                  ),
                  SizedBox(height: 16),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: 320,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 1,
                            color: AppColors.gray.withAlpha(77),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.navBackground.withAlpha(77),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(
                                'Visão geral',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}