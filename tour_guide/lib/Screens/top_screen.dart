import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tour_guide/components/ancient_stream.dart';
import 'package:tour_guide/components/info_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TopAncientStream extends StatelessWidget {
  final path;
  TopAncientStream({@required this.path});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: fireStore.collection(path).limit(5).snapshots(),
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
          for (var collect in collection) {
            final name = collect['Name'];
            final image = collect['Image'];
            final details = collect['details'];
            final collectionWidget = InfoBox(
              ancientName: name,
              ancientImage: image,
              ancientDetails: details,
            );
            ancients.add(collectionWidget);
          }
        }catch(e){
          print('problems in stream builder TOP \n error : $e');
        }
        return Expanded(
            child:ListView(
              children: ancients,
            )
        );
      } ,
    );
  }
}
