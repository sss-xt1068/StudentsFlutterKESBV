import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/authentication.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:core';
import 'dart:io';

class NewUser extends StatefulWidget {
  NewUser({Key key, this.auth, this.loginCallback, this.userId, this.email});
  final BaseAuth auth;
  final VoidCallback loginCallback;
  final String userId;
  final String email;

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
  String batch = '';
  String _errorMessage = '';
  bool _isProcessing = false;
  int standard;
  TextEditingController grController = TextEditingController();

  @override
  void initState() {
    // read grnumber from file with name email
    readMyGR();
    super.initState();
  }

  // double _percentFilled = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.purple,
      //   title: Text('Create Profile'),
      //   actions: <Widget>[
      //     Transform.rotate(
      //       angle: -3.14,
      //       child: IconButton(
      //         icon: new Icon(
      //           Icons.exit_to_app,
      //           color: Colors.white,
      //           size: 30,
      //         ),
      //         onPressed: signOut,
      //       ),
      //     )
      //   ],
      // ),
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
          // Colors.blueAccent[100],
          Colors.blue[400],
        ], begin: Alignment.topCenter),
      ),
      child: SingleChildScrollView(
        child: Container(
          height: 1350,
          child: Column(
            children: [
              SizedBox(height: 30),
              headTag(),
              showImage(),
              tagOne(),
              Flexible(flex: 4, child: fnameField()),
              Flexible(flex: 4, child: mnameField()),
              Flexible(flex: 4, child: lnameField()),
              Flexible(flex: 4, child: dobField()),
              Flexible(flex: 2, child: errorDisplay()),
              Flexible(flex: 5, child: standardField()),
              tagTwo(),
              Flexible(flex: 5, child: emailField()),
              Flexible(flex: 5, child: grField()),
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
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      margin: EdgeInsets.fromLTRB(20, 15, 20, 10),
      child: TextFormField(
        // textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          icon: Icon(Icons.date_range),
          enabledBorder: InputBorder.none,
          hintText: 'DOB (dd/mm/yyyy)',
          alignLabelWithHint: true,
        ),
        onChanged: (val) {
          List dates = val.split('/');
          dd = dates[0];
          mm = dates[1];
          yy = dates[2];
          print(dd + '/' + mm + '/' + yy);
          if ((mm.trim().length != 2) ||
              (int.parse(mm) > 12) ||
              (dd.trim().length != 2) ||
              (int.parse(dd) > 31) ||
              (yy.trim().length != 4) ||
              (int.parse(yy) < 2000)) {
            setState(() {
              _errorMessage =
                  'Incorrect DoB format. Please enter in the mentioned format';
              print(_errorMessage);
            });
          } else {
            setState(() {
              _errorMessage = '';
            });
          }
        },
      ),
    );
  }

  Widget errorDisplay() {
    return Container(
      child: Text(
        _errorMessage,
        style: TextStyle(color: Colors.red, fontSize: 14),
      ),
    );
  }

  Widget standardField() {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Colors.lightBlue[100],
            Colors.white,
          ], begin: Alignment.topLeft),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 4, offset: Offset(3, 5))
          ]),
      padding: EdgeInsets.only(left: 20, right: 20),
      margin: EdgeInsets.fromLTRB(20, 10, 120, 20),
      child: TextFormField(
        maxLength: 2,
        // textCapitalization: TextCapitalization.words,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.looks_one),
          enabledBorder: InputBorder.none,
          hintText: 'Standard',
          alignLabelWithHint: true,
          suffixIcon: IconButton(
              icon: Icon(Icons.help_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  child: AlertDialog(
                    title: Text('Questions for filling standard?'),
                    content: Text(
                        'For standards other than 10, please enter only the digit. For e.g, 8 and not 08'),
                  ),
                );
              }),
        ),
        onChanged: (val) => standard = int.parse(val.trim()),
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
        controller: grController,
        textCapitalization: TextCapitalization.none,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.number,
        // initialValue: initGR,
        decoration: InputDecoration(
          labelText: 'GR Number (autofilled)',
          icon: Icon(Icons.short_text),
          disabledBorder: InputBorder.none,
          alignLabelWithHint: true,
        ),
        onChanged: (val) => lname = val.trim(),
      ),
    );
  }

  void readMyGR() async {
    var file = await _localFile(initEmail);
    var contents = await file.readAsString();
    List parts = contents.split('#');
    print(parts[0] + '.....' + parts[1]);
    setState(() {
      grController.text = parts[0].toString().trim();
    });
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile(String filename) async {
    final path = await _localPath;
    return File('$path/$filename.txt');
  }

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
                var ref = Firestore.instance;
                var document = ref.collection('students');
                document.document('GR_' + grController.text.trim()).setData({
                  'fname': fname.trim(),
                  'mname': mname.trim(),
                  'lname': lname.trim(),
                  'dob': '$dd/$mm/$yy'.trim(),
                  'grnumber': grController.text.trim(),
                });
                document = ref.collection('gr_email_maps');
                document
                    .document(grController.text.trim())
                    .setData({'email': initEmail});
                print('Data written, now writing true to file');
                var file = await _localFile(initEmail);
                var result = await file.writeAsString('$gr#true');
                print(result.path);
                setState(() {
                  _isProcessing = false;
                });
                Navigator.of(context).pop();
                widget.loginCallback();
              } catch (e) {
                Navigator.of(context).pop();
                showDialog(context: context,
                child: AlertDialog(
                  title:Text('Error occured'),
                  content: Text(e.message),
                  actions: <Widget>[
                    FlatButton(onPressed: (){
                      Navigator.of(context).pop();
                    }, child: null)
                  ],
                ));
              }
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }
}
