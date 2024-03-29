import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tour_guide/weather_screen/components/location.dart';
import 'package:tour_guide/weather_screen/components/weather.dart';
import 'package:tour_guide/weather_screen/screens/location_screen.dart';




class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  Location location = Location();

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async{


    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LocationScreen(LocationWeaherData: weatherData);
    }));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitFadingFour(
          color: Colors.grey,
          size: 100.0,
        ),
      ),
    );
  }
}
