import 'package:flutter/material.dart';
import 'package:App_Students/pages/login_signup_page.dart';
import 'package:App_Students/services/authentication.dart';
import 'package:App_Students/models/dashboard.dart';
import 'dart:core';

enum AuthStatus {
  NOT_DETERMINED, //when there is an error
  NOT_LOGGED_IN, //when the user is signed out
  LOGGED_IN, //when the user is logged in
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";
  String _userEmail = '';

  @override
  void initState() {
    super.initState();

    widget.auth.getCurrentUser().then((user) async {
      if (user != null) {
        setState(() {
          _userId = user?.uid;
          _userEmail = user?.email;

          authStatus = user?.uid == null
              ? AuthStatus.NOT_LOGGED_IN
              : AuthStatus.LOGGED_IN;
          print('Got at init! ' + authStatus.toString());
        });
      } else {
        setState(() {
          authStatus = AuthStatus.NOT_LOGGED_IN;
        });
      }
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
        _userEmail = user.email;
      });
    });
    setState(() {
      authStatus = AuthStatus.LOGGED_IN;
      print('Login callback mara =>' + authStatus.toString());
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
      print('Log OUT callback mara =>' + authStatus.toString());
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          strokeWidth: 6,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        print('I\'m NOT_LOGGED_IN boyss :(((((');
        return new LoginSignupPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          print('I\'m LOGGED_IN boyss');
          return new Dashboard(
            userId: _userId,
            email: _userEmail,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
