import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/authentication.dart';
import 'dart:core';
import 'dart:async';

class NewUser extends StatefulWidget {
  NewUser(
      {Key key,
      this.auth,
      this.loginCallback,
      this.userId,
      this.email,
      this.user});
  final BaseAuth auth;
  final VoidCallback loginCallback;
  final String userId;
  final String email;
  final FirebaseUser user;

  @override
  _NewUserState createState() => _NewUserState(initEmail: email);
}

class _NewUserState extends State<NewUser> {
  _NewUserState({this.initEmail});
  String initEmail;
  String fname = '';
  String mname = '';
  String lname = '';
  String dd = '';
  String mm = '';
  String yy = '';
  String gr = '';
  String tempGR;
  String batch = '';
  String _errorMessage = '';
  bool _isProcessing = false;
  List dates;
  DateTime dob;
  TextEditingController grController = TextEditingController();

  @override
  void initState() {
    // read grnumber from file with name email
    // _isProcessing = true;
    super.initState();
    Future.delayed(Duration(seconds: 10), loadGR);
    print('Am I executing first??');
  }

  void loadGR() {
    readMyGR().then((value) {
      setState(() {
        gr = value;
      });
      print('Loaded gr to=>' + gr);
    });
  }

  Future<String> readMyGR() async {
    print(initEmail);
    String ret;
    // Future.delayed(Duration(seconds: 10), () async {
    var document = await Firestore.instance
        .collection('email_gr_maps')
        .document(initEmail)
        .get();
    if (document.data['status'] == true) {
      print('Just can\'t do it');
    } else
      ret = document.data['gr'];
    // });
    print('God help me, I\'m sending my gr=>' + ret);
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            showForm(),
            showCircularProgress(),
          ],
        ),
      ),
    );
  }

  Widget showForm() {
    return Container(
      // height: 500,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.white,
          Colors.white,
          Color.fromRGBO(87, 42, 250, 0.8),
        ], begin: Alignment.topLeft),
      ),
      child: SingleChildScrollView(
        child: Container(
          height: 1000,
          child: Column(
            children: [
              SizedBox(height: 10),
              headTag(),
              showImage(),
              // tagOne(),
              Flexible(flex: 4, child: fnameField()),
              Flexible(flex: 4, child: mnameField()),
              Flexible(flex: 4, child: lnameField()),
              Flexible(flex: 5, child: dobField()),
              Flexible(flex: 2, child: errorDisplay()),
              Flexible(flex: 3, child: standardField()),
              // tagTwo(),
              Flexible(flex: 5, child: genderField()),
              // Flexible(flex: 5, child: grField()),
              submitButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget showCircularProgress() {
    if (_isProcessing) {
      return Center(
        child: Container(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            strokeWidth: 10,
          ),
        ),
      );
    }
    return Container(
      height: 0,
      width: 0,
    );
  }

  Widget headTag() {
    return Container(
      child: Text(
        'Complete your profile!',
        style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'Comfortaa'),
      ),
    );
  }

  Widget showImage() {
    return
        // Container(
        //   decoration: BoxDecoration(
        //     boxShadow: [
        //       BoxShadow(
        //         blurRadius: 4,
        //         offset: Offset(3, 6),
        //         color: Colors.black54,
        //       ),
        //     ],
        //     // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50))
        //   ),
        //   margin: EdgeInsets.all(20),
        //   child:
        Image.asset(
      'assets/profile-image.png',
      fit: BoxFit.cover,
      // ),
    );
  }

  Widget tagOne() {
    return Container(
      height: 60,
      margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(
        'Personal Info',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'Comfortaa',
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget fnameField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Colors.lightBlue[100],
            Colors.white,
          ], begin: Alignment.topLeft),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(3, 5))
          ]),
      padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
      margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
      // color: Colors.white,
      child: TextFormField(
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          icon: Icon(Icons.short_text),
          enabledBorder: InputBorder.none,
          hintText: 'First name',
          alignLabelWithHint: true,
        ),
        textCapitalization: TextCapitalization.words,
        onChanged: (val) {
          fname = val.trim();
        },
        textAlignVertical: TextAlignVertical.bottom,
      ),
    );
  }

  Widget mnameField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Colors.lightBlue[100],
            Colors.white,
          ], begin: Alignment.topLeft),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(3, 5))
          ]),
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          icon: Icon(Icons.short_text),
          enabledBorder: InputBorder.none,
          hintText: 'Middle name',
          alignLabelWithHint: true,
        ),
        onChanged: (val) => mname = val.trim(),
      ),
    );
  }

  Widget lnameField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Colors.lightBlue[100],
            Colors.white,
          ], begin: Alignment.topLeft),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(3, 5))
          ]),
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          icon: Icon(Icons.short_text),
          enabledBorder: InputBorder.none,
          hintText: 'Last name',
          alignLabelWithHint: true,
        ),
        onChanged: (val) => lname = val.trim(),
      ),
    );
  }

  Widget dobField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Colors.lightBlue[100],
            Colors.white,
          ], begin: Alignment.topLeft),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(3, 5))
          ]),
      margin: EdgeInsets.all(20),
      alignment: Alignment.center,
      child: ListTile(
        leading: Icon(Icons.calendar_today),
        title: Text(
          dob == null
              ? 'Select Date of Birth'
              : 'DOB: ' + dob.toString().substring(0, 10),
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        onTap: () {
          print('Gotta give my dob?');
          showDatePicker(
            context: context,
            initialDate: DateTime(2019),
            firstDate: DateTime(2000),
            lastDate: DateTime(DateTime.now().year),
          ).then((value) {
            setState(() {
              dob = value;
            });
            print(dob.toString());
          });
        },
      ),
    );
  }

  Widget errorDisplay() {
    return Container(
      child: Text(
        _errorMessage,
        style: TextStyle(color: Colors.black87, fontSize: 14),
      ),
    );
  }

  String standardValue = '10';

  Widget standardField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Colors.lightBlue[100],
            Colors.white,
          ], begin: Alignment.topLeft),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(3, 5))
          ]),
      alignment: Alignment.center,
      // color: Colors.blue[50],
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Choose standard',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
          SizedBox(width: 50),
          DropdownButton<String>(
            value: standardValue,
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Metropolis',
                color: Colors.blue[600],
                fontWeight: FontWeight.bold),
            elevation: 15,
            iconSize: 22,
            icon: Icon(Icons.arrow_drop_down_circle),
            items: <String>['7', '8', '9', '10']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                standardValue = val;
              });
            },
          ),
        ],
      ),
    );
  }

  String gender = 'M';
  Widget genderField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Colors.lightBlue[100],
            Colors.white,
          ], begin: Alignment.topLeft),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(3, 5))
          ]),
      alignment: Alignment.center,
      // color: Colors.blue[50],
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Gender',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
          SizedBox(width: 50),
          DropdownButton<String>(
            value: gender,
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'Metropolis',
                color: Colors.blue[600],
                fontWeight: FontWeight.bold),
            elevation: 15,
            iconSize: 22,
            icon: Icon(Icons.arrow_drop_down_circle),
            items: <String>['F', 'M']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                gender = val;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget tagTwo() {
    return Container(
      height: 60,
      margin: EdgeInsets.fromLTRB(30, 20, 0, 0),
      alignment: Alignment.centerLeft,
      child: Text(
        'Other info',
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Comfortaa'),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget emailField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Colors.lightBlue[100],
            Colors.white,
          ], begin: Alignment.topLeft),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(3, 5))
          ]),
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
      child: TextFormField(
        maxLines: 1,
        enabled: false,
        textCapitalization: TextCapitalization.none,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.emailAddress,
        initialValue: initEmail,
        decoration: InputDecoration(
          icon: Icon(Icons.short_text),
          disabledBorder: InputBorder.none,
          labelText: 'Email (autofilled)',
          // hintText: 'Email',
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget grField() {
    return Container(
      // height: 180,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Colors.lightBlue[100],
            Colors.white,
          ], begin: Alignment.topLeft),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(3, 5))
          ]),
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
      alignment: Alignment.bottomCenter,
      child: TextFormField(
        enabled: false,
        maxLines: 1,
        // controller: grController,
        textCapitalization: TextCapitalization.none,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.number,
        // initialValue: readMyGR().then((value) => null),
        initialValue: gr == '' ? 'Tap to refresh' : gr,
        decoration: InputDecoration(
          labelText: 'GR Number (autofilled)',
          icon: Icon(Icons.short_text),
          disabledBorder: InputBorder.none,
          alignLabelWithHint: true,
        ),
        // onChanged: (val) => lname = val.trim(),
      ),
    );
  }

  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return directory.path;
  // }

  // Future<File> _localFile(String filename) async {
  //   final path = await _localPath;
  //   return File('$path/$filename.txt');
  // }

  Widget submitButton() {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: 50, right: 50),
      child: MaterialButton(
        color: Colors.white,
        elevation: 8,
        onPressed: writeUserDetails,
        child: Text(
          'Confirm',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Comfortaa',
          ),
        ),
      ),
    );
  }

  void writeUserDetails() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      child: AlertDialog(
        title: Text('Confirm profile details?'),
        content: Text(
            'Entered details cannot be changed later. Review your changes by clicking No'),
        actions: <Widget>[
          FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            onPressed: () async {
              setState(() {
                _isProcessing = true;
              });
              try {
                if (validateAll()) {
                  var ref = Firestore.instance;
                  var document = ref.collection('students');
                  document.document('GR_' + gr.trim()).setData({
                    'fname': fname,
                    'mname': mname,
                    'lname': lname,
                    'dob': dob.toString().substring(0, 10),
                    'grnumber': gr,
                    'standard': int.parse(standardValue),
                    'gender': gender == 'M' ? 'Male' : 'Female',
                  });
                  print('Student added boii :!!********************');
                  document = ref.collection('email_gr_maps');
                  document.document(initEmail).updateData({
                    'status': true,
                  });
                  print('Changed status to true boii*********');
                  document = ref.collection('gr_email_maps');
                  document.document(gr).setData({
                    'email': initEmail,
                  });
                  print('Added doc to gr_email_maps boi*******');

                  // print('Data written, now writing true to email_gr_maps');
                  setState(() {
                    _isProcessing = false;
                  });
                  Navigator.of(context).pop();
                  widget.loginCallback();
                } else {
                  setState(() {
                    _isProcessing = false;
                  });
                  print('Na beta na');
                  Navigator.of(context).pop();
                }
              } catch (e) {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text('Error occured'),
                    content: Text(e.toString()),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: null,
                      )
                    ],
                  ),
                );
              }
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  bool validateAll() {
    if (fname.trim() == '' ||
        mname.trim() == '' ||
        lname.trim() == '' ||
        dob == null) {
      return false;
    }
    return true;
  }
}
