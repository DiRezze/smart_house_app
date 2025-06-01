import 'package:flutter/material.dart';
import 'package:smart_house_app/routes/require_auth.dart';
import 'package:smart_house_app/routes/route_transitions.dart';
import 'package:smart_house_app/screens/app_page.dart';

// app pages
import 'package:smart_house_app/screens/landing_page.dart';
import 'package:smart_house_app/screens/login_page.dart';
import 'package:smart_house_app/screens/signup_page.dart';
import 'package:smart_house_app/screens/home_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_)=> LandingPage());
      case '/login':
        return RouteTransitions.slideFromRight(LoginPage());
      case '/signup':
        return RouteTransitions.slideFromRight(SignupPage());
      case '/home':
        return RouteTransitions.slideFromBottom(RequireAuth(child: HomePage()));
      case '/app':
        return RouteTransitions.slideFromBottom(RequireAuth(child: MainAppPage()));
      default:
        return MaterialPageRoute(builder: (_)=>LandingPage());
    }

  }

}
