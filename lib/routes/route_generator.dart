import 'package:flutter/material.dart';
import 'package:smart_house_app/models/device_model.dart';
import 'package:smart_house_app/routes/auth_verifier.dart';
import 'package:smart_house_app/routes/require_auth.dart';
import 'package:smart_house_app/routes/route_transitions.dart';
import 'package:smart_house_app/screens/app_page.dart';
import 'package:smart_house_app/screens/devices/device_info_page.dart';
import 'package:smart_house_app/screens/profile/broker_settings_page.dart';
import 'package:smart_house_app/screens/devices/add_device_page.dart';
import 'package:smart_house_app/screens/devices/devices_page.dart';
import 'package:smart_house_app/screens/settings/about_page.dart';
import 'package:smart_house_app/screens/settings/debug_page.dart';
import 'package:smart_house_app/screens/profile/edit_profile_page.dart';

// app pages
import 'package:smart_house_app/screens/auth/landing_page.dart';
import 'package:smart_house_app/screens/auth/login_page.dart';
import 'package:smart_house_app/screens/settings/user_settings_page.dart';
import 'package:smart_house_app/screens/auth/signup_page.dart';
import 'package:smart_house_app/screens/home_page.dart';
import 'package:smart_house_app/services/auth_service.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {

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
        return RouteTransitions.slideFromRight(RequireAuth(child: AddDevicePage()));
      case '/edit-profile':
        return RouteTransitions.slideFromBottom(RequireAuth(child: EditProfilePage()));
      case '/edit-broker':
        return RouteTransitions.slideFromBottom(RequireAuth(child: BrokerSettingsPage()));
      case '/device-info':
        if (args is Device) {
          return RouteTransitions.zoomIn(
            RequireAuth(child: DeviceInfoPage(device: args)),
          );
        }
        return RouteTransitions.slideFromBottom(RequireAuth(child: HomePage()));
      case '/edit-device':
        return RouteTransitions.zoomIn(RequireAuth(child: AddDevicePage()));
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
