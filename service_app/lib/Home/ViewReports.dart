
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:service_app/localdb/Reportdb.dart';
import 'package:service_app/localdb/model/reportmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Roprtsgrid.dart';
class ViewReport extends StatefulWidget {
  @override
  _ViewReportState createState() => _ViewReportState();
}

class _ViewReportState extends State<ViewReport> {
   late List<Reports> reports;
   CollectionReference users = Firestore.instance.collection('users');



  bool isLoading = false;
  @override
  void initState() {

    super.initState();

    refreshNotes();
  }



  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.reports = await ReportsDb.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reports',
          style: TextStyle(fontSize: 24),
        ),
     /*   actions: [  IconButton(
      icon: Icon(Icons.backup_outlined,
        color: Colors.white,),
        onPressed: () async {

         /* Future<void> addUser() {
            final report = reports[];
            return users
                .add({
              'Name': report.name, // John Doe
              'Address': report.address, // Stokes and Sons
              'Incident': report.incident ,
              'Description':report.description,
              'DateTime':Timestamp.now()// 42
            })
                .then((value) => print("User Added"))
                .catchError((error) => print("Failed to add user: $error"));
          }*/

        }),SizedBox(width: 12)],*/
      ),
      body: Center(
        child: buildReports(),
      ),
    );

  }
  Widget buildReports() => StaggeredGridView.countBuilder(
    padding: EdgeInsets.all(8),
    itemCount: reports.length,
    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final report = reports[index];


      return GestureDetector(
        onTap: () async {
         // await Navigator.of(context).push(MaterialPageRoute(
         //   builder: (context) => NoteDetailPage(noteId: note.id!),
        //  )
          //)

          refreshNotes();
        },
        child: Reportcards(reports:report,index: index),
      );
    },
  );


}

void addUser(context , index) {

}


