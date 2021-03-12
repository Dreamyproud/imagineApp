import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkedin/screens/BodyTemplate.dart';

class HomeTemplate extends StatefulWidget {
  final dynamic body;

  HomeTemplate({
    Key key,
    this.body,
  }) : super(key: key);

  @override
  _HomeTemplateState createState() => _HomeTemplateState();
}

class _HomeTemplateState extends State<HomeTemplate> {
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
      appBar: getAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: onTabChanged,
        children: <Widget>[
          BodyTemplate(),
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
    if (index == 2){
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
}

PreferredSizeWidget getAppBar() {
  String imgUrl =
      "https://media-exp1.licdn.com/dms/image/C4D35AQFGSNotlnM8mA/profile-framedphoto-shrink_200_200/0/1614185454794?e=1615525200&v=beta&t=sn7BZsg5KrYg3hvIoTLPOmRYxWHZZ10a5zK-3E2JLsA";
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
            backgroundImage: NetworkImage(imgUrl),
            backgroundColor: Colors.transparent,
          )),
    ),
    title: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 30,
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
              suffixIcon:
                  Icon(FontAwesomeIcons.qrcode, color: Colors.black, size: 15)),
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
    icon: new Icon(FontAwesomeIcons.bell, size: 20),
    title: new Text('Notifications', style: TextStyle(fontSize: 13)),
  ));
  list.add(BottomNavigationBarItem(
    icon: new Icon(FontAwesomeIcons.briefcase, size: 20),
    title: new Text('Jobs', style: TextStyle(fontSize: 13)),
  ));
  return list;
}
