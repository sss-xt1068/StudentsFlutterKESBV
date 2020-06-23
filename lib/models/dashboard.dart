import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './options.dart';
import '../services/authentication.dart';

class Dashboard extends StatefulWidget {
  Dashboard({
    Key key,
    this.auth,
    this.userId,
    this.logoutCallback,
    this.userEmail,
    this.gr,
    this.user,
  });
  final BaseAuth auth;
  final Function logoutCallback;
  final String userId;
  final String userEmail;
  final String gr;
  final FirebaseUser user;

  @override
  _DashboardState createState() =>
      _DashboardState(userEmail: userEmail, grno: gr, user: user);
}

class _DashboardState extends State<Dashboard> {
  _DashboardState({
    @required this.userEmail,
    @required this.grno,
    this.user,
  });
  final String userEmail;
  final String grno;
  final FirebaseUser user;

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text(
              'Student Dashboard',
              style: TextStyle(fontFamily: 'Metropolis'),
            ),
            expandedHeight: 100,
            actions: <Widget>[
              Transform.rotate(
                angle: 3.1415,
                child: new IconButton(
                    icon: Icon(
                      Icons.exit_to_app,
                      size: 30,
                    ),
                    tooltip: 'Logout',
                    onPressed: signOut),
              )
            ],
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                height: 700,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.orange[200], Colors.lightBlue[300]],
                      begin: Alignment.topLeft),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 25),
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        fontFamily: 'Metropolis',
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(
                      height: 20,
                      thickness: 8,
                      color: Colors.blue[700],
                      indent: 40,
                      endIndent: 40,
                    ),
                    Text(
                      'Your email ID is: ' + userEmail,
                      style: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 14,
                      ),
                    ),
                    Options(grnumber: grno, user: user),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
      //   ),
      // ),
    );
  }
}
