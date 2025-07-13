import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/utils/internet_utils.dart';
import 'package:smart_house_app/widgets/profile/profile_button.dart';

class BrokerCard extends StatefulWidget {

  const BrokerCard({
    super.key
  });
  @override
  State<StatefulWidget> createState() => _BrokerCardState();
}

class _BrokerCardState extends State<BrokerCard> {

  bool _isLoading = true;
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }


  void _checkConnection() async {
    setState(() {
      _isLoading = true;
    });
    final online = await InternetUtils.testConnection();
    setState(() {
      _isOnline = online;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
              'Minha casa',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            _isOnline ? 
              Icon(CupertinoIcons.house_fill, size: 48, color: AppColors.primary)
              :
               Icon(CupertinoIcons.wifi_slash, size: 48, color: AppColors.gray) 
            ,
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
            SizedBox(height: 16),
            Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileButton(
                    extend: false,
                    label: "Dispositivos",
                    icon: Icon(Icons.grid_view_rounded, color: Colors.white,),
                    onClick: () {
                      Navigator.of(context).pushNamed("/devices");
                    },
                ),
                ProfileButton(
                    extend: false,
                    label: _isOnline ? "Configurar" : "Sem conexão",
                    icon: Icon(Icons.settings_rounded, color: Colors.white,),
                    onClick: () {
                      Navigator.of(context).pushNamed("/edit-broker");
                    }
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

}
