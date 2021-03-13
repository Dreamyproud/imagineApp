import 'package:flutter/material.dart';
import 'package:linkedin/screens/home_template.dart';
import 'package:linkedin/screens/splash_screen/splash_screen.dart';

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
      routes: <String, WidgetBuilder>{
        '/startPostPage': (BuildContext context) => new SplashScreen(),
      },
    );
  }
}
