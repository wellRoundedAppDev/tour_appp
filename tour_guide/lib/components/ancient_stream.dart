
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tour_guide/Screens/landmark_details.dart';
import 'package:tour_guide/components/bottom_modal_sheet.dart';
import 'package:tour_guide/components/constants.dart';
import 'package:tour_guide/components/container.dart';
import 'info_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//b2ra mn firebase mn 2wl hena
var collected;
class AncientStream extends StatelessWidget {
  final path;
  final ontap;
  late String name;
  late String image;
  late String details;
  late GeoPoint location;

  AncientStream({required this.path,this.ontap});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStore.collection(path).snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,
            ),
          );
        }
        List<InfoBox> ancients = [];
        try {
          final collection = snapshot.data!.docs;
          for (collected in collection) {
            final name = collected['Name'];
            final image = collected['Image'];
            final details = collected['details'];
            final location = collected['Location'];
            GeoPoint geoPoint = location;
            final lat = geoPoint.latitude;
            final lon = geoPoint.longitude;

            final collectionWidget = InfoBox(
              ancientName: name,
              ancientImage: image,
              ancientDetails: details,
              lon: lon,
              lat: lat,
              collect: collected,
              ontap: ontap,
            );

            ancients.add(collectionWidget);
          }
        }catch(e){
          print('problems in stream builder \n error : $e');
        }
        return Expanded(
            child:ListView(
              children: ancients,
            )
        );
      }
    );
  }
}







