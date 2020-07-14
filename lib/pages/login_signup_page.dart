import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/authentication.dart';

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
  String _password;
  String _errorMessage;
  String _gr;

  bool _isLoginForm;
  bool _isLoading;
  bool isObscure = true;

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    // fetch
    super.initState();
  }

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
    // if (validateAndSave()) {
    String userId = "";
    try {
      print('Am i trying?');
      if (_isLoginForm) {
        // tempmail to be retrieved from some collection
        String _tempmail = await findMailForGR(_gr);
        userId = await widget.auth.signIn(_tempmail, _password);
        print('Signed in: $userId');
      } else {
        userId = await widget.auth.signUp(_email, _password);
        print('Signed up user: $userId');
        userId = await widget.auth.signIn(_email, _password);
        //widget.auth.sendEmailVerification();
        //_showVerifyEmailSentDialog();
      }
      if (userId.length > 0 && userId != null) {
        widget.loginCallback();
      }
      setState(() {
        _isLoading = false;
      });
    } on NoSuchMethodError catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
        _errorMessage = 'User does not exist or record not written properly';
        _formKey.currentState.reset();
      });
    } catch (e) {
      print('Error: $e');
      print(e.type);
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
        _formKey.currentState.reset();
      });
    }
  }

  Future<String> findMailForGR(String gRtoMatch) async {
    var doc = await ref.collection('mapping').document(gRtoMatch).get();
    String emailToReturn = doc['email'];
    bool status = doc['status'];
    print(emailToReturn + " has status " + status.toString());
    return emailToReturn;
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
      padding: EdgeInsets.only(left: 16.0, right: 16),
      // margin: EdgeInsets.only(bottom: 30),
      // color: Colors.lightBlue[50],
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightBlue[100],
            Colors.blue[100],
            Colors.orange[100],
            Colors.red[200],
          ],
          // begin: Alignment.bottomLeft
        ),
      ),
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            showLogo(),
            _isLoginForm ? showGRInput() : showEmailInput(),
            showPasswordInput(),
            showPassword(),
            helperText(),
            showPrimaryButton(),
            showSecondaryButton(),
            showErrorMessage(),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage != null) {
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
      // width: 150,
      height: 70,
      margin: EdgeInsets.fromLTRB(30, 10, 30, 5),
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
      // width: 150,
      height: 70,
      margin: EdgeInsets.fromLTRB(30, 10, 30, 5),
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
        obscureText: isObscure,
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
      // width: 150,
      height: 70,
      margin: EdgeInsets.fromLTRB(40, 10, 40, 5),
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
        validator: (value) => value.isEmpty ? 'GR can\'t be empty' : null,
        onChanged: (value) => _gr = value.trim(),
      ),
    );
  }

  Widget showPassword() {
    return Container(
      margin: EdgeInsets.fromLTRB(70, 5, 70, 5),
      child: FlatButton(
          color: Colors.indigo[100],
          // textColor: Colors.white,
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          child: Text(isObscure ? 'Show Password' : 'Hide Password')),
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
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: new RaisedButton(
        color: Colors.amber[100],
        highlightColor: Colors.purple[200],
        elevation: 8,
        child: new Text(
          _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
          style: new TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
            // color: Colors.white
          ),
        ),
        onPressed: toggleFormMode,
      ),
    );
  }
}
