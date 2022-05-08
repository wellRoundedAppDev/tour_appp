import 'dart:async';
import 'dart:collection';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:tour_guide/nearby_places/components/place_result.dart';
import 'package:tour_guide/nearby_places/components/place_item.dart';

import 'package:tour_guide/nearby_places/components/api.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:tour_guide/nearby_places/components/constants.dart';

class MapScreen extends StatefulWidget {
  final latitude;
  final longitude;

  MapScreen({this.longitude, this.latitude});
  @override
  State<MapScreen> createState() {
    return _MapScreen();
  }
}

class _MapScreen extends State<MapScreen> {
  @override
  void initState() {
    // latitude = widget.latitude;
    // longitude = widget.longitude;
    _myLocation = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      bearing: 192.0,
      tilt: 59.440717697143555,
      zoom: 16,
    );
    searchNearby();
    _setCircles(LatLng(widget.latitude, widget.longitude));
  }

  // static double latitude = 00.00;
  // static double longitude = 00.00;
  late CameraPosition _myLocation;
  List<Marker> markers = <Marker>[];
  Set<Circle> _circles = HashSet<Circle>();
  int _circleIdCounter = 1;
  late Error error;
  late List<Result> places = [];
  bool searching = true;

  String keyword = "";
  String serviceType = "restaurant";

  Completer<GoogleMapController> _controller = Completer();

  void _setCircles(LatLng point) {
    final String circleIdVal = 'circle_id_$_circleIdCounter';

    _circleIdCounter++;
    print(
        'Circle | Latitude: ${point.latitude}  Longitude: ${point.longitude}  Radius: $RADIUS');
    _circles.add(Circle(
        circleId: CircleId(circleIdVal),
        center: point,
        radius: RADIUS.toDouble(),
        fillColor: Colors.redAccent.withOpacity(0.1),
        strokeWidth: 3,
        strokeColor: Colors.redAccent));
  }

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    controller.setMapStyle(value);
  }

  void searchNearby() async {
    setState(() {
      markers.clear(); // 2
    });
    final data =
        await Api().getApi(widget.latitude, widget.longitude, serviceType);

    if (data.status == "OK") {
      _handleResponse(data);
    } else {
      throw Exception('An error occurred getting places nearby');
    }
  }

  void _handleResponse(PlaceResult data) {
    setState(() {
      places = data.results;

      for (int i = 0; i < places.length; i++) {
        markers.add(
          Marker(
            markerId: MarkerId(places[i].placeId),
            position: LatLng(places[i].geometry.location.lat,
                places[i].geometry.location.lng),
            infoWindow:
                InfoWindow(title: places[i].name, snippet: places[i].vicinity),
            onTap: () {},
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    title: Text("Services"),
                    scrollable: true,
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      TextButton(
                          onPressed: () {

                              serviceType = "restaurant";
                               searchNearby();
                            Navigator.of(context).pop();
                          },
                          child: Text("restaurants")),
                      TextButton(onPressed: () {
                        serviceType = "hospital";
                        searchNearby();
                        Navigator.of(context).pop();
                      }, child: Text("hospitals")),
                      TextButton(onPressed: () {
                        serviceType = "supermarket";
                        searchNearby();
                        Navigator.of(context).pop();
                      }, child: Text("supermarkets")),
                      TextButton(onPressed: () {
                        serviceType = "cafe";
                        searchNearby();
                        Navigator.of(context).pop();
                      }, child: Text("cafes")),
                      TextButton(onPressed: () {
                        serviceType = "atm";
                        searchNearby();
                        Navigator.of(context).pop();
                      }, child: Text("atms")),
                      TextButton(onPressed: () {
                        serviceType = "hotel";
                        searchNearby();
                        Navigator.of(context).pop();
                      }, child: Text("hotels")),

                      TextButton(onPressed: () {
                        serviceType = "parking";
                        searchNearby();
                        Navigator.of(context).pop();
                      }, child: Text("parkings")),
                      TextButton(onPressed: () {
                        serviceType = "pharmacy";
                        searchNearby();
                        Navigator.of(context).pop();
                      }, child: Text("pharmacies"))
                    ]);
              });
        },
        label: Text("Services"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _myLocation,
              onMapCreated: (GoogleMapController controller) {
                _setStyle(controller);
                _controller.complete(controller);
              },
              // onMapCreated: _onMapCreated,
              onCameraMove: (cameraPos) {},
              zoomControlsEnabled: true,
              compassEnabled: false,
              markers: Set<Marker>.of(markers),
              circles: _circles,
            ),
            places != null
                ? Positioned(
                    bottom: 48,
                    right: 12,
                    left: 12,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (ctx, i) => SizedBox(
                                width: 10,
                              ),
                          scrollDirection: Axis.horizontal,
                          itemCount: places.length,
                          itemBuilder: (ctx, i) => PlaceItem(places[i],
                              _controller, widget.latitude, widget.longitude)),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
