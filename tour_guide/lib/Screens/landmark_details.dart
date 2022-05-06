
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tour_guide/Screens/poltline_map.dart';
import 'package:tour_guide/components/constants.dart';
import 'package:tour_guide/components/container.dart';
import 'package:tour_guide/nearby_places/screens/map_screen.dart';
import 'package:tour_guide/shortest_path/main.dart';
import 'package:tour_guide/weather_screen/components/location.dart';

class LandmarkDetails extends StatelessWidget {
  LandmarkDetails({required this.name,required this.image,required this.details, this.lat, this.lon, this.address});
  final name;
  final image;
  final details;
  final lat;
  final lon;
  final address;
  var landAdress;
  var myAdress;
  var mylat;
  var mylon;

  Future<void> getLandAddress() async {
    Location location = Location();
    await location.getAddress(lat, lon);
    landAdress = location.addressLatLng;
  }
  Future<void> getMyAddress() async {
    Location location = Location();
    await location.getLocation();
    mylat = location.lat;
    mylon = location.long;
    await location.getAddress(mylat,mylon);
    myAdress = location.addressLatLng;
  }
  @override
  Widget build(BuildContext context) {
    return DecorativeContainer(
      height: 500,
      color: primaryColor,
      widget: Padding(
        padding: const EdgeInsets.only(left: 8,right: 8,top: 0,bottom: 0),
        child: ListView(
          children: [
            DecorativeContainer(
              height: 300,
              color: boxColor.withOpacity(0.5),
              widget: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image(
                  image: NetworkImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 5),
            DecorativeContainer(
              color: boxColor.withOpacity(0.5),
              height: name.toString().length.toDouble()*4.5,
              widget: Center(
                child: DefaultTextStyle(
                  child: Text(name),
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: detailsTextColor,
                  ),
                )
              ),
            ),
            SizedBox(height: 5),
            DecorativeContainer(
              color: boxColor.withOpacity(0.5),
              height: details.toString().length.toDouble()/2.5,
              widget: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0,right: 4),
                  child: Center(
                    child: DefaultTextStyle(
                      style: TextStyle(
                          fontSize: 12,
                          color: detailsTextColor
                      ),
                      child: Text(details),
                    ),
                  ),
                ),
              ),
            ),SizedBox(height: 5),
            DecorativeContainer(
              color: boxColor.withOpacity(0.5),
              height: 50,
              widget: Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0,right: 4),
                  child: Center(
                    child: DefaultTextStyle(
                      style: TextStyle(
                          fontSize: 12,
                          color: detailsTextColor
                      ),
                      child: Text(address)
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    child: DecorativeContainer(
                      color: boxColor.withOpacity(0.5),
                      widget: Icon(
                        Icons.location_on,
                        size: 50,
                      ),
                    ),
                    onTap: (){
                      getLandAddress();
                      getMyAddress();
                      print("$mylat - $mylon + $lat - $lon");
                      print("$myAdress");

                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          ShortestPath2(
                            landAdress: address,
                            myAdress: myAdress
                      )));
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: DecorativeContainer(
                      color: boxColor.withOpacity(0.5),
                      widget: Icon(
                        Icons.near_me,
                        size: 50,
                      ),
                    ),
                    onTap: (){
                      getLandAddress();
                      getMyAddress();
                      print("$mylat - $mylon + $lat - $lon");
                      print("$myAdress");
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                          MapScreen(latitude: lat,longitude: lon)));
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
