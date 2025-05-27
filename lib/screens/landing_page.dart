

import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget{

  const LandingPage({super.key});

  @override
  Widget build(BuildContext context){
    final height30Percent = MediaQuery.of(context).size.height * 0.3;
    return Scaffold(
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

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: height30Percent,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                child: Column(
                  spacing: 12,
                  children: [

                    Text("Nome do app",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 48
                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/login');
                        },
                        child: Text("Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                      ),

                    ),


                    SizedBox(
                      width: double.infinity,
                      height: 42,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent, side: BorderSide(color: Colors.green, width: 2),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16)))
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/signup');
                        },
                        child: Text("Cadastro",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                      ),

                    ),

                    Spacer(),

                    Text("Background designed by FreePik",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                      ),
                    ),

                  ],
                ),
              ),

            ),

          

        ],
      ),
    );
  }
}