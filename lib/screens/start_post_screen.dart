import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin/helpers/responsive_design/responsive_design.dart';
import 'package:linkedin/repository/repository.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StartPostScreen extends StatefulWidget {
  @override
  _StartPostScreenState createState() => _StartPostScreenState();
}

class _StartPostScreenState extends State<StartPostScreen> {
  String imgUrl =
      "https://png.pngtree.com/png-clipart/20190516/original/pngtree-users-vector-icon-png-image_3725294.jpg";
  ResponsiveDesign _responsiveDesign;
  Color _colorIcons = Colors.grey[600];
  TextEditingController controller;
  final Repository httpService = Repository();
  PageController _pageController;
  String data;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    _responsiveDesign = ResponsiveDesign(context);

    return Scaffold(
        appBar: getAppBar(context),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _headerStartPost(),
                  _createStartPost(context),
                ],
              ),
            )
          ],
        ));
  }

  PreferredSizeWidget getAppBar(context) => AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              FontAwesomeIcons.times,
              color: Colors.grey,
              size: 20,
            )),
        title: Text("Start Post", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: <Widget>[
          RaisedButton(
            onPressed: () {
              createPostAction(data);
            },
            elevation: 0,
            color: Colors.white,
            child: Text(
              'Post',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      );

  _createStartPost(context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.30,
                color: Colors.white,
                constraints:
                    BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(splashColor: Colors.transparent),
                  child: TextField(
                    controller: controller,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    autofocus: false,
                    textAlign: TextAlign.justify,
                    textInputAction: TextInputAction.newline,
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    onChanged: (value) {
                      data = value;
                    },
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
        ));
  }

  void createPostAction(String summary) {
    httpService.createPosts(summary);
    Fluttertoast.showToast(
        msg: "¡Tu publicación ha sido creada!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
    Navigator.of(context).pop();
  }

  Widget _showOverlay(context) => Material(
          child: Stack(alignment: Alignment.topCenter, children: <Widget>[
        SlidingUpPanel(
            borderRadius: BorderRadius.circular(20),
            minHeight: MediaQuery.of(context).size.height * 0.50,
            slideDirection: SlideDirection.DOWN,
            collapsed: SingleChildScrollView(
             scrollDirection: Axis.vertical,
             child: Column(
               children: [
                 SizedBox(height: 10,),
                 Icon(FontAwesomeIcons.gripLines, color: _colorIcons),
                 SizedBox(height: 20,),
                 _getIconsOverlay(FontAwesomeIcons.image, "Add a photo"),
                 _getIconsOverlay(FontAwesomeIcons.video, "Take a video"),
                 _getIconsOverlay(
                     FontAwesomeIcons.award, "Celebrate an occasion"),
                 _getIconsOverlay(
                     FontAwesomeIcons.fileAlt, "Add a document"),
                 _getIconsOverlay(FontAwesomeIcons.briefcase,
                     "Share that you're hiring"),
                 _getIconsOverlay(
                     FontAwesomeIcons.idBadge, "Find an expert"),
                 _getIconsOverlay(
                     FontAwesomeIcons.images, "Share a story"),
                 _getIconsOverlay(
                     FontAwesomeIcons.chartBar, "Create a poly"),
               ],
             ),
           ),
            padding: EdgeInsets.symmetric(horizontal: _responsiveDesign.widthMultiplier(16.0),
            vertical: _responsiveDesign.heightMultiplier(2.0)),
            panel: Text(''))
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
                          child: Image.asset(
                            'assets/images/ceo.png',
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
