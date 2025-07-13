import 'package:flutter/material.dart';
import 'package:smart_house_app/routes/auth_verifier.dart';
import 'package:smart_house_app/routes/require_auth.dart';
import 'package:smart_house_app/routes/route_transitions.dart';
import 'package:smart_house_app/screens/app_page.dart';
import 'package:smart_house_app/screens/broker_settings_page.dart';
import 'package:smart_house_app/screens/devices/add_device_page.dart';
import 'package:smart_house_app/screens/devices/devices_page.dart';
import 'package:smart_house_app/screens/settings/about_page.dart';
import 'package:smart_house_app/screens/settings/debug_page.dart';
import 'package:smart_house_app/screens/edit_profile_page.dart';

// app pages
import 'package:smart_house_app/screens/landing_page.dart';
import 'package:smart_house_app/screens/login_page.dart';
import 'package:smart_house_app/screens/settings/user_settings_page.dart';
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
      case '/devices':
        return RouteTransitions.slideFromBottom(RequireAuth(child: DevicePage()));
      case '/add-device':
        return RouteTransitions.fade(RequireAuth(child: AddDevicePage()));
      case '/edit-profile':
        return RouteTransitions.slideFromBottom(RequireAuth(child: EditProfilePage()));
      case '/edit-broker':
        return RouteTransitions.slideFromBottom(RequireAuth(child: BrokerSettingsPage()));
      case '/about':
        return RouteTransitions.slideFromBottom(RequireAuth(child: AboutPage()));
      case '/user-settings':
        return RouteTransitions.slideFromBottom(RequireAuth(child: UserSettingsPage()));
      case '/debug':
        return RouteTransitions.slideFromBottom(RequireAuth(child: DebugPage()));
      default:
        return MaterialPageRoute(builder: (_)=>LandingPage());
    }

  }

}
