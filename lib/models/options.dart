import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:students_kesbv/models/assignments.dart';
import 'package:students_kesbv/models/chatforum.dart';
import 'package:students_kesbv/models/dev.dart';
import 'package:students_kesbv/models/mocklectures.dart';
import 'package:students_kesbv/models/notices.dart';

class Options extends StatefulWidget {
  final String grnumber;
  final FirebaseUser user;
  Options({
    @required this.grnumber,
    this.user,
  });
  @override
  _OptionsState createState() => _OptionsState(grnumber: grnumber);
}

class _OptionsState extends State<Options> {
  final String grnumber;
  _OptionsState({@required this.grnumber});

  List<TextStyle> styles = [
    TextStyle(
        fontFamily: 'Arsenal',
        fontWeight: FontWeight.bold,
        fontSize: 36,
        color: Colors.white),
  ];

  TextStyle aboutStyle = TextStyle(
      fontFamily: 'Metropolis',
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: Colors.black);

  void debugPrint() {
    print('Icon Pressed');
  }

  var myRadiusSet = BorderRadius.only(
      topLeft: Radius.circular(40),
      bottomRight: Radius.circular(40),
      topRight: Radius.circular(10),
      bottomLeft: Radius.circular(10));
  BoxShadow myShadow =
      BoxShadow(color: Colors.grey[600], blurRadius: 8, offset: Offset(5, 8));
  double buttonsHeight = 90;
  double buttonsWidth = double.infinity;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 20,
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
          width: buttonsWidth,
          height: buttonsHeight,
          decoration: BoxDecoration(
              borderRadius: myRadiusSet,
              gradient: LinearGradient(
                  colors: [Colors.amber[100], Colors.amber[400]]),
              boxShadow: [myShadow]),
          child: ListTile(
            leading: Image(
              height: 50,
              width: 50,
              image: new AssetImage('assets/assignment64.png'),
            ),
            title: Text('Assignments', style: aboutStyle),
            contentPadding: EdgeInsets.only(left: 30),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => Assgn(grnumber: grnumber),
                ),
              );
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 10, right: 10),
          width: buttonsWidth,
          height: buttonsHeight,
          decoration: BoxDecoration(
            borderRadius: myRadiusSet,
            gradient:
                LinearGradient(colors: [Colors.pink[100], Colors.pink[400]]),
            boxShadow: [myShadow],
          ),
          child: ListTile(
            leading: Image(
              height: 50,
              width: 50,
              image: new AssetImage('assets/notice64.png'),
            ),
            title: Text('Noticeboard', style: aboutStyle),
            contentPadding: EdgeInsets.only(left: 30),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => Notices(),
                ),
              );
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 10, right: 10),
          width: buttonsWidth,
          height: buttonsHeight,
          decoration: BoxDecoration(
            borderRadius: myRadiusSet,
            gradient: LinearGradient(
              colors: [Colors.teal[100], Colors.teal[400]],
            ),
            boxShadow: [myShadow],
          ),
          child: ListTile(
            leading: Image(
              height: 50,
              width: 50,
              image: new AssetImage('assets/lecture80.png'),
            ),
            title: Text('Live Lectures', style: aboutStyle),
            contentPadding: EdgeInsets.only(left: 30),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => Assignments(gr: grnumber),
                ),
              );
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 10, right: 10),
          width: buttonsWidth,
          height: buttonsHeight,
          decoration: BoxDecoration(
            borderRadius: myRadiusSet,
            gradient: LinearGradient(
                colors: [Colors.blueAccent[100], Colors.blueAccent[400]]),
            boxShadow: [myShadow],
          ),
          child: ListTile(
            leading: Image(
              height: 50,
              width: 50,
              image: new AssetImage('assets/about256.png'),
            ),
            title: Text('About App', style: aboutStyle),
            contentPadding: EdgeInsets.only(left: 30),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => Developer(),
                ),
              );
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 10, right: 10),
          width: buttonsWidth,
          height: buttonsHeight,
          decoration: BoxDecoration(
            borderRadius: myRadiusSet,
            gradient: LinearGradient(
              colors: [Colors.amber[100], Colors.amber[400]],
            ),
            boxShadow: [myShadow],
          ),
          child: ListTile(
            leading: Image(
              height: 50,
              width: 50,
              image: new AssetImage('assets/chat64.png'),
            ),
            title: Text('Chat Forum', style: aboutStyle),
            contentPadding: EdgeInsets.only(left: 30),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => ChatForum(),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
