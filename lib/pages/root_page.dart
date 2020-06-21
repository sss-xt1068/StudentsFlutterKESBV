import 'package:flutter/material.dart';
import 'package:students_kesbv/models/newuser.dart';
import '../pages/login_signup_page.dart';
import '../services/authentication.dart';
import '../models/dashboard.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:core';
import 'dart:io';

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

  @override
  void initState() {
    super.initState();

    widget.auth.getCurrentUser().then((user) async {
      if (user != null) {
        setState(() {
          _userEmail = user.email;
        });
      }
      var curAuthStatus = await tryCheckStatus();
      if (curAuthStatus == AuthStatus.IN_PROGRESS && user != null) {
        setState(() {
          authStatus = AuthStatus.IN_PROGRESS;
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
        });
      }
    });
  }

  Future<AuthStatus> tryCheckStatus() async {
    try {
      var inSignup = await readStatus();
      if (inSignup != null) {
        if (!inSignup) {
          return AuthStatus.IN_PROGRESS;
        }
      }
      else
      {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_userEmail.txt');
  }

  Future<bool> readStatus() async {
    bool returnValue = false;
    try {
      final file = await _localFile;
      // Read the file.
      String contents = await file.readAsString();
      print(contents);
      List stats = contents.split('#');
      if (stats[1] == 'false') {
        returnValue = false;
        print('You can\'t go ahead yet babe!');
      } else {
        returnValue = true;
        print('Sure, come on in!!');
      }
      // return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0.
      print('mmmmmmmmmmmmmmmmmmmNot found');
      returnValue = null;
    }
    return returnValue;
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
    });
  }

  void signupCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
        _userEmail = user.email;
      });
    });
    setState(() {
      // _grno = gr;
      authStatus = AuthStatus.IN_PROGRESS;
      // FULLY WORKING! YAY!
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
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
        return new LoginSignupPage(
          auth: widget.auth,
          loginCallback: loginCallback,
          signupCallback: signupCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new Dashboard(
            gr: _grno,
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
            userEmail: _userEmail,
          );
        } else
          return buildWaitingScreen();
        break;
      case AuthStatus.IN_PROGRESS:
        return new NewUser(
          userId: _userId,
          auth: widget.auth,
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
