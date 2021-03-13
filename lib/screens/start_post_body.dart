import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin/helpers/responsive_design/responsive_design.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StartPostBody extends StatefulWidget {
  @override
  _StartPostBodyState createState() => _StartPostBodyState();
}

class _StartPostBodyState extends State<StartPostBody> {
  String imgUrl =
      "https://png.pngtree.com/png-clipart/20190516/original/pngtree-users-vector-icon-png-image_3725294.jpg";
  ResponsiveDesign _responsiveDesign;
  Color _colorIcons = Colors.grey[600];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _responsiveDesign = ResponsiveDesign(context);
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _headerStartPost(),
          _startPost(context),
        ],
      ),
    );
  }

  Widget _startPost(BuildContext context) => Container(
      width: MediaQuery.of(context).size.width,
      child: _createStartPost(context));

  _createStartPost(context) => Column(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              color: Colors.white,
              constraints:
                  BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
              child: Theme(
                data:
                    Theme.of(context).copyWith(splashColor: Colors.transparent),
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  autofocus: false,
                  textAlign: TextAlign.justify,
                  textInputAction: TextInputAction.newline,
                  scrollPhysics: NeverScrollableScrollPhysics(),
                  style: TextStyle(fontSize: 18.0, color: Color(0xFFbdc6cf)),
                  decoration: InputDecoration(
                    filled: true,
                    hintMaxLines: 3,
                    fillColor: Colors.white,
                    hintText: 'What do yo want to talk about?',
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
              )),
          _showOverlay(context)
        ],
      );

  Widget _showOverlay(context) => Material(
          child: Stack(alignment: Alignment.topCenter, children: <Widget>[
        SlidingUpPanel(
            borderRadius: BorderRadius.circular(20),
            minHeight: MediaQuery.of(context).size.height - 0.20,
            isDraggable: true,
            backdropTapClosesPanel: true,
            padding: EdgeInsets.all(_responsiveDesign.heightMultiplier(16.0)),
            //minHeight: MediaQuery.of(context).size.height - 0.20,
            panel: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Icon(FontAwesomeIcons.gripLines, color: _colorIcons),
                    _getIconsOverlay(FontAwesomeIcons.image, "Add a photo"),
                    _getIconsOverlay(FontAwesomeIcons.video, "Take a video"),
                    _getIconsOverlay(
                        FontAwesomeIcons.award, "Celebrate an occasion"),
                    _getIconsOverlay(
                        FontAwesomeIcons.fileAlt, "Add a document"),
                    _getIconsOverlay(
                        FontAwesomeIcons.briefcase, "Share that you're hiring"),
                    _getIconsOverlay(
                        FontAwesomeIcons.idBadge, "Find an expert"),
                    _getIconsOverlay(FontAwesomeIcons.images, "Share a story"),
                    _getIconsOverlay(
                        FontAwesomeIcons.chartBar, "Create a poly"),
                  ],
                )))
      ]));

  Widget _getIconsOverlay(IconData icon, String texto) => Column(
        children: [
          Row(
            children: [
              Icon(icon, color: _colorIcons),
              SizedBox(width: _responsiveDesign.heightMultiplier(20.0)),
              Text(texto),
            ],
          ),
          SizedBox(height: _responsiveDesign.heightMultiplier(20.0))
        ],
      );

  Widget _headerStartPost() => Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 5),
      margin: EdgeInsets.only(top: 6.0, left: 5.0),
      height: 60.0,
      child: _createHeader());

  Widget _createHeader() => Row(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image(
                            image: NetworkImage(imgUrl),
                            height: 55.0,
                            width: 55.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  OutlineButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(FontAwesomeIcons.solidUser,
                              color: Colors.grey, size: 10.0),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Nicolas Rojas Nino"),
                        ],
                      ),
                      onPressed: null,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                  SizedBox(
                    width: 8.0,
                  ),
                  OutlineButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(FontAwesomeIcons.globeAmericas,
                              color: Colors.grey, size: 10.0),
                          SizedBox(width: 5),
                          Text("Anyone"),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Icon(FontAwesomeIcons.sortDown,
                                color: Colors.grey, size: 15),
                          ),
                        ],
                      ),
                      onPressed: null,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                ],
              ))
        ],
      );
}
