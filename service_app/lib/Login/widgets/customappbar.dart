import 'package:flutter/material.dart';
import 'package:service_app/Login/utils/constant.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        height: height/10,
        width: width,
        padding: EdgeInsets.only(left: 15, top: 25),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors:[kPrimaryColor, Colors.indigoAccent]
          ),
        ),
        child: Row(
          children: <Widget>[



          ],
        ),
      ),
    );
  }
}
