import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_app/models/device_model.dart';
import 'package:smart_house_app/services/device_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/auth_input.dart';
import 'package:smart_house_app/widgets/device_home_card.dart';
import 'package:smart_house_app/widgets/filter_section.dart';
import 'package:smart_house_app/widgets/layouts/devices_layout.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  bool _loading = true;
  final bool _loadedOnce = false;

  final TextEditingController _searchController = TextEditingController();

  List<Device> _filteredDevices = [];

  @override
  void initState() {
    super.initState();
    _loadDevices();
    _searchController.addListener(_filterDevices);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterDevices() {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredDevices = DeviceCache().devices.where((device) {
        return device.name.toLowerCase().contains(query) ||
            device.topic.toLowerCase().contains(query);
      }).toList();
    });
  }


  Future<void> _loadDevices() async {
    try {
      final devices = await DeviceService().fetchDevices();
      DeviceCache().updateDevices(devices);
    } catch (e) {
      debugPrint("Erro ao buscar dispositivos: $e");
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DevicesLayout(
      title: "Meus dispositivos",
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/add-device");
        },
        isExtended: true,
        backgroundColor: AppColors.primary,
        tooltip: 'Adicionar dispositivo',
        child: const Icon(Icons.add),
      ),
      childWidget: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary,))
          : Column(
        children: [
          AuthInputField(
            labelText: "Pesquisar...",
            prefixIcon: CupertinoIcons.search,
            keyboardType: TextInputType.text,
            controller: _searchController,
          ),
          const SizedBox(height: 8),
          FilterSection(
            filters: ["Tudo", "Iluminação", "Aquecimento", "Segurança"],
            onSelected: (index) {
              // TODO: filtrar dispositivos
            },
          ),
          const SizedBox(height: 16),
          Column(
            children: _filteredDevices.isEmpty ?
            DeviceCache().devices
                .map((device) => DeviceHomeCard(device: device))
                .toList()
                :
            _filteredDevices
                .map((device) => DeviceHomeCard(device: device))
                .toList(),
          )
        ],
      ),
    );
  }
}

