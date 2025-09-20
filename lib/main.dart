import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smart_house_app/routes/route_generator.dart';
import 'package:flutter/services.dart';
import 'package:smart_house_app/services/device_service.dart';
import 'package:smart_house_app/services/firebase_options.dart';
import 'package:smart_house_app/services/meta_service.dart';
import 'package:smart_house_app/theme/app_colors.dart';


final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await MetaService().updateMeta();
  await DeviceService().updateDevices();

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.greenAccent,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      navigatorObservers: [routeObserver],
    );
  }
}
