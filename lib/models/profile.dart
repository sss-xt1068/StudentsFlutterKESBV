import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({
    this.userdata,
    this.keys,
  });
  final Map<String, dynamic> userdata;
  final List keys;

  @override
  _ProfileState createState() => _ProfileState(
        userdata: userdata,
        keys: keys,
      );
}

class _ProfileState extends State<Profile> {
  _ProfileState({
    @required this.userdata,
    @required this.keys,
  });
  final Map<String, dynamic> userdata;
  final List keys;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Profile',
          style: TextStyle(
            fontFamily: 'Metropolis',
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  colors: [Colors.cyan[200], Colors.teal[200]],
                ),
              ),
              padding: EdgeInsets.fromLTRB(0, 5, 30, 10),
              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: ListTile(
                title: Text(
                  userdata['fname'],
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaleFactor * 17,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text('First name'),
                leading: Icon(
                  Icons.person,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                gradient: LinearGradient(
                    colors: [Colors.cyan[200], Colors.teal[200]]),
              ),
              padding: EdgeInsets.fromLTRB(0, 5, 30, 10),
              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: ListTile(
                title: Text(
                  userdata['lname'],
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaleFactor * 17,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text('Last name'),
                leading: Icon(
                  Icons.person,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                gradient: LinearGradient(
                    colors: [Colors.cyan[200], Colors.teal[200]]),
              ),
              padding: EdgeInsets.fromLTRB(0, 5, 30, 10),
              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: ListTile(
                title: Text(
                  userdata['email'],
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaleFactor * 17,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text('Email'),
                leading: Icon(
                  Icons.alternate_email,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                gradient: LinearGradient(
                    colors: [Colors.cyan[200], Colors.teal[200]]),
              ),
              padding: EdgeInsets.fromLTRB(0, 5, 30, 10),
              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: ListTile(
                title: Text(
                  userdata['grnumber'].toString(),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaleFactor * 17,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text('GR Number'),
                leading: Icon(
                  Icons.looks_one,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                gradient: LinearGradient(
                    colors: [Colors.cyan[200], Colors.teal[200]]),
              ),
              padding: EdgeInsets.fromLTRB(0, 5, 30, 10),
              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: ListTile(
                title: Text(
                  userdata['verified'] == true ? 'Yes' : 'No',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaleFactor * 17,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text('Verified Profile?'),
                leading: Icon(
                  Icons.verified_user,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                gradient: LinearGradient(
                    colors: [Colors.cyan[200], Colors.teal[200]]),
              ),
              padding: EdgeInsets.fromLTRB(0, 5, 30, 10),
              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: ListTile(
                title: Text(
                  userdata['userid'],
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).textScaleFactor * 17,
                      fontWeight: FontWeight.w600),
                ),
                subtitle: Text('User ID (database purposes)'),
                leading: Icon(
                  Icons.lock_outline,
                ),
                enabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
