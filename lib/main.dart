import 'package:app_development_test/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Looking Autos',
      theme: ThemeData(
        // primarySwatch: Palette.palette1,
        // scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Outfit',
        // appBarTheme: const AppBarTheme(
        //   centerTitle: true,
        //   titleTextStyle: TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.w500,
        //     fontSize: 17,
        //   ),
        //   elevation: 0,
        //   backgroundColor: Colors.transparent,
        //   iconTheme: IconThemeData(
        //     color: Colors.black,
        //   ),
        // ),
      ),
      home: HomeView(),
    );
  }
}

class Palette {
  static const MaterialColor palette1 = MaterialColor(
    _palette1PrimaryValue,
    <int, Color>{
      50: Color(0xFFE8EBFF),
      100: Color(0xFFC5CEFF),
      200: Color(0xFF9EAEFF),
      300: Color(0xFF778DFF),
      400: Color(0xFF5A74FF),
      500: Color(_palette1PrimaryValue),
      600: Color(0xFF3754FF),
      700: Color(0xFF2F4AFF),
      800: Color(0xFF2741FF),
      900: Color(0xFF1A30FF),
    },
  );

  static const int _palette1PrimaryValue = 0xFF3D5CFF;
}
