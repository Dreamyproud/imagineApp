import 'package:flutter/material.dart';
import 'package:linkedin/providers/home_provider.dart';
import 'package:linkedin/screens/home_screen.dart';
import 'package:linkedin/screens/splash_screen/splash_screen.dart';
import 'package:linkedin/screens/start_post_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeProvider>(
              create: (context) => HomeProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home: SplashScreen(),
          routes: <String, WidgetBuilder>{
            '/splashScreen': (BuildContext context) => new HomeScreen(),
            '/startPostPage': (BuildContext context) => new StartPostScreen(),
          },
        ));
  }
}
