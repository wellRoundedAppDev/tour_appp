import 'package:flutter/material.dart';
import 'package:tour_guide/components/constants.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({required this.title, required this.colour, required this.onPressed});

  final Color colour;
  final String title;
  final onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: bigTextColor,
            ),
          ),
        ),
      ),
    );
  }
}