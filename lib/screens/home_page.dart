import 'package:flutter/material.dart';
import 'package:smart_house_app/main.dart';
import 'package:smart_house_app/models/device_model.dart';
import 'package:smart_house_app/services/device_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/device_home_card.dart';
import 'package:smart_house_app/widgets/filter_section.dart';
import 'package:smart_house_app/widgets/user_header.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver, RouteAware {

  List<Device> _deviceList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadDevices();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route as PageRoute);
    }
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      loadDevices();
    }
  }

  @override
  void didPopNext() {
    loadDevices();
  }

  void loadDevices() async {
    final devices = await DeviceService().loadCachedDevices();
    if (mounted) {
      setState(() {
        _deviceList = devices;
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
                AnimationLimiter(
                  child: GridView.count(
                    key: UniqueKey(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      _deviceList.length,
                          (int index) {
                        final device = _deviceList[index];
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 300),
                          columnCount: 2,
                          child: SlideAnimation(
                            verticalOffset: 30.0,
                            child: FadeInAnimation(
                              child: DeviceHomeCard(device: device),
                            ),
                          ),
                        );
                      },
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}