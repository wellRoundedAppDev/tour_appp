import 'package:flutter/material.dart';
import 'package:tour_guide/components/ancient_stream.dart';
class Delete extends StatelessWidget {
  const Delete({Key? key}) : super(key: key);
  final String selectedCity = 'England';
  @override
  Widget build(BuildContext context) {
    return Container(
        child: AncientStream(path: selectedCity,ontap: '2')
    );
  }
}