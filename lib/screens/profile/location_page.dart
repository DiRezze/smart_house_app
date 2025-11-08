import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_app/services/auth_service.dart';
import 'package:smart_house_app/services/prefs_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/auth_input.dart';
import 'package:smart_house_app/widgets/devices/device_button_input.dart';
import 'package:smart_house_app/widgets/layouts/devices_layout.dart';
import 'package:smart_house_app/widgets/popups/snack_bar.dart';

class LocationPage extends StatefulWidget {

  const LocationPage({super.key});

  @override
  State<StatefulWidget> createState() => _LocationPageState();

}

class _LocationPageState extends State<LocationPage> {

  Future<void> _loadPrefs() async {
    final prefCity = await PrefsService().getString("city");
    if (prefCity != null && prefCity.isNotEmpty) {
      try {

        setState(() {
          _cityController.text = prefCity;
        });

      } catch (e) {
        if(!mounted) return;
        AppSnackBar.showError(context, "Erro ao buscar dados");
      }
    } else {
      setState(() {
        _cityController.text = "";
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
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
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
        final ref = db.ref("users/$uid/meta");

        final input = _cityController.text.trim();

        final data = {
          'city': input
        };

        await ref.set(data);

        PrefsService().setString("city", input);

        if (!mounted) return;
        Navigator.of(context).pop();

        AppSnackBar.showSuccess(context, "Cidade atualizada!");
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
      title: "Localização",
      showBackButton: true,
      childWidget: Form(
        key: _formKey,
        child: Column(
          spacing: 16,
          children: [
            Text(
              "Defina sua cidade",
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
                  labelText: "Cidade",
                  prefixIcon: CupertinoIcons.building_2_fill,
                  obscureText: false,
                  keyboardType: TextInputType.url,
                  controller: _cityController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Insira algum nome';
                    }
                    return null;
                  },
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
