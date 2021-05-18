import 'dart:async';

import 'package:flutter/material.dart';

import 'Register/Register.dart';
import 'Login/login_screen.dart';
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => {_loadScreen()});
  }

  _loadScreen() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginScreen(),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/logo.png',
                        width: 200.0,
                        height: 200.0,color: Colors.indigo,
                        fit: BoxFit.fill,
                      ),
                    ],

                  ),

                  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Service Demo',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]
                  )
                ],
              ),
            ),
            Container(
              width: 150,
              height: 2,
              child: LinearProgressIndicator(
                backgroundColor: Colors.blue,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
