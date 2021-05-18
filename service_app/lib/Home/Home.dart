// @dart=2.9
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service_app/Home/ViewReports.dart';
import 'package:service_app/Login/utils/constant.dart';
import 'package:service_app/Login/widgets/custom_shape.dart';
import 'package:service_app/Login/widgets/customappbar.dart';
import 'package:service_app/Login/widgets/responsive_ui.dart';
import 'package:service_app/Login/widgets/textformfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_app/localdb/Reportdb.dart';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:service_app/localdb/model/reportmodel.dart';


class Home extends StatefulWidget {
final Reports reports;
final int index;

  const Home({Key key, this.reports,this.index}) : super(key: key);



  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Reports> reports;
  bool isLoading = false;
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  File incidentimg;

  Firestore firestore = Firestore.instance;


  final picker = ImagePicker();
  TextEditingController namecon = new TextEditingController();
  TextEditingController addresscon = new TextEditingController();
  TextEditingController incidentcon = new TextEditingController();
  TextEditingController desccon = new TextEditingController();





  @override
  void initState() {


  }
  // bool? get newValue => null;


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        incidentimg = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }


  @override
  Widget build(BuildContext context) {



    _height = MediaQuery
        .of(context)
        .size
        .height;
    _width = MediaQuery
        .of(context)
        .size
        .width;
    _pixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                clipShape(),
                form(),
                acceptTermsTextRow(),

                button(),
                button2(),
                // infoTextRow(),
                // socialIconsRow(),
                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(

              height: _large ? _height / 8 : (_medium ? _height / 7 : _height /
                  6.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimaryColor, Colors.indigoAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large ? _height / 12 : (_medium
                  ? _height / 11
                  : _height / 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimaryColor, Colors.indigoAccent],
                ),
              ),
            ),
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 45, right: 30, left: 30),
          height: _height / 5.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0.0,
                    color: Colors.black26,
                    offset: Offset(1.0, 10.0),
                    blurRadius: 20.0),
              ],
              color: Colors.white,
              shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(20)
          ),
          child: GestureDetector(
              onTap: () {
                getImage();
                print('Adding photo');
              },

              child: incidentimg == null ? Icon(
                  Icons.add_a_photo, size: _large ? 40 : (_medium ? 33 : 31),
                  color: kPrimaryColor) : Image.file(
                incidentimg, fit: BoxFit.cover,)),
        ),
//        Positioned(
//          top: _height/8,
//          left: _width/1.75,
//          child: Container(
//            alignment: Alignment.center,
//            height: _height/23,
//            padding: EdgeInsets.all(5),
//            decoration: BoxDecoration(
//              shape: BoxShape.circle,
//              color:  Colors.orange[100],
//            ),
//            child: GestureDetector(
//                onTap: (){
//                  print('Adding photo');
//                },
//                child: Icon(Icons.add_a_photo, size: _large? 22: (_medium? 15: 13),)),
//          ),
//        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0,
          right: _width / 12.0,
          top: _height / 20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            firstNameTextFormField(

            ),
            SizedBox(height: _height / 60.0),
            lastNameTextFormField(),
            SizedBox(height: _height / 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
            //passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Enter Name",
      textEditingController: namecon,

    );
  }

  Widget lastNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.new_releases_sharp,
      hint: "Incident", textEditingController: incidentcon,
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      icon: Icons.gps_fixed,
      hint: "Location",
      textEditingController: addresscon,
    );
  }

  Widget phoneTextFormField() {
    return Descriptiontextfield(
      // keyboardType: TextInputType.number,
      icon: Icons.comment,
      hint: "Description",
      keyboardType: TextInputType.text,
      textEditingController: desccon,

    );
  }


  Widget acceptTermsTextRow() {
    return Container(

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: kPrimaryColor,
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I Declare True Report",
            style: TextStyle(color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: _large ? 16 : (_medium ? 12 : 11)),
          ),
        ],
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {


        if (namecon.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Enter Name")));
        } else if (incidentcon.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Enter Incident")));
        } else if (addresscon.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Enter Address")));
        } else if (desccon.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Enter Description")));
        } else { AddReport();
        Fluttertoast.showToast(
            msg: "Report Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1
        );

        }
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: kPrimaryColor
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('Save',
          style: TextStyle(fontSize: _large ? 18 : (_medium ? 14 : 12)),),
      ),
    );
  }
  Widget button2() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: ()  {

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewReport()));

//
        },

      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            color: kPrimaryColor
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('View',
          style: TextStyle(fontSize: _large ? 18 : (_medium ? 14 : 12)),),
      ),
    );
  }

  void AddReport() async {
    final isUpdating = widget.reports != null;

    if (isUpdating) {
      await updateNote();
    } else {
      await addNote();
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ViewReport()));

  }

  Future updateNote() async {
    final reports = widget.reports.copy(
      name: namecon.text,
      address: addresscon.text,
      incident: incidentcon.text,
      description: desccon.text,
    );

    await ReportsDb.instance.update(reports);
  }

  Future addNote() async {
    final reports = Reports(
      name: namecon.text,
      address: addresscon.text,
      incident: incidentcon.text,
      description: desccon.text,
      createdTime: DateTime.now(),
    );

    await ReportsDb.instance.create(reports);
  }



}
