import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:students_kesbv/models/newuser.dart';
import '../pages/login_signup_page.dart';
import '../services/authentication.dart';
import '../models/dashboard.dart';
import 'dart:core';

enum AuthStatus {
  NOT_DETERMINED, //when there is an error
  NOT_LOGGED_IN, //when the user is signed out
  LOGGED_IN, //when the user is logged in
  IN_PROGRESS, //when the user is signed up/signed in but profile is incomplete
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
  String _grno = '';
  FirebaseUser localUser;

  @override
  void initState() {
    super.initState();

    widget.auth.getCurrentUser().then((user) async {
      if (user != null) {
        setState(() {
          _userEmail = user.email;
          localUser = user;
        });
      }
      // var curAuthStatus = await
      tryCheckStatus().then((status) {
        print('Found the status boyss!! => ' + status.toString());
        if (status == AuthStatus.IN_PROGRESS) {
          setState(() {
            authStatus = status;
          });
        } else {
          if (authStatus == AuthStatus.IN_PROGRESS && user != null) {
            setState(() {
              authStatus = AuthStatus.IN_PROGRESS;
              _userEmail = user.email;
              print('In if case => ' + authStatus.toString());
            });
          } else {
            setState(() {
              if (user != null) {
                _userId = user?.uid;
                _userEmail = user?.email;
              }

              authStatus = user?.uid == null
                  ? AuthStatus.NOT_LOGGED_IN
                  : AuthStatus.LOGGED_IN;
              localUser = user;
              print('In else case => ' + authStatus.toString());
            });
          }
        }
      });
    });
  }

  Future<AuthStatus> tryCheckStatus() async {
    AuthStatus curStatus;
    // var ref = ;
    if (localUser != null) {
      var data = await Firestore.instance
          .collection('email_gr_maps')
          .document(_userEmail)
          .get();
      try {
        if (data.exists) {
          if (data.data['status'] == false) {
            curStatus = AuthStatus.IN_PROGRESS;
            print('I guess NOT TRUE');
          } else {
            curStatus = AuthStatus.LOGGED_IN;
            print('Looks like you\'re IN');
          }
        } else
          curStatus = null;
      } catch (e) {
        print(e);
        curStatus = null;
      }
      return curStatus;
    } else {
      return null;
    }
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

  void signupCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
        _userEmail = user.email;
      });
    });
    // writeToCollection();
    setState(() {
      // _grno = gr;
      authStatus = AuthStatus.IN_PROGRESS;
      print('Signup callback mara =>' + authStatus.toString());
      // FULLY WORKING! YAY!
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
          strokeWidth: 8,
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
          signupCallback: signupCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          print('I\'m LOGGED_IN boyss');
          return new Dashboard(
            gr: _grno,
            userId: _userId,
            user: localUser,
            auth: widget.auth,
            logoutCallback: logoutCallback,
            userEmail: _userEmail,
          );
        } else
          return buildWaitingScreen();
        break;
      case AuthStatus.IN_PROGRESS:
        print('I\'m still IN PROGRESS');
        return new NewUser(
          userId: _userId,
          auth: widget.auth,
          user: localUser,
          // logoutCallback: logoutCallback,
          loginCallback: loginCallback,
          email: _userEmail,
          // signupCallback:signupCallback
        );
      default:
        return buildWaitingScreen();
    }
  }
}
