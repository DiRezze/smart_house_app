import 'package:flutter/material.dart';
import 'package:smart_house_app/routes/route_transitions.dart';
import 'package:smart_house_app/screens/landing_page.dart';
import 'package:smart_house_app/screens/login_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_)=> LandingPage());
      case '/login':
        return RouteTransitions.slideFromRight(LoginPage());
      default:
        return MaterialPageRoute(builder: (_)=>LandingPage());
    }

  }

}
