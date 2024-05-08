import 'package:flutter/material.dart';
import 'package:frontend/components/my_navBar.dart';
import 'package:frontend/pages/closet_page.dart';
import 'package:frontend/pages/preferences_page.dart';
import 'package:frontend/pages/saved_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home_page.dart';

void main() async {
  runApp(MyApp());
}

final ThemeData themeData = ThemeData(
  textTheme: GoogleFonts.outfitTextTheme(),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/homepage': (context) => MyNavBar(),
        '/closet': (context) => ClosetPage(),
        '/saved': (context) => SavedPage(),
        '/preference': (context) => PreferenceScreen(),
      },
    );
  }
}
