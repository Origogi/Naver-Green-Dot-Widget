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
  static const double MARGIN_BOTTOM = 35.0;

  final buttonSize = 60.0;

  var isActive = false;
  var _scaleValue = 0.0;
  var _innerIconOpacityValue = 0.0;
  var _outerIconOpacityValue = 0.0;

  var _position = -1.0;
  var _fixedPositionStart = 0.0;
  var _fixedPositionEnd = 0.0;

  Animation<double> _scaleAnimation;
  AnimationController _scaleController;

  Animation<double> _movingAnimation;
  AnimationController _movingController;

  Animation<double> _movingFixedPositionAnitmation;
  AnimationController _movingFixedPositionController;

  double current;
  double distance;

  List<double> _fixedPosition;
  double maxPosition;
  double minPosition;

  List<IconTitleData> _outerIconTitleDataList;

  void initFixedPosition(int count) {
    int remain = count - 4;
    var value = 1.0 - 0.145 * (remain ~/ 2);
    _fixedPosition = [];

    while (remain > 0) {
      _fixedPosition.add(value);
      value += 0.145;
      remain--;
    }
    minPosition = _fixedPosition[0] - 0.08;
    maxPosition = _fixedPosition[_fixedPosition.length - 1] + 0.08;
  }

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

    _movingFixedPositionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _movingFixedPositionAnitmation = CurvedAnimation(
      parent: _movingFixedPositionController,
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

    _movingFixedPositionAnitmation.addListener(() {
      setState(() {
        final value = _movingFixedPositionAnitmation.value;

        final diff = (_fixedPositionStart - _fixedPositionEnd).abs();

        setState(() {
          if (_fixedPositionStart > _fixedPositionEnd) {
            _position = _fixedPositionStart - diff * value;
          } else {
            _position = _fixedPositionStart + diff * value;
          }
        });
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

    _outerIconTitleDataList = [
      IconTitleData('images/naver/address.png', '주소록'),
      IconTitleData('images/naver/shopping.png', '쇼핑'),
      IconTitleData('images/naver/vlive.png', 'V LIVE'),
      IconTitleData('images/naver/map.png', '지도'),
      IconTitleData('images/naver/pay.png', '페이'),
      IconTitleData('images/naver/webtoon.png', '웹툰'),
      IconTitleData('images/naver/stock.png', '주식'),
      IconTitleData('images/naver/note.png', '쪽지'),
      IconTitleData('images/naver/papago.png', '파파고'),
      IconTitleData('images/naver/calendar.png', '일정'),
    ];

    initFixedPosition(_outerIconTitleDataList.length);

    _movingController.addListener(() {
      setState(() {
        _position = _fixedPosition[0] * _movingAnimation.value +
            (_movingAnimation.value - 1.0);
        print(_position);
      });
    });
  }

  List<Widget> getInnerCircleIcons(Tuple2<double, double> originPoint) {
    return [
      Positioned(
        left: originPoint.item1 - getXY(-100, 140.0 * _scaleValue).item1 - 15,
        top: originPoint.item2 + getXY(-100, 140.0 * _scaleValue).item2 - 15,
        child: Opacity(
          opacity: _innerIconOpacityValue,
          child: IconTitle(
            '검색',
            Icon(
              LineIcons.search,
              color: mintColor,
            ),
          ),
        ),
      ),
      Positioned(
        left: originPoint.item1 - getXY(-40, 140.0 * _scaleValue).item1 - 15,
        top: originPoint.item2 - getXY(-40, 140.0 * _scaleValue).item2 - 15,
        child: Opacity(
          opacity: _innerIconOpacityValue,
          child: IconTitle(
            '내 주변',
            Icon(
              LineIcons.map_marker,
              color: mintColor,
            ),
          ),
        ),
      ),
      Positioned(
        left: originPoint.item1 + getXY(0, 140.0 * _scaleValue).item1 - 15,
        top: originPoint.item2 - getXY(0, 140.0 * _scaleValue).item2 - 15,
        child: Opacity(
          opacity: _innerIconOpacityValue,
          child: IconTitle(
            '음성',
            Icon(
              LineIcons.microphone,
              color: mintColor,
            ),
          ),
        ),
      ),
      Positioned(
        left: originPoint.item1 + getXY(-40, 140.0 * _scaleValue).item1 - 15,
        top: originPoint.item2 - getXY(-40, 140.0 * _scaleValue).item2 - 15,
        child: Opacity(
            opacity: _innerIconOpacityValue,
            child: IconTitle(
              '음악',
              Icon(
                LineIcons.music,
                color: mintColor,
              ),
            )),
      ),
      Positioned(
        left: originPoint.item1 + getXY(-80, 140.0 * _scaleValue).item1 - 15,
        top: originPoint.item2 - getXY(-80, 140.0 * _scaleValue).item2 - 15,
        child: Opacity(
            opacity: _innerIconOpacityValue,
            child: IconTitle(
              '렌즈',
              Icon(
                LineIcons.camera,
                color: mintColor,
              ),
            )),
      ),
    ];
  }

  List<Widget> getOuterCircleIcons(Tuple2<double, double> originPoint) {
    final radius = 270.0 * _scaleValue;

    List<Widget> outerIconList = [];

    var degree = -110.0 + 16.0 * (_outerIconTitleDataList.length ~/ 2);

    for (final iconTitleData in _outerIconTitleDataList) {
      final tuple = getXY(degree + 110.0 * _position, radius);

      outerIconList.add(Positioned(
        left: originPoint.item1 - tuple.item1 - 15,
        top: originPoint.item2 - tuple.item2 - 15,
        child: Opacity(
          opacity: _outerIconOpacityValue,
          child: IconTitle(iconTitleData.title,
              Image.asset(iconTitleData.imageUri, package: 'green_dot')),
        ),
      ));

      degree -= 16.0;
    }
    return outerIconList;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth;

      double outerCircleSize2 = buttonSize + 570 * _scaleValue;
      double outerCircleSize = buttonSize + 350 * _scaleValue;
      double midCircleSize = buttonSize - 15 + 75 * _scaleValue;
      double innerCircleSize = buttonSize - 50 + 30 * _scaleValue;

      Tuple2<double, double> originPoint =
          Tuple2(maxWidth / 2, maxHeight - MARGIN_BOTTOM);

      return Stack(
        children: [
          Positioned(
            left: originPoint.item1 - outerCircleSize2 / 2,
            top: originPoint.item2 - outerCircleSize2 / 2,
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
          ...getInnerCircleIcons(originPoint),
          ...getOuterCircleIcons(originPoint),
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
            left: originPoint.item1 - outerCircleSize2 / 2,
            top: originPoint.item2 - outerCircleSize2 / 2,
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
              onHorizontalDragStart: (DragStartDetails details) {
                current = details.globalPosition.dx;
              },
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                print("Drag update");

                distance = details.globalPosition.dx - current;
                current = details.globalPosition.dx;

                setState(() {
                  var calcDistance = _position - (distance / 300.0);

                  if (calcDistance > maxPosition) {
                    calcDistance = maxPosition;
                  } else if (calcDistance < minPosition) {
                    calcDistance = minPosition;
                  }

                  _position = calcDistance;
                });
              },
              onHorizontalDragEnd: (DragEndDetails details) {
                print("Drag end");

                double target = _fixedPosition[0];
                double targetDiff = (_position - target).abs();

                for (num d in _fixedPosition) {
                  if ((d - _position).abs() < targetDiff) {
                    target = d;
                    targetDiff = (d - _position).abs();
                  }
                }

                _fixedPositionStart = _position;
                _fixedPositionEnd = target;
                _movingFixedPositionController.reset();
                _movingFixedPositionController.forward();
              },
              child: Container(
                width: outerCircleSize2,
                height: outerCircleSize2,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.transparent),
              ),
            ),
          ),
        ],
      );
    });
  }
}
