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

class _GreenDotState extends State<GreenDot> with TickerProviderStateMixin {
  final initialButtonSize = 60.0;
  var buttonSize = 60.0;
  var isActive = false;

  var _scaleValue = 0.0;
  var _innerIconOpacityValue = 0.0;
  var _outerIconOpacityValue = 0.0;

  var _movingValue = 0.0;

  final marginBottom = 40.0;

  Animation<double> _scaleAnimation;
  AnimationController _scaleController;

  Animation<double> _movingAnimation;
  AnimationController _movingController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOutBack,
    );

    _movingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _movingAnimation = CurvedAnimation(
      parent: _movingController,
      curve: Curves.ease,
    );

    _scaleAnimation.addListener(() {
      setState(() {
        _scaleValue = _scaleAnimation.value;
        _innerIconOpacityValue = _scaleAnimation.value;

        if (isActive && _scaleValue == 1.0) {
          _outerIconOpacityValue = 1.0;
        } else if (!isActive) {
          _outerIconOpacityValue = _innerIconOpacityValue;
        }

        if (_innerIconOpacityValue > 1 || _outerIconOpacityValue > 1) {
          _innerIconOpacityValue = 1;
          _outerIconOpacityValue = 1;
        }
        if (_innerIconOpacityValue < 0 || _outerIconOpacityValue < 0) {
          _innerIconOpacityValue = 0;
          _outerIconOpacityValue = 0;
        }
      });
    });

    _scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _movingController.forward(from: 0.0);
      } else if (status == AnimationStatus.dismissed) {
        _movingController.reset();
      } else if (status == AnimationStatus.reverse) {
        _outerIconOpacityValue = _innerIconOpacityValue;
      } else {
        _outerIconOpacityValue = 0.0;
      }
    });

    _movingController.addListener(() {
      setState(() {
        _movingValue = _movingAnimation.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;

      double outerCircleSize2 = buttonSize + 430 * _scaleValue;
      double outerCircleSize = buttonSize + 250 * _scaleValue;
      double midCircleSize = buttonSize - 15 + 75 * _scaleValue;
      double innerCircleSize = buttonSize - 50 + 30 * _scaleValue;

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
            left:
                originPoint.item1 - getXY(-90, 110.0 * _scaleValue).item1 - 15,
            top: originPoint.item2 + getXY(-90, 110.0 * _scaleValue).item2 - 15,
            child: Opacity(
              opacity: _innerIconOpacityValue,
              child: IconTitle('검색', LineIcons.search),
            ),
          ),
          Positioned(
            left:
                originPoint.item1 - getXY(-45, 110.0 * _scaleValue).item1 - 15,
            top: originPoint.item2 - getXY(-45, 110.0 * _scaleValue).item2 - 15,
            child: Opacity(
              opacity: _innerIconOpacityValue,
              child: IconTitle('내 주변', LineIcons.map_marker),
            ),
          ),
          Positioned(
            left: originPoint.item1 + getXY(0, 110.0 * _scaleValue).item1 - 15,
            top: originPoint.item2 - getXY(0, 110.0 * _scaleValue).item2 - 15,
            child: Opacity(
              opacity: _innerIconOpacityValue,
              child: IconTitle('음성', LineIcons.microphone),
            ),
          ),
          Positioned(
            left:
                originPoint.item1 + getXY(-45, 110.0 * _scaleValue).item1 - 15,
            top: originPoint.item2 - getXY(-45, 110.0 * _scaleValue).item2 - 15,
            child: Opacity(
                opacity: _innerIconOpacityValue,
                child: IconTitle('음악', LineIcons.music)),
          ),
          Positioned(
            left:
                originPoint.item1 + getXY(-90, 110.0 * _scaleValue).item1 - 15,
            top: originPoint.item2 - getXY(-90, 110.0 * _scaleValue).item2 - 15,
            child: Opacity(
                opacity: _innerIconOpacityValue,
                child: IconTitle('렌즈', LineIcons.camera)),
          ),
          Positioned(
            left: originPoint.item1 -
                getXY(-65.0 + 110.0 * _movingValue, 200.0 * _scaleValue).item1 -
                15,
            top: originPoint.item2 -
                getXY(-65.0 + 110.0 * _movingValue, 200.0 * _scaleValue).item2 -
                15,
            child: Opacity(
              opacity: _outerIconOpacityValue,
              child: IconTitle('음성', LineIcons.microphone),
            ),
          ),
          Positioned(
            left: originPoint.item1 -
                getXY(-87.5 + 110.0 * _movingValue, 200.0 * _scaleValue).item1 -
                15,
            top: originPoint.item2 -
                getXY(-87.5 + 110.0 * _movingValue, 200.0 * _scaleValue).item2 -
                15,
            child: Opacity(
              opacity: _outerIconOpacityValue,
              child: IconTitle('음성', LineIcons.microphone),
            ),
          ),
          Positioned(
            left: originPoint.item1 -
                getXY(-110.0 + 110.0 * _movingValue, 200.0 * _scaleValue)
                    .item1 -
                15,
            top: originPoint.item2 -
                getXY(-110.0 + 110.0 * _movingValue, 200.0 * _scaleValue)
                    .item2 -
                15,
            child: Opacity(
              opacity: _outerIconOpacityValue,
              child: IconTitle('음성', LineIcons.microphone),
            ),
          ),
          Positioned(
            left: originPoint.item1 -
                getXY(-132.5 + 110.0 * _movingValue, 200.0 * _scaleValue)
                    .item1 -
                15,
            top: originPoint.item2 -
                getXY(-132.5 + 110.0 * _movingValue, 200.0 * _scaleValue)
                    .item2 -
                15,
            child: Opacity(
              opacity: _outerIconOpacityValue,
              child: IconTitle('음성', LineIcons.microphone),
            ),
          ),
          Positioned(
            left: originPoint.item1 -
                getXY(-155.0 + 110.0 * _movingValue, 200.0 * _scaleValue)
                    .item1 -
                15,
            top: originPoint.item2 -
                getXY(-155.0 + 110.0 * _movingValue, 200.0 * _scaleValue)
                    .item2 -
                15,
            child: Opacity(
              opacity: _outerIconOpacityValue,
              child: IconTitle('음성', LineIcons.microphone),
            ),
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
        ],
      );
    });
  }
}
