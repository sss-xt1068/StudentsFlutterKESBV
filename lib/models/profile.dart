import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatelessWidget {
  Profile({
    this.userdata,
    this.keys,
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
                color: Colors.orange[200],
              ),
              padding: EdgeInsets.fromLTRB(0, 5, 30, 10),
              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: ListTile(
                title: Text(
                  userdata['fname'],
                  style: TextStyle(fontSize: 17),
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
                color: Colors.orange[200],
              ),
              padding: EdgeInsets.fromLTRB(0, 5, 30, 10),
              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: ListTile(
                title: Text(
                  userdata['lname'],
                  style: TextStyle(fontSize: 17),
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
                color: Colors.orange[200],
              ),
              padding: EdgeInsets.fromLTRB(0, 5, 30, 10),
              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: ListTile(
                title: Text(
                  userdata['email'],
                  style: TextStyle(fontSize: 17),
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
                color: Colors.orange[200],
              ),
              padding: EdgeInsets.fromLTRB(0, 5, 30, 10),
              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: ListTile(
                title: Text(
                  userdata['grnumber'].toString(),
                  style: TextStyle(fontSize: 17),
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
                color: Colors.orange[200],
              ),
              padding: EdgeInsets.fromLTRB(0, 5, 30, 10),
              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: ListTile(
                title: Text(
                  userdata['verified'] == true ? 'Yes' : 'No',
                  style: TextStyle(fontSize: 17),
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
                color: Colors.orange[200],
              ),
              padding: EdgeInsets.fromLTRB(0, 5, 30, 10),
              margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: ListTile(
                title: Text(
                  userdata['userid'],
                  style: TextStyle(fontSize: 17),
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

  // Widget showProfile(BuildContext context, int index) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.only(
  //         bottomLeft: Radius.circular(30),
  //         topLeft: Radius.circular(30),
  //       ),
  //       color: Colors.orange[200],
  //     ),
  //     padding: EdgeInsets.fromLTRB(0, 5, 30, 10),
  //     margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
  //     child: ListTile(
  //       title: Text(
  //         keys[index],
  //       ),
  //       subtitle: Text(
  //         userdata[keys[index].toString()].toString(),style:TextStyle(fontSize:17),
  //       ),
  //     ),
  //   );
  // }
}
