import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin/helpers/responsive_design/responsive_design.dart';
import 'package:linkedin/screens/body_home_screen.dart';

class HomeScreen extends StatefulWidget {
  final dynamic body;

  HomeScreen({
    Key key,
    this.body,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;
  ScrollController _scrollController;
  PageController _pageController;
  ResponsiveDesign _responsiveDesign;

  @override
  void initState() {
    super.initState();
    _pageController = new PageController();
  }

  @override
  void dispose() {
   // _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _responsiveDesign = ResponsiveDesign(context);
    return Scaffold(
      appBar: getAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: onTabChanged,
        children: <Widget>[
          BodyHomeScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTabChanged,
          currentIndex: selectedTab,
          items: getTabs()),
    );
  }

  onTabChanged(int index) {
    if (index == 2) {
      Navigator.of(context).pushNamed('/startPostPage');
    }
    setState(() {
      selectedTab = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 150),
      curve: Curves.fastOutSlowIn,
    );
  }

  PreferredSizeWidget getAppBar() {
    String imgUrl =
        "https://cdn.icon-icons.com/icons2/1154/PNG/512/1486564400-account_81513.png";
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      toolbarHeight: 40,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
            decoration: BoxDecoration(shape: BoxShape.circle),
            padding: EdgeInsets.all(3),
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage(
                'assets/images/ceo.png',
              ),
              backgroundColor: Colors.transparent,
            )),
      ),
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: _responsiveDesign.heightMultiplier(25),
          child: TextField(
            scrollPadding: EdgeInsets.only(top: 5),
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 15, color: Colors.grey),
            onTap: () {},
            enabled: false,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                filled: true,
                alignLabelWithHint: false,
                fillColor: Colors.blue[50],
                hintText: 'Search',
                contentPadding: const EdgeInsets.only(bottom: 10),
                prefixIcon: Icon(
                  FontAwesomeIcons.search,
                  color: Colors.black,
                  size: 15,
                ),
                suffixIcon: Icon(FontAwesomeIcons.qrcode,
                    color: Colors.black, size: 15)),
          ),
        ),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(
                FontAwesomeIcons.solidCommentDots,
                color: Colors.grey[700],
                size: 17,
              )),
        )
      ],
    );
  }

  List<BottomNavigationBarItem> getTabs() {
    List<BottomNavigationBarItem> list = new List<BottomNavigationBarItem>();
    list.add(BottomNavigationBarItem(
      icon: new Icon(
        Icons.home,
        size: 20,
      ),
      title: new Text('Home', style: TextStyle(fontSize: 13)),
    ));
    list.add(BottomNavigationBarItem(
      icon: new Icon(FontAwesomeIcons.userFriends, size: 20),
      title: new Text('Network', style: TextStyle(fontSize: 13)),
    ));
    list.add(BottomNavigationBarItem(
        icon: Icon(
          FontAwesomeIcons.edit,
          size: 20,
        ),
        title: Text('Post', style: TextStyle(fontSize: 13))));
    list.add(BottomNavigationBarItem(
      icon: new Stack(
        children: <Widget>[
          new Icon(FontAwesomeIcons.bell, size: 20),
          new Positioned(
            right: 0,
            child: new Container(
              padding: EdgeInsets.all(1),
              decoration: new BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: new Text(
                '1',
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
      title: new Text('Notifications', style: TextStyle(fontSize: 13)),
    ));

    list.add(BottomNavigationBarItem(
      icon: new Icon(FontAwesomeIcons.briefcase, size: 20),
      title: new Text('Jobs', style: TextStyle(fontSize: 13)),
    ));
    return list;
  }
}
