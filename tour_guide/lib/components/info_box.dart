
import 'package:tour_guide/Screens/landmark_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tour_guide/components/bottom_modal_sheet.dart';
import 'package:tour_guide/components/container.dart';
import 'package:tour_guide/components/constants.dart';
import 'package:tour_guide/data.dart';
import 'package:tour_guide/weather_screen/components/location.dart';
final fireStore = FirebaseFirestore.instance;

class InfoBox extends StatelessWidget {
  final ancientImage;
  final ancientName;
  final ancientDetails;
  final lon;
  final lat;
  final onpress;
  final ontap;
  final collect;

  late var controllerName = TextEditingController();
  late var controllerImage = TextEditingController();
  late var controllerDetails = TextEditingController();
  late var controllerLon = TextEditingController();
  late var controllerLat = TextEditingController();

  final selectedCity = Data().selectedCity;

  InfoBox({this.ancientImage, this.ancientName,this.ancientDetails,this.lon,this.lat,this.ontap,this.onpress,this.collect});

  @override

  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.only(top: 6,bottom: 2,left: 8,right: 8),
          child: Expanded(
              child: GestureDetector(
                onTap: () async{
                  if(ontap==null){
                    Location location = Location();
                    await location.getAddress(lat, lon);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) =>
                              LandmarkDetails(name: ancientName,image: ancientImage,details: ancientDetails,lon: lon,lat: lat,address: location.addressLatLng)
                          ));
                  }else{// update/delete page
                    controllerName.text = ancientName;
                    controllerImage.text = ancientImage;
                    controllerDetails.text = ancientDetails;
                    controllerLon.text = lon.toString();
                    controllerLat.text = lat.toString();
                    showModalBottomSheet(context: context, builder: (context) =>
                    BottomModalSheet(
                      name: controllerName,
                      image: controllerImage,
                      details: controllerDetails,
                      lat: controllerLat,
                      lon: controllerLon,
                      updatefn: (){
                        // you need to pass controllers to ancient stream //
                        // Data().updateTextFields(controllerName, controllerImage, controllerImage,
                        //     controllerLat,controllerLon);
                        var data = Data(
                          textFieldName: controllerName.text,
                          textFieldImage: controllerImage.text,
                          textFieldDetails: controllerDetails.text,
                          textFieldLongitude: controllerLon.text,
                          textFieldLatitude: controllerLat.text
                        );
                        data.printText();
                        collect.reference.update({
                          'Name': data.textFieldName,
                          'Image': data.textFieldImage,
                          'details':data.textFieldDetails,
                        }).whenComplete(() => Navigator.pop(context));
                        print("updated");
                      },
                      deletefn: (){
                        collect.reference.delete();
                        print("deleted");
                      },
                    )
                    );

                  }
                },
                child: DecorativeContainer(
                  color: boxColor.withOpacity(0.5),
                  widget: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: 'image',
                            child: Image(
                              image: NetworkImage(ancientImage),width: 608,height: 405,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(ancientName,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ),
        );

  }
}



// StreamBuilder<QuerySnapshot>(
// stream: fireStore.collection(path).snapshots(),
// builder: (context, snapshot) {
// if(!snapshot.hasData){
// return Center(
// child: CircularProgressIndicator(
// backgroundColor: Colors.blueAccent,
// ),
// );
// }
// List<InfoBox> ancients = [];
// try {
// final collection = snapshot.data!.docs;
// for (var collect in collection) {
// final name = collect['Name'];
// final image = collect['Image'];
// final details = collect['details'];
// final location = collect['Location'];
// GeoPoint geoPoint = location;
// final lat = geoPoint.latitude;
// final lon = geoPoint.longitude;
//
// final collectionWidget = InfoBox(
// ancientName: name,
// ancientImage: image,
// ancientDetails: details,
// lon: lon,
// lat: lat,
// collect: collection,
// ontap: ontap,
// );
//
// ancients.add(collectionWidget);
// }
// }catch(e){
// print('problems in stream builder \n error : $e');
// }
// return Expanded(
// child:ListView(
// children: ancients,
// )
// );
// } ,
// );
