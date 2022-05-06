import 'package:flutter/material.dart';
import 'package:tour_guide/Screens/near_screen.dart';
import 'package:tour_guide/Screens/top_screen.dart';
import 'package:tour_guide/components/constants.dart';
import 'package:tour_guide/components/ancient_stream.dart';
import 'package:provider/provider.dart';
import 'package:tour_guide/components/navbar.dart';
class GuideScreen extends StatefulWidget {
  GuideScreen({required this.city});
  static const String id = 'GuideScreen';
  final String city;

  @override
  _GuideScreenState createState() => _GuideScreenState();
}

class _GuideScreenState extends State<GuideScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          automaticallyImplyLeading: false,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                unselectedLabelColor: primaryColor,
                tabs: [
                  Tab(text: 'Guide',),
                  Tab(text: 'Top',),
                  Tab(text: 'Near',),
                ],
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AncientStream(path: widget.city),
            TopAncientStream(path: widget.city),
            NearAncientStream(path: widget.city),
          ],
        ),
      ),
    );
  }
}