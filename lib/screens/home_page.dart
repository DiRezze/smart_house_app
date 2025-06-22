import 'package:flutter/material.dart';
import 'package:smart_house_app/theme/app_colors.dart';
import 'package:smart_house_app/widgets/user_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              ],
            ),
          ),
        ),
      );
  }
}