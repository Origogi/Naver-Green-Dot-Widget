import 'package:flutter/material.dart';
import 'package:green_dot/constants.dart';
import 'package:green_dot/util.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tuple/tuple.dart';

import 'icon_title.dart';

class GreenDot extends StatefulWidget {
  @override
  _GreenDotState createState() => _GreenDotState();
}

class _GreenDotState extends State<GreenDot>
    with SingleTickerProviderStateMixin {
  final initialButtonSize = 60.0;
  var buttonSize = 60.0;
  var isActive = false;
  var scaleValue = 0.0;
  var opacityValue = 0.0;

  final marginBottom = 40.0;
  final Duration _duration = Duration(milliseconds: 500);
  final Curve _curve = Curves.linear;

  Animation<double> _scaleAnimation;
  AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: _curve,
    );
    _scaleAnimation.addListener(() {
      setState(() {
        if (_scaleAnimation != null && _scaleAnimation.value != null)
          scaleValue = _scaleAnimation.value;
        opacityValue = _scaleAnimation.value;
      });
    });

    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;

      double outerCircleSize2 = buttonSize + 430 * scaleValue;
      double outerCircleSize = buttonSize + 250 * scaleValue;
      double midCircleSize = buttonSize - 15 + 75 * scaleValue;
      double innerCircleSize = buttonSize - 50 + 30 * scaleValue;

      Tuple2<double, double> originPoint =
          Tuple2(maxWidth / 2, maxHeight - marginBottom);

      return Stack(
        children: [
          Positioned(
            left: originPoint.item1 - outerCircleSize2 / 2,
            top: originPoint.item2 - outerCircleSize2 / 2,
            child: InkWell(
              onTap: () {
                setState(() {
                  if (isActive) {
                    _scaleController.reverse();
                  } else {
                    _scaleController.forward();
                  }
                  isActive = !isActive;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.grey[200]),
                width: outerCircleSize2,
                height: outerCircleSize2,
                child: Center(
                  child: Container(
                    width: outerCircleSize,
                    height: outerCircleSize,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: originPoint.item1 - getXY(-90, 110.0 * scaleValue).item1 - 15,
            top: originPoint.item2 + getXY(-90, 110.0 * scaleValue).item2 - 15,
            child: Opacity(
              opacity: opacityValue,
              child: IconTitle('검색', LineIcons.search),
            ),
          ),
          Positioned(
            left: originPoint.item1 - getXY(-45, 110.0 * scaleValue).item1 - 15,
            top: originPoint.item2 - getXY(-45, 110.0 * scaleValue).item2 - 15,
            child: Opacity(
              opacity: opacityValue,
              child: IconTitle('내 주변', LineIcons.map_marker),
            ),
          ),
          Positioned(
            left: originPoint.item1 + getXY(0, 110.0 * scaleValue).item1 - 15,
            top: originPoint.item2 - getXY(0, 110.0 * scaleValue).item2 - 15,
            child: Opacity(
              opacity: opacityValue,
              child: IconTitle('음성', LineIcons.microphone),
            ),
          ),
          Positioned(
            left: originPoint.item1 + getXY(-45, 110.0 * scaleValue).item1 - 15,
            top: originPoint.item2 - getXY(-45, 110.0 * scaleValue).item2 - 15,
            child: Opacity(
                opacity: opacityValue, child: IconTitle('음악', LineIcons.music)),
          ),
          Positioned(
            left: originPoint.item1 + getXY(-90, 110.0 * scaleValue).item1 - 15,
            top: originPoint.item2 - getXY(-90, 110.0 * scaleValue).item2 - 15,
            child: Opacity(
                opacity: opacityValue,
                child: IconTitle('렌즈', LineIcons.camera)),
          ),
          Positioned(
            left: originPoint.item1 - midCircleSize / 2,
            top: originPoint.item2 - midCircleSize / 2,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (isActive) {
                    _scaleController.reverse();
                  } else {
                    _scaleController.forward();
                  }
                  isActive = !isActive;
                });
              },
              child: Container(
                child: Center(
                  child: Container(
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
          ),
          Positioned(
            left: originPoint.item1 -
                getXY(90.0 - 90.0 * scaleValue, 200).item1 -
                15,
            top: originPoint.item2 -
                getXY(90.0 - 90.0 * scaleValue, 200).item2 -
                15,
            child: Opacity(
              opacity: 1,
              child: IconTitle('음성', LineIcons.microphone),
            ),
          ),
          Positioned(
            left: originPoint.item1 -
                getXY(70.0 - 90.0 * scaleValue, 200).item1 -
                15,
            top: originPoint.item2 -
                getXY(70.0 - 90.0 * scaleValue, 200).item2 -
                15,
            child: Opacity(
              opacity: 1,
              child: IconTitle('음성', LineIcons.microphone),
            ),
          ),
        ],
      );
    });
  }
}
