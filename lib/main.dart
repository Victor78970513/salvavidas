import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salvavidas_app/core/shared_preferences/preferences.dart';
import 'package:salvavidas_app/features/home/pages/home_page.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:salvavidas_app/features/security/provider/security_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = Preferences();
  await prefs.init();
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => SecurityProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        title: 'Material App',
        home: const HomePage(),
      ),
    );
  }
}
