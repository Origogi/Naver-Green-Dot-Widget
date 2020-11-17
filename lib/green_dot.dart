import 'package:flutter/material.dart';
import 'package:green_dot/constants.dart';

class GreenDot extends StatefulWidget {
  @override
  _GreenDotState createState() => _GreenDotState();
}

class _GreenDotState extends State<GreenDot> {
  var buttonSize = 60.0;
  var marginBottom = 30.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;

      return Stack(
        children: [
          Positioned(
            left: maxWidth / 2 - buttonSize / 2,
            top: maxHeight - (buttonSize + marginBottom),
            child: Container(
              width: buttonSize,
              height: buttonSize,
              child: Center(
                child: Container(
                  child: Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 0.2,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.5, 0.6, 1],
                          colors: [greenColor, mintColor, blueColor])),
                ),
              ),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            ),
          ),
        ],
      );
    });
  }
}
