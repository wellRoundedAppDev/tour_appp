import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tour_guide/weather_screen/screens/loading_screen.dart';
import 'package:tour_guide/weather_screen/screens/location_screen.dart';
import 'package:tour_guide/translate_screen/mainPage.dart';
import 'package:tour_guide/translate_screen/pages/home/home_page.dart';

import '../Screens/booking_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(accountName: Text('Mohamed Ahmed'), accountEmail: Text('mohamed.ahmed3343@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network('https://static.vecteezy.com/system/resources/previews/002/640/730/non_2x/default-avatar-placeholder-profile-icon-male-vector.jpg',
                fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.wb_sunny),
            title: Text('Weather'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
              return LoadingScreen();
            })),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text('Translation'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context){
              return MainPage();
            })),
          ),
          ListTile(
            leading: Icon(Icons.flight),
            title: Text('Saving Itinerary'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
          ),
          Divider(),
          ListTile(
            leading: Image.asset('images/booking.png',width: 30,height: 30,),
            title: Text('Booking'),
            onTap: () =>Navigator.push(context, MaterialPageRoute(builder: (context){
              return BookingPage();
            })),
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => exit(0),
          ),
        ],
      ),
    );
  }
}
