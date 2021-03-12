import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin/helpers/Colors/color_guide.dart';
import 'package:linkedin/helpers/overlay_expandable/overlay_expandable.dart';
import 'package:linkedin/models/overlay_option_model.dart';

class RenderOverlay {
  RenderOverlay._();

  static OverlayExpandable getModal(
      OverlayOptionModel data,
      IconData pointTypeIcon,
      VoidCallback closePressed) {

    return OverlayExpandable(
      children: _getChildren(),
      buttonLabel: 'NAME',//data.name,
      onButtonPressed: () {},
      onClosedPressed: closePressed,
    );
  }

  static List<Widget> _getChildren() {
    List<Widget> elements = [];
    elements.add(Text("xx"));

    return elements;
  }
}
