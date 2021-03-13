import 'dart:async';
import 'package:flutter/material.dart';
import 'package:linkedin/screens/start_post_template.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.blue;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 5;

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => StartPostTemplate()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: InkWell(
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'images/logo.png',
                          height: 300,
                          width: 300,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                        ),
                      ],
                    )),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Container(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Spacer(
                                flex: 4,
                              ),
                              Text('androing'),
                              Spacer(),
                            ])
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
