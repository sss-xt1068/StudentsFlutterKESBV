import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/authentication.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback, this.signupCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;
  final Function signupCallback;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();
  Firestore ref = Firestore.instance;
  String _email;
  String _tempmail;
  String _password;
  String _errorMessage;
  String _gr;

  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          // _tempmail = 'thebatfan1999@gmail.com';
          // print(_email+_email.length.toString());
          _tempmail = await getMail(_gr.trim());
          // overriding email working
          // now to get email from firestore collection
          userId = await widget.auth.signIn(_tempmail, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          // final snackbar = SnackBar(
          //   content: Text('Signup complete! Logging in now!'),
          // );
          // Scaffold.of(context).showSnackBar(snackbar);
          print('Signed up user: $userId');
          userId = await widget.auth.signIn(_email, _password);
          print('Signin done\n\nProceeding with GR:' +
              _gr +
              ' and email ' +
              _email);
          writeGR(_email, _gr);
          print('email written to file successfully!');
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        } else if (userId.length > 0 && userId != null && !_isLoginForm) {
          // widget
          widget.signupCallback();
        }
      } catch (e) {
        // showDialog(
        //   barrierDismissible: true,
        //   context: context,
        //   child: AlertDialog(
        //     title: Text('Error'),
        //     content: Text(e.message),
        //     actions: <Widget>[
        //       FlatButton(
        //           onPressed: () {
        //             print('Dialog dismissed');
        //             Navigator.of(context).pop();
        //           },
        //           child: Text('Got it'))
        //     ],
        //   ),
        // );
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename.txt');
  }

  Future<File> writeGR(String email, String gr) async {
    final file = await _localFile(email);
    print('Writing now babe');
    return file.writeAsString('$gr#false');
    // mentions that the file named 'abc@abc.com.txt' has the contents '9999#false'
    // once the signup process is done, #false will either change to #true
    // or it will change to empty string (to be decided later)
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
    print(_isLoginForm);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(
          'K.E.S\' Bhagavati Vidyalaya',
          style: TextStyle(
            fontFamily: 'Arsenal',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          _showForm(),
          _showCircularProgress(),
        ],
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 6,
        ),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

//  void _showVerifyEmailSentDialog() {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          title: new Text("Verify your account"),
//          content:
//              new Text("Link to verify account has been sent to your email"),
//          actions: <Widget>[
//            new FlatButton(
//              child: new Text("Dismiss"),
//              onPressed: () {
//                toggleFormMode();
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

  Widget _showForm() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.lightBlue[50],
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showLogo(),
            showGRInput(),
            _isLoginForm ? Container() : showEmailInput(),
            showPasswordInput(),
            helperText(),
            showPrimaryButton(),
            showSecondaryButton(),
            showErrorMessage(),
          ],
        ),
      ),
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: ClipOval(
        child: Image.asset(
          'assets/school1.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Container(
      width: 150,
      height: 80,
      margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.amber[100], Colors.amber[300]],
          ),
          boxShadow: [
            BoxShadow(
                blurRadius: 4, color: Colors.grey[600], offset: Offset(3, 5))
          ],
          borderRadius: BorderRadius.circular(20)),
      child: new TextFormField(
        textAlign: TextAlign.center,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Email',
          icon: new Icon(
            Icons.email,
            color: Colors.grey[600],
            size: 35,
          ),
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onChanged: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Container(
      width: 150,
      height: 80,
      margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
      padding: EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.amber[100], Colors.amber[300]]),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                blurRadius: 4, color: Colors.grey[600], offset: Offset(3, 5))
          ]),
      child: new TextFormField(
        textAlign: TextAlign.center,
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Password',
          icon: new Icon(Icons.lock, size: 35, color: Colors.grey[600]),
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onChanged: (value) {
          _password = value.trim();
          print(_password);
        },
      ),
    );
  }

  Widget showGRInput() {
    return Container(
      width: 150,
      height: 80,
      margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
      padding: EdgeInsets.only(left: 20, right: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: [Colors.amber[100], Colors.amber[300]]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              blurRadius: 4, color: Colors.grey[600], offset: Offset(3, 5))
        ],
      ),
      child: new TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLines: 1,
        maxLength: 4,
        obscureText: false,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'GR Number',
            icon: new Icon(
              Icons.person,
              size: 35,
              color: Colors.grey[600],
            ),
            enabledBorder: InputBorder.none,
            disabledBorder: InputBorder.none),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _gr = value.trim(),
      ),
    );
  }

  Widget helperText() {
    return Container(
      width: 200,
      height: 50,
      alignment: Alignment.center,
      child: Text(
        _isLoginForm
            ? 'Login to your account now'
            : 'Signup and create a profile',
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget showPrimaryButton() {
    return new Padding(
      padding: EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
      child: SizedBox(
        height: 40.0,
        child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          color: Colors.blue,
          child: new Text(_isLoginForm ? 'Login' : 'Create account',
              style: new TextStyle(fontSize: 20.0, color: Colors.white)),
          onPressed: validateAndSubmit,
        ),
      ),
    );
  }

  Widget showSecondaryButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: new FlatButton(
        color: Colors.orange[100],
        highlightColor: Colors.purple[200],
        child: new Text(
          _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
          style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        onPressed: toggleFormMode,
      ),
    );
  }

  Future<String> getMail(String justGR) async {
    String tempEmail;
    var doc = ref.collection('gr_email_maps').document(justGR);
    var data = await doc.get();
    tempEmail = data['email'];
    print(tempEmail);
    return tempEmail;
  }
}
