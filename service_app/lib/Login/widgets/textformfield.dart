import 'package:flutter/material.dart';
import 'package:service_app/Login/utils/constant.dart';

import 'responsive_ui.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
 late double _width;
  late double _pixelRatio;
  late bool large;
  late bool medium;



  CustomTextField(
    {required this.hint,
      required this.textEditingController,
      required this.keyboardType,
      required this.icon,

      this.obscureText= false,
     });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium=  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large? 12 : (medium? 10 : 8),
      child: TextFormField(

        controller: textEditingController,
        keyboardType: keyboardType,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color:kPrimaryColor, size: 20),
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
class Descriptiontextfield extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  late double _width;
  late double _pixelRatio;
  late bool large;
  late bool medium;


  Descriptiontextfield(
      {required this.hint,
        required this.textEditingController,
        required this.keyboardType,
        required this.icon,

        this.obscureText= false,
      });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium=  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(

      borderRadius: BorderRadius.circular(30.0),
      elevation: large? 12 : (medium? 10 : 8),
      child: Container(
        height: 350,
        child:
      TextFormField(
        controller: textEditingController,
        keyboardType: TextInputType.multiline,
        maxLines: 500,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color:kPrimaryColor, size: 20),
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),)
    );
  }
}
