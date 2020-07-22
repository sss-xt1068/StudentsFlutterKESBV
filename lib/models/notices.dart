import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';

class Notices extends StatefulWidget {
  @override
  _NoticesState createState() => _NoticesState();
}

class _NoticesState extends State<Notices> {
  Firestore ref = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('School Noticeboard'),
        backgroundColor: Colors.cyan[800],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            child: Container(
              height: 600,
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: StreamBuilder(
                      stream: ref.collection('notices').snapshots(),
                      builder: (context, snap) {
                        if (!snap.hasData) {
                          return Center(
                            child: Text(
                              'There are no notices to display.\nPlease check back later',
                              style: TextStyle(
                                fontFamily: 'Metropolis',
                                fontSize: 16,
                              ),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: snap.data.documents.length,
                          itemBuilder: (context, index) => showNotices(
                            context,
                            snap.data.documents[index],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showNotices(BuildContext context, DocumentSnapshot doc) {
    return Column(
      children: [
        doc['active'] == true
            ? Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(5),
                // color: Colors.amber[100],
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.cyan[200], Colors.cyan[200]],
                    begin: Alignment.centerLeft,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple,
                      blurRadius: 4,
                      // spreadRadius: 2,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    doc['title'],
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    doc['start'].toString().length != 5
                        ? doc['content']
                        : doc['content'] +
                            '\n' +
                            'New school times: ' +
                            doc['start'] +
                            ':' +
                            doc['end'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  leading: Icon(
                    Icons.add_alert,
                    size: 30,
                    color: Colors.deepPurpleAccent,
                  ),
                  isThreeLine: true,
                  onTap: () async {
                    if (doc['link'] != '') {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        child: AlertDialog(
                          title: Text('Open notice link?'),
                          content:
                              Text('Press Yes to continue and open in browser'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('No'),
                            ),
                            FlatButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                print('Found link to assignment*******' +
                                    doc['link']);
                                await launch(doc['link']);
                              },
                              child: Text('Yes'),
                            )
                          ],
                        ),
                      );
                    } else {}
                  },
                ),
              )
            : Container(height: 0.0),
        doc['active'] == true ? SizedBox(height: 20) : SizedBox(height: 0.0),
      ],
    );
  }

  void launchUrl(String link) async {
    try {
      await launch(link);
    } catch (e) {
      print('Could not launch link');
      print(e);
    }
  }
}
