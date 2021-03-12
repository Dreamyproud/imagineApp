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
      children: _getChildren(data, data, pointTypeIcon),
      buttonLabel: 'NAME',//data.name,
      onButtonPressed: () {},
      onClosedPressed: closePressed,
    );
  }

  static List<Widget> _getChildren(OverlayOptionModel model,
      OverlayOptionModel data, IconData icon) {
    List<Widget> elements = [];

    elements.add(CircleAvatar(
      backgroundColor: ColorsGuide.ACTION_PRIMARY,
      radius: 20.0,
      //child: Icon(icon, color: ColorsGuide.BG_BLACK),
      child: Icon(FontAwesomeIcons.font, color: ColorsGuide.BG_BLACK),
    ));

    elements.add(SizedBox(height: 8));
    //elements.add(Text(data.name,textAlign: TextAlign.center));
    elements.add(Text('data.name',textAlign: TextAlign.center));
    elements.add(SizedBox(height: 8));
    elements.add(Icon(FontAwesomeIcons.font));
    elements.add(SizedBox(height: 8));

    return elements;
  }
}
