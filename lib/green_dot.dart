import 'package:flutter/material.dart';
import 'package:green_dot/constants.dart';

class GreenDot extends StatefulWidget {
  @override
  _GreenDotState createState() => _GreenDotState();
}

class _GreenDotState extends State<GreenDot> {
  final initialButtonSize = 60.0;
  var buttonSize = 60.0;
  var isActive = false;
  final marginBottom = 30.0;
  final Duration _duration = Duration(milliseconds: 500);
  final Curve _curve = Curves.easeInOutBack;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;

      double outerCircleSize2 = buttonSize + 550 * (isActive ? 1 : 0);
      double outerCircleSize = buttonSize + 300 * (isActive ? 1 : 0);
      double midCircleSize = buttonSize - 8 + 100 * (isActive ? 1 : 0);
      double innerCircleSize = buttonSize - 40 + 40 * (isActive ? 1 : 0);

      return Stack(
        children: [
          AnimatedPositioned(
            curve: Curves.easeInOutBack,
            duration: _duration,
            left: maxWidth / 2 - outerCircleSize2 / 2,
            top: maxHeight -
                (initialButtonSize + marginBottom) -
                250 * (isActive ? 1 : 0),
            child: InkWell(
              onTap: () {
                setState(() {
                  isActive = !isActive;
                });
              },
              child: AnimatedContainer(
                curve: _curve,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[200]),
                duration: _duration,
                width: outerCircleSize2,
                height: outerCircleSize2,
                child: Center(
                  child: AnimatedContainer(
                    curve: _curve,
                    duration: _duration,
                    width: outerCircleSize,
                    height: outerCircleSize,
                    child: Center(
                      child: AnimatedContainer(
                        curve: _curve,
                        duration: _duration,
                        child: Center(
                          child: AnimatedContainer(
                            curve: _curve,
                            duration: _duration,
                            width: innerCircleSize,
                            height: innerCircleSize,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                        ),
                        width: midCircleSize,
                        height: midCircleSize,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 0.2,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
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
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
