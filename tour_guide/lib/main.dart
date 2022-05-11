import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:tour_guide/country_picker.dart';
import 'package:tour_guide/weather_screen/screens/location_screen.dart';
import 'package:tour_guide/weather_screen/components/weather.dart';
import 'Screens/home_screen.dart';
import 'components/constants.dart';
// import 'package:location/location.dart';
void main() {
  runApp(MyApp());
  Firebase.initializeApp();
}
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: primaryColor,
      ),
      home: AnimatedSplashScreen(
        splashIconSize: 250,
        splash: Image(
          image: AssetImage("images/logo.png"),
        ),
        nextScreen: HomeScreen(),
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}