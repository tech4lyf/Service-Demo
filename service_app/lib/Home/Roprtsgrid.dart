import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:service_app/localdb/Reportdb.dart';
import 'package:service_app/localdb/model/reportmodel.dart';

final _lightColors = [
  Colors.amber.shade300,
  Colors.lightGreen.shade300,
  Colors.lightBlue.shade300,
  Colors.orange.shade300,
  Colors.pinkAccent.shade100,
  Colors.tealAccent.shade100
];

class Reportcards extends StatelessWidget {


  Reportcards({
    Key? key,
    required this.reports,
    required this.index,
  }) : super(key: key);

  final Reports reports;
  final int index;
  CollectionReference users = Firestore.instance.collection('Reports');
  Future<void> addUser() {
    ReportsDb.instance.readReport(reports.id!);

    return users
        .add({
      'Name': reports.name, // John Doe
      'Address': reports.address, // Stokes and Sons
      'Incident': reports.incident ,
      'Description':reports.description,
      'DateTime':Timestamp.now()// 42
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  @override
  Widget build(BuildContext context) {

    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat.yMMMd().format(reports.createdTime);
    final minHeight = getMinHeight(index);
    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(
                   time,
                   style: TextStyle(color: Colors.grey.shade700),
                 ),
               IconButton(icon: Icon(Icons.delete), onPressed: () async{
                 Fluttertoast.showToast(
                     msg: "Report Deleted in Localdb",
                     toastLength: Toast.LENGTH_SHORT,
                     gravity: ToastGravity.BOTTOM,
                     timeInSecForIosWeb: 1
                 );
                 Navigator.of(context).pop();
                  await ReportsDb.instance.delete(reports.id!); },),
                 IconButton(icon: Icon(Icons.backup), onPressed: (){
                   Fluttertoast.showToast(
                       msg: "Report Uploaded to Server",
                       toastLength: Toast.LENGTH_SHORT,
                       gravity: ToastGravity.BOTTOM,
                       timeInSecForIosWeb: 1,

                   );
                 addUser();
                   },)
               ]
           ) ,
            SizedBox(height: 4),
            RichText(
              text: TextSpan(
                  text: 'Name   ',
                  style: TextStyle(color: Colors.grey[850], fontSize: 18,fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(text: reports.name, style: TextStyle(color: Colors.indigo, fontSize: 20,fontWeight: FontWeight.w700),

                    )
                  ]),),
            SizedBox(height: 4),
            RichText(
              text: TextSpan(
                  text: 'Incident:   ',
                  style: TextStyle(color: Colors.grey[850], fontSize: 18,fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(text: reports.incident, style: TextStyle(color: Colors.indigo, fontSize: 20,fontWeight: FontWeight.w700),

                    )
                  ]),), SizedBox(height: 4),
            RichText(
              text: TextSpan(
                  text: 'Address:   ',
                  style: TextStyle(color: Colors.grey[850], fontSize: 18,fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(text: reports.address, style: TextStyle(color: Colors.indigo, fontSize: 20,fontWeight: FontWeight.w700),

                    )
                  ]),), SizedBox(height: 4),
            RichText(overflow: TextOverflow.ellipsis,
              text: TextSpan(
                  text: 'Description:',
                  style: TextStyle(color: Colors.grey[850], fontSize: 18,fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(text: reports.description, style: TextStyle(color: Colors.indigo, fontSize: 20,fontWeight: FontWeight.w700),

                    )
                  ]),), SizedBox(height: 4),

          ],
        ),
      ),
    );

  }


 double getMinHeight(int index) {
   switch (index % 4) {
     case 0:
       return 100;
     case 1:
       return 150;
     case 2:
       return 150;
     case 3:
       return 100;
     default:
       return 100;
   }
 }
}
