import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin/screens/StartPostBody.dart';

class StartPostTemplate extends StatefulWidget {
  final dynamic body;

  StartPostTemplate({
    Key key,
    this.body,
  }) : super(key: key);

  @override
  _StartPostTemplateState createState() => _StartPostTemplateState();
}

class _StartPostTemplateState extends State<StartPostTemplate> {
  int selectedTab = 0;
  ScrollController _scrollController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          StartPostBody(),
        ],
      ),
    );
  }
}

PreferredSizeWidget getAppBar(context) {
  return AppBar(
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
        onPressed: () => {},
        elevation: 0,
        color: Colors.white,
        child: Text(
          'Post',
          style: TextStyle(color: Colors.black),
        ),
      ),
    ],
  );
}
