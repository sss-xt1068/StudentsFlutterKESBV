import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Lectures extends StatefulWidget {
  Lectures({
    this.std,
  });
  final int std;
  @override
  _LecturesState createState() => _LecturesState(std: std);
}

int studentStandard;

class _LecturesState extends State<Lectures> {
  _LecturesState({
    this.std,
  });
  final int std;
  @override
  void initState() {
    print(std.toString());
    super.initState();
    // findMyStandard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        title: Text('Scheduled live lectures'),
        backgroundColor: Colors.orange[800],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: StreamBuilder(
            stream: Firestore.instance.collection('lectures').snapshots(),
            builder: (context, snap) {
              if (!snap.hasData) {
                return Center(
                  child: Text('Loading schedules...'),
                );
              }
              return ListView.builder(
                itemBuilder: (context, index) => showSchedule(
                  context,
                  snap.data.documents[index],
                  std,
                ),
                itemCount: snap.data.documents.length,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget showSchedule(BuildContext context, DocumentSnapshot doc, int std) {
    if (std.toString() == doc['standard'].toString()) {
      return Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.orange[100],
                Colors.orange[300],
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[600],
                blurRadius: 4,
                offset: Offset(3, 5),
              ),
            ]),
        child: ListTile(
          title: Text(
            doc['subject'],
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Metropolis',
            ),
          ),
          subtitle: Text(
            'Day: ' +
                doc['day'].toString() +
                '\n' +
                'Teacher: ' +
                doc['faculty'] +
                ', Standard:' +
                doc['standard'].toString(),
          ),
          isThreeLine: true,
          leading: Icon(
            Icons.class_,
            size: 30,
            color: Colors.deepPurpleAccent,
          ),
          onTap: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              child: AlertDialog(
                title: Text('Join lecture now?'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Subject: ' + doc['subject']),
                    Text('Teacher: ' + doc['faculty'])
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No'),
                  ),
                  FlatButton(
                    onPressed: () async {
                      await launch(doc['link']);
                      Navigator.of(context).pop();
                    },
                    child: Text('Yes'),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      print('object');
      return Container(
        height: 0.0,
        width: 0.0,
      );
    }
  }
}
