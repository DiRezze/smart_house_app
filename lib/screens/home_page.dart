import 'package:flutter/material.dart';
import 'package:smart_house_app/models/device_model.dart';
import 'package:smart_house_app/services/device_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/device_home_card.dart';
import 'package:smart_house_app/widgets/filter_section.dart';
import 'package:smart_house_app/widgets/user_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Device> _deviceList = [];

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  void _loadDevices() async {
    final d = DeviceCache().devices;
    if(d.isNotEmpty){
      setState(() {
        _deviceList = d;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Center(
            child: Column(
              children: [
                UserHeader(),
                SizedBox(height: 8,),
                Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [AppColors.analogPrimary, Colors.cyan]
                    ),
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Center(
                    child: Text(
                      "Informações de clima",
                      style: TextStyle(
                          color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                FilterSection(
                  filters: ["Tudo", "Iluminação", "Aquecimento", "Segurança"],
                  onSelected: (index) {
                    // TODO: atualizar lista de dispositivos
                  },
                ),
                SizedBox(height: 16),
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: _deviceList
                      .map((device) => DeviceHomeCard(device: device))
                      .toList(),
                )
              ],
            ),
          ),
        ),
      );
  }
}