import 'package:flutter/material.dart';
import 'dart:math' as match;

const double _kAspectRatio = 0.56222;

class ResponsiveDesign {
  double _width, _height, _inch;

  ResponsiveDesign(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orient = MediaQuery.of(context).orientation;
    var aspectRatio = (MediaQuery.of(context).size.aspectRatio / _kAspectRatio)
        .clamp(0.5, 1.0);

    if (orient == Orientation.portrait) {
      _width = size.width;
      _height = size.height;
    } else {
      _width = size.height;
      _height = size.width;
    }

    _inch = match.sqrt(
      match.pow(_width * aspectRatio, 2) + match.pow(_height * aspectRatio, 2),
    );
  }

  double widthMultiplier(double pixel) {
    double tempPercent = (pixel * 100.0) / 375.0;
    return (_width * tempPercent) / 100;
  }

  double heightMultiplier(double pixel) {
    double tempPercent = (pixel * 100.0) / 667.0;
    return (_height * tempPercent) / 100;
  }

  double textMultiplier(double size) {
    double tempPercent = size / 9;
    return inchPercent(tempPercent);
  }

  double inchPercent(double percent) {
    return (_inch * percent) / 100;
  }

  double space() {
    return widthMultiplier(8.0);
  }
}
