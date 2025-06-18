import 'package:flutter/material.dart';
import 'package:smart_house_app/routes/auth_verifier.dart';
import 'package:smart_house_app/routes/require_auth.dart';
import 'package:smart_house_app/routes/route_transitions.dart';
import 'package:smart_house_app/screens/app_page.dart';
import 'package:smart_house_app/screens/edit_profile_page.dart';

// app pages
import 'package:smart_house_app/screens/landing_page.dart';
import 'package:smart_house_app/screens/login_page.dart';
import 'package:smart_house_app/screens/signup_page.dart';
import 'package:smart_house_app/screens/home_page.dart';
import 'package:smart_house_app/services/auth_service.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    // ignore: unused_local_variable
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AuthVerifier(authService: AuthService(),child: LandingPage(),));
      case '/login':
        return RouteTransitions.slideFromRight(LoginPage());
      case '/signup':
        return RouteTransitions.slideFromRight(SignupPage());
      case '/home':
        return RouteTransitions.slideFromBottom(RequireAuth(child: HomePage()));
      case '/app':
        return RouteTransitions.slideFromBottom(RequireAuth(child: MainAppPage()));
      case '/edit-profile':
        return RouteTransitions.slideFromBottom(RequireAuth(child: EditProfilePage()));
      default:
        return MaterialPageRoute(builder: (_)=>LandingPage());
    }

  }

}
