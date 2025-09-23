import 'package:flutter/material.dart';
import 'package:smart_house_app/models/device_model.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/devices/device_button_input.dart';
import 'package:smart_house_app/widgets/devices/device_icon_input.dart';
import 'package:smart_house_app/widgets/devices/device_text_input.dart';
import 'package:smart_house_app/widgets/layouts/devices_layout.dart';
import 'package:smart_house_app/widgets/popups/snack_bar.dart';

class AddDevicePage extends StatefulWidget {

  final Device? device; // null => criar | !=null => editar

  const AddDevicePage({
    super.key,
    this.device
  });

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage> {

  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _topicController = TextEditingController();
  int _selectedIcon = 0;
  final int _state = 0;

  @override
  void initState() {
    super.initState();
    if (widget.device != null) {
      _nameController.text = widget.device!.name;
      _topicController.text = widget.device!.topic;
      _selectedIcon = widget.device!.icon;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _topicController.dispose();
    super.dispose();
  }

  void _submit() async {
    try {
      setState(() => _isLoading = true);

      if (_formKey.currentState?.validate() ?? false) {
        if (widget.device == null) {
          // Criar novo
          final d = Device(
            id: '#',
            name: _nameController.text.trim(),
            icon: _selectedIcon,
            topic: _topicController.text.trim(),
            state: _state,
            lastUpdate: DateTime.now(),
          );

          await d.create();

          if (!mounted) return;

          AppSnackBar.showSuccess(context, "Dispositivo adicionado!");
        } else {

          // Editar existente
          final d = widget.device!;
          d.name = _nameController.text.trim();
          d.icon = _selectedIcon;
          d.topic = _topicController.text.trim();
          d.lastUpdate = DateTime.now();

          await d.update();

          if(!mounted) return;

          AppSnackBar.showSuccess(context, "Dispositivo atualizado!");

          Navigator.of(context).pop();

        }

        if (!mounted) return;

        Navigator.of(context).pop();
      }
    } catch (e) {
      AppSnackBar.showError(context, e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {

    final isEditing = widget.device != null;

    return DevicesLayout(
      title: isEditing ? "Editar dispositivo" : "Adicionar dispositivo",
      childWidget: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              SizedBox(height: 8,),
              DeviceTextInput(
                prefixIcon: Icons.label_rounded,
                labelText: "Nome do dispositivo",
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                obscureText: false,
              ),
              DeviceTextInput(
                prefixIcon: Icons.tag_rounded,
                labelText: "Tópico MQTT",
                controller: _topicController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o tópico';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              DeviceIconInput(
                onChanged: (value) {
                  setState(() {
                    _selectedIcon = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet: BottomSheet(
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
      )
    );
  }
}