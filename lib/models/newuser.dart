import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NewUser extends StatefulWidget {
  NewUser({
    this.uid,
    this.email,
  });
  final String uid;
  final String email;
  @override
  _NewUserState createState() => _NewUserState(uid: uid, uemail: email);
}

class _NewUserState extends State<NewUser> {
  _NewUserState({
    this.uid,
    this.uemail,
  });
  bool isLoading = false;
  String _fname = '';
  String _mname = '';
  String _lname = '';
  String _gender = 'F';
  String _errorMessage = "";
  String _contact;
  String _gr;
  DateTime _dob;
  DateTime _doj;
  final String uid;
  final String uemail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complete profile',
          style: TextStyle(
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Stack(
        children: <Widget>[
          showForm(),
          showProgress(),
        ],
      ),
    );
  }

  Widget showProgress() {
    if (isLoading) {
      return Center(
        child: Container(
          height: 60,
          width: 60,
          child: CircularProgressIndicator(
            strokeWidth: 7,
          ),
        ),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget showForm() {
    return Container(
      // height: 200,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            fnameField(),
            mnameField(),
            lnameField(),
            contactField(),
            genderField(),
            dobField(),
            joiningField(),
            grField(),
            standardField(),
            errorField(),
            submitButton()
          ],
        ),
      ),
    );
  }

  Widget fnameField() {
    return Container(
      height: 70,
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black38,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'First Name',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          alignLabelWithHint: true,
          prefixIcon: Icon(
            Icons.text_fields,
            color: Colors.purple,
          ),
        ),
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        onChanged: (val) => _fname = val.trim(),
      ),
    );
  }

  Widget mnameField() {
    return Container(
      height: 70,
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black38,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Middle Name',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          alignLabelWithHint: true,
          prefixIcon: Icon(
            Icons.text_fields,
            color: Colors.purple,
          ),
        ),
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        onChanged: (val) => _mname = val.trim(),
      ),
    );
  }

  Widget lnameField() {
    return Container(
      height: 70,
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black38,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Last Name',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          alignLabelWithHint: true,
          prefixIcon: Icon(
            Icons.text_fields,
            color: Colors.purple,
          ),
        ),
        textCapitalization: TextCapitalization.words,
        keyboardType: TextInputType.text,
        onChanged: (val) => _lname = val.trim(),
      ),
    );
  }

  Widget contactField() {
    return Container(
      height: 85,
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black38,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: TextFormField(
        maxLength: 10,
        decoration: InputDecoration(
          hintText: 'Contact No.',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          alignLabelWithHint: true,
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.purple,
          ),
        ),
        keyboardType: TextInputType.number,
        onChanged: (val) => _contact = val.trim(),
      ),
    );
  }

  Widget joiningField() {
    return Container(
      height: 70,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      decoration: BoxDecoration(
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black38,
              offset: Offset(2, 4),
            )
          ]),
      child: ListTile(
        leading: Icon(
          Icons.calendar_today,
          color: Colors.purple,
        ),
        title: Text(
          _doj == null
              ? 'Select Year of Joining school'
              : 'Year of Joining: ' + _doj.year.toString(),
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        trailing: IconButton(
            icon: Icon(
              Icons.live_help,
              size: 28,
              color: Colors.purple,
            ),
            onPressed: () {
              showDialog(
                context: context,
                child: AlertDialog(
                  title: Text('How to fill this?'),
                  content: Text(
                      'Select any date in the year you joined the school.\nIf you joined in the academic year 2005-2006, select any date in the year 2005'),
                ),
              );
            }),
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(2000),
            lastDate: DateTime(DateTime.now().year),
          ).then((value) {
            setState(() {
              _doj = value;
            });
            print('Student joined in ' + _doj.year.toString());
          });
        },
      ),
    );
  }

  Widget genderField() {
    return Container(
      height: 70,
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
      decoration: BoxDecoration(
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black38,
              offset: Offset(2, 4),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
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
            value: _gender,
            style: TextStyle(
                fontSize: 21,
                fontFamily: 'Metropolis',
                color: Colors.purple[600],
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
                _gender = val;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget dobField() {
    return Container(
      height: 70,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      decoration: BoxDecoration(
          color: Colors.amber[100],
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.black38,
              offset: Offset(2, 4),
            )
          ]),
      child: ListTile(
        leading: Icon(
          Icons.calendar_today,
          color: Colors.purple,
        ),
        title: Text(
          _dob == null
              ? 'Select Date of Birth'
              : 'DOB: ' + _dob.toString().substring(0, 10),
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        onTap: () {
          showDatePicker(
            context: context,
            initialDate: DateTime(2001),
            firstDate: DateTime(1999),
            lastDate: DateTime(DateTime.now().year - 2),
          ).then((value) {
            setState(() {
              _dob = value;
            });
            print(_dob.toString());
          });
        },
      ),
    );
  }

  String standardValue = '10';

  Widget standardField() {
    return Container(
      height: 70,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black38,
            offset: Offset(2, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
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
                fontSize: 22,
                fontFamily: 'Metropolis',
                color: Colors.purple,
                fontWeight: FontWeight.bold),
            elevation: 15,
            iconSize: 22,
            icon: Icon(Icons.arrow_drop_down_circle),
            items: <String>['8', '9', '10']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                standardValue = val;
                print('Selected standard ' + standardValue);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget grField() {
    return Container(
      height: 90,
      alignment: Alignment.center,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black38,
            offset: Offset(2, 4),
          )
        ],
      ),
      child: TextFormField(
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          hintText: 'GR Number (for login)',
          alignLabelWithHint: true,
          prefixIcon: Icon(
            Icons.dialpad,
            color: Colors.purple,
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
        maxLength: 4,
        maxLines: 1,
        onChanged: (val) => _gr = val.trim(),
      ),
    );
  }

  Widget submitButton() {
    return Container(
      margin: EdgeInsets.all(15),
      child: MaterialButton(
        color: Colors.lightBlue,
        height: 50,
        child: Text(
          'Confirm',
          style: TextStyle(color: Colors.white, fontSize: 21),
        ),
        onPressed: () {
          if (verifyAllInputs()) {
            setState(() {
              _errorMessage = "";
            });
            showDialog(
              context: context,
              child: confirmDialog(),
            );
          } else {
            setState(() {
              _errorMessage =
                  "Invalid or empty inputs. Please give valid values";
            });
          }
        },
      ),
    );
  }

  Widget errorField() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        _errorMessage == "" ? "" : _errorMessage,
        style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
            fontFamily: 'Metropolis'),
      ),
    );
  }

  bool verifyAllInputs() {
    if (_fname.length > 1 &&
        _mname.length > 1 &&
        _lname.length > 1 &&
        _dob != null) {
      print('Everything\'s fine!');
      return true;
    }
    return false;
  }

  Widget confirmDialog() {
    return AlertDialog(
      title: Text(
        'Confirm profile?',
        style: TextStyle(fontFamily: 'Metropolis'),
      ),
      content: Text(
        'Click No to go back and make changes.',
        style: TextStyle(fontFamily: 'Metropolis'),
      ),
      actions: <Widget>[
        // Button to go back and make changes
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('No'),
        ),
        // Button to confirm submission
        FlatButton(
          child: Text('Submit'),
          onPressed: () async {
            Navigator.of(context).pop();
            // Close Dialog and start CPI
            setState(() {
              isLoading = true;
            });
            // Enter try catch block
            try {
              var document =
                  Firestore.instance.collection('students').document(uid);
              var status = await document.get();
              if (status.exists) {
                // Change error and stop CPI
                setState(() {
                  _errorMessage =
                      "User record already exists. Please login and refresh on the Dashboard.";
                  isLoading = false;
                });
              } else {
                // Continue CPI and write data
                document.setData({
                  'fname': _fname,
                  'mname': _mname,
                  'lname': _lname,
                  'dob': _dob.toString().substring(0, 10),
                  'contact': 9876543210,
                  'gender': _gender == 'M' ? 'Male' : 'Female',
                  'email': uemail,
                  'grnumber': _gr,
                  'userid': uid,
                  'standard': int.parse(standardValue),
                  'verified': true,
                  'current': true,
                  'complete': true,
                  'yearofjoining': _doj.year.toString(),
                });
                print('Done writing to students ++');
                Firestore.instance
                    .collection('mapping')
                    .document(_gr.toString())
                    .setData(
                  {
                    'email': uemail,
                  },
                );
                print('Done writing to mapping +\nStopping CPI now.');
                // Stop CPI
                setState(() {
                  isLoading = false;
                });
                // Exit dialog
                Navigator.of(context).pop();
                // Exit NewUser page
                // Navigator.of(context).pop();
              }
            } catch (e) {
              // Stop CPI and change error
              setState(() {
                isLoading = false;
                _errorMessage =
                    'An error occured. Please check your network connection.';
              });
            }
          },
        ),
      ],
    );
  }
}
