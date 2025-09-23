import 'package:flutter/material.dart';
import 'package:smart_house_app/constants/app_info.dart';
import 'package:smart_house_app/widgets/landing_button.dart';

class LandingPage extends StatelessWidget{

  const LandingPage({super.key});

  @override
  Widget build(BuildContext context){
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [

            Image.asset(
              'assets/landing.png',
              fit: BoxFit.cover,
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color.fromRGBO(0, 0, 0, 1.0),
                      Color.fromRGBO(0, 0, 0, 1.0),
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.30, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
              ),
            ),


            SafeArea(
              child:Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                  child: Column(
                    spacing: 12,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          Text("AutomaTec",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 48
                            ),
                          ),
                          Text("v${AppInfo.version}",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                            ),
                          ),
                        ],
                      ),

                      LandingButton(
                          text: "Login",
                          primary: true,
                          onPressed: () => Navigator.of(context).pushNamed('/login')
                      ),

                      LandingButton(
                          text: "Cadastro",
                          primary: false,
                          onPressed: () => Navigator.of(context).pushNamed('/signup')
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Column(
                          children: [
                            Text("Background designed by FreePik",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                              ),
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),

              ),

            ),

          ],
        ),
      ),
    );

  }
}
