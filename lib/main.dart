import 'package:flutter/material.dart';
import 'package:linkedin/screens/HomeTemplate.dart';
import 'package:linkedin/screens/StartPostTemplate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeTemplate(),
      routes: <String, WidgetBuilder> {
        '/startPostPage': (BuildContext context) => new StartPostTemplate(),
      },
    );
  }
}
