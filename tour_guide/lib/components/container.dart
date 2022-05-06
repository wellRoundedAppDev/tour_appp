import 'package:flutter/material.dart';
import 'package:tour_guide/components/constants.dart';
class DecorativeContainer extends StatelessWidget {
  DecorativeContainer({required this.widget,this.color=boxColor,this.height=100,this.width=400});
  final widget;
  final color;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('images/bg2.png'),
    // fit: BoxFit.fitWidth
            fit: BoxFit.fill
    ),
    color: color,
    border: Border.all(color: borderColor, width: 2),
    borderRadius: BorderRadius.circular(15)
    ),
    width: width,
    height: height,
    child: widget
    );
  }
}
