import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Assgn extends StatefulWidget {
  final String grnumber;

  Assgn({@required this.grnumber});

  @override
  _AssgnState createState() => _AssgnState(grnumber: grnumber);
}

class _AssgnState extends State<Assgn> {
  String grnumber;
  _AssgnState({@required this.grnumber});

  void initState() {
    super.initState();
    findMyStandard();
  }

  int studentStandard;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Due Assignments'),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 700,
                  padding: EdgeInsets.all(20),
                  color: Colors.orange[50],
                  child: Column(
                    children: [
                      Text(
                        'List of assignments',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(
                        thickness: 5,
                        height: 20,
                        color: Colors.red[300],
                      ),
                      Container(
                        height: 400,
                        width: double.infinity,
                        child: StreamBuilder(
                          stream: Firestore.instance
                              .collection('assgn')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView.builder(
                              itemExtent: 100,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) => _showLectures(
                                context,
                                snapshot.data.documents[index],
                                // studentStandard,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text('Tap assignment to open document'),
                      )
                    ],
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _showLectures(
    BuildContext context,
    DocumentSnapshot doc,
    // int studentStandard,
  ) {
    return GestureDetector(
      // child: studentStandard == doc['standard']
      // ?
      child: Container(
        // alignment: Alignment.center,
        padding: EdgeInsets.only(top: 6, bottom: 6),
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.amber[200],
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.orangeAccent,
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: Offset(2, 3))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5),
            Text(
              doc['subject'],
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Faculty: ' +
                  doc['faculty'] +
                  '\t\t\t\tStandard: ' +
                  doc['standard'].toString(),
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      // : SizedBox(height: 1),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Open'),
              content: Text('Continue to open assignment link?'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No')),
                FlatButton(
                    onPressed: () async {
                      // _launchURL(doc['link']);
                      await launch(doc['link']);
                      Navigator.of(context).pop();
                    },
                    child: Text('Yes'))
              ],
            );
          },
        );
        print('Launching ' + doc['link']);
      },
    );
  }

  int findMyStandard() {
    int temp;
    Firestore.instance
        .collection('students')
        .document(grnumber)
        .get()
        .then((DocumentSnapshot ds) {
      print('Returning standard as int..');
      int std = ds.data['std'];
      print(std.toString());
      studentStandard = std;
      temp = std;
      return std;
    });
    return temp;
    // probably useless but who cares as long as same shit is returned
  }
}
