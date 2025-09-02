import 'package:flutter/material.dart';
import 'package:smart_house_app/services/prefs_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/profile/broker_card.dart';
import 'package:smart_house_app/widgets/profile/profile_button.dart';

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
      duration: const Duration(milliseconds: 500),
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

                  (displayName != null && displayName!.isNotEmpty)
                      ? const SizedBox(height: 8)
                      : AnimatedOpacity(
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
                    ),
                  ),
                  ProfileButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: "Editar perfil",
                    onClick: () => Navigator.of(context).pushNamed("/edit-profile"),
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
                      child: BrokerCard()
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