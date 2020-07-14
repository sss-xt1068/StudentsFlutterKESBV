import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class Assgn extends StatefulWidget {
  @override
  _AssgnState createState() => _AssgnState();
}

class _AssgnState extends State<Assgn> {
  void initState() {
    super.initState();
  }

  Firestore ref = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assignments/ Resources'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // child: Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
            height: 600,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Text(
                    'List of resources',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Metropolis'),
                  ),
                ),
                Divider(
                  thickness: 5,
                  height: 20,
                  color: Colors.purple,
                  indent: 40,
                  endIndent: 40,
                ),
                Flexible(
                  flex: 10,
                  child: StreamBuilder(
                    stream: ref.collection('assgn').snapshots(),
                    builder: (context, docsnapshot) {
                      if (!docsnapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 7,
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: docsnapshot.data.documents.length,
                        itemBuilder: (context, index) => _showAssignments(
                          context,
                          docsnapshot.data.documents[index],
                        ),
                      );
                    },
                  ),
                ),
                Text('Opening the links will launch the appropriate apps')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showAssignments(BuildContext context, DocumentSnapshot doc) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(top: 6, bottom: 6),
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.amber[50], Colors.amber[200]]),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.red[200],
              blurRadius: 4,
              offset: Offset(4, 5),
            )
          ],
        ),
        child: ListTile(
          title: Text(
            doc['subject'],
            style: TextStyle(fontFamily: 'Metropolis', fontSize: 19),
          ),
          subtitle: Text(
            'Standard: ' + doc['standard'].toString() +'\nAdded on: '+doc['created'],
            style: TextStyle(fontFamily: 'Metropolis', color: Colors.black87),
          ),
          isThreeLine: true,
          leading: Icon(
            Icons.assignment,
            size: 30,
            color: Colors.deepPurple[400],
          ),
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Open assignment'),
              content: Text('Raised by teacher: ' +
                  doc['faculty'] +
                  '\nContinue to open assignment link ?'),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('No')),
                FlatButton(
                  onPressed: () async {
                    await launch(doc['link']);
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );
        print('Launching ' + doc['link']);
      },
    );
  }
}
