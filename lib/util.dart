import 'dart:math';

import 'package:tuple/tuple.dart';

Tuple2<double, double> getXY(double degree, double radius) {
  double radians = getRadiansFromDegree(degree);
  print("${sin(radians)} ${cos(radians)}");
  double x = sin(radians) * radius;
  double y = cos(radians) * radius;

  return Tuple2(x, y);
}

double getRadiansFromDegree(double degree) {
  double unitRadian = 57.295779513;
  return degree / unitRadian;
}
