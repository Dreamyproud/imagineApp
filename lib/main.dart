import 'package:flutter/material.dart';
import 'package:linkedin/presenter/home_presenter.dart';
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
      home: HomePresenter(),
      routes: <String, WidgetBuilder>{
        '/startPostPage': (BuildContext context) => new SplashScreen(),
      },
    );
  }
}
