
import 'package:flutter/material.dart';
import 'package:smart_house_app/widgets/user_header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              children: [
                UserHeader(),
              ],
            ),
          ),
        ),
      );
  }
}