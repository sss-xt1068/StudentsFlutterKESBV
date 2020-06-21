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
  });
  final BaseAuth auth;
  final Function logoutCallback;
  final String userId;
  final String userEmail;
  final String gr;

  @override
  _DashboardState createState() =>
      _DashboardState(userEmail: userEmail, grno: gr);
}

class _DashboardState extends State<Dashboard> {
  _DashboardState({@required this.userEmail, @required this.grno});
  final String userEmail;
  final String grno;

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
            title: Text('Student Dashboard'),
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
                height: 800,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.orange[200], Colors.lightBlue[300]],
                      begin: Alignment.topLeft),
                ),
                child: Column(
                  children: <Widget>[
                    // Text(userEmail),
                    Options(grnumber: grno),
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
