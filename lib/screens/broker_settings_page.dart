import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_app/models/broker_model.dart';
import 'package:smart_house_app/services/auth_service.dart';
import 'package:smart_house_app/services/prefs_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/auth_input.dart';
import 'package:smart_house_app/widgets/devices/device_button_input.dart';
import 'package:smart_house_app/widgets/layouts/devices_layout.dart';
import 'package:smart_house_app/widgets/popups/snack_bar.dart';
import 'package:smart_house_app/widgets/profile/profile_button.dart';
import 'package:smart_house_app/widgets/text_divider.dart';

class BrokerSettingsPage extends StatefulWidget {

  const BrokerSettingsPage({super.key});

  @override
  State<StatefulWidget> createState() => _BrokerSettingsPageState();

}

class _BrokerSettingsPageState extends State<BrokerSettingsPage> {

  Future<void> _loadPrefs() async {
    final brokerString = await PrefsService().getString("broker");
    if (brokerString != null && brokerString.isNotEmpty) {
      try {
        final decoded = jsonDecode(brokerString);
        final broker = Broker.fromJson(decoded);

        setState(() {
          _urlController.text = broker.url;
          _userController.text = broker.user;
          _passController.text = broker.pass;
        });

      } catch (e) {
        if(!mounted) return;
        AppSnackBar.showError(context, "Erro ao buscar dados");
      }
    } else {
      setState(() {
        _urlController.text = "";
        _userController.text = "";
        _passController.text = "";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _submit() async {
    try {
      if (_formKey.currentState?.validate() ?? false) {

        setState(() {
          _isLoading = true;
        });

        final uid = AuthService().currentUser?.uid;

        if (uid == null) throw Exception("Sem usuário logado");

        final db = FirebaseDatabase.instance;
        final ref = db.ref("users/$uid/broker");

        final data = {
          'url': _urlController.text.trim(),
          'user': _userController.text.trim(),
          'password': _passController.text,
        };

        await ref.set(data);

        final broker = Broker(
          url: _urlController.text.trim(),
          user: _userController.text.trim(),
          pass: _passController.text,
        );

        final brokerJson = jsonEncode(broker.toJson());

        PrefsService().setString("broker", brokerJson);

        if (!mounted) return;
        Navigator.of(context).pop();

        AppSnackBar.showSuccess(context, "Broker atualizado!");
      }
    } catch (e) {
      AppSnackBar.showError(context, e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return DevicesLayout(
      title: "Minha central",
      showBackButton: true,
      childWidget: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          children: [
            Text(
              "Configuração manual",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),
            ),
            Column(
              spacing: 8,
              children: [
                AuthInputField(
                    labelText: "URL",
                    prefixIcon: CupertinoIcons.link,
                    obscureText: false,
                    keyboardType: TextInputType.url,
                  controller: _urlController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                    return 'Informe o URL';
                    }
                    return null;
                  },
                ),
                AuthInputField(
                    labelText: "Usuário",
                    prefixIcon: CupertinoIcons.person_crop_circle_badge_checkmark,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                  controller:  _userController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o usuário';
                    }
                    return null;
                  },
                ),
                AuthInputField(
                    labelText: "Senha",
                    prefixIcon: CupertinoIcons.creditcard_fill,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                  controller: _passController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe a senha';
                    }
                    return null;
                  },
                ),
                TextDivider(text: "ou"),
                ProfileButton(
                  icon: Icon(Icons.qr_code_2_rounded, color: Colors.white),
                  extend: true,
                  label: "Configurar com QR Code",
                  tint: AppColors.primary,
                ),
              ],
            )
          ],
        ),
      ),
      bottomSheet: keyboardOpen ? null : BottomSheet(
          backgroundColor: AppColors.inputBackground,
          onClosing: () {},
          builder: (context) {
            return SafeArea(
              child: _isLoading ?
              Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
                  child: LinearProgressIndicator(
                    backgroundColor: AppColors.gray,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  )
              )
                  :
              Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 20),
                child:  Row(
                  children: [
                    Expanded(
                      child: DeviceButtonInput(
                        primary: false,
                        text: "Cancelar",
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: DeviceButtonInput(
                        primary: true,
                        text: "Salvar",
                        onPressed: _submit,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
    );

  }

}
