import 'package:App_Students/models/newuser.dart';
import 'package:App_Students/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:App_Students/services/authentication.dart';
import 'package:App_Students/models/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:App_Students/models/assignments.dart';
import 'package:App_Students/models/chatforum.dart';
import 'package:App_Students/models/dev.dart';
import 'package:App_Students/models/mocklectures.dart';
import 'package:App_Students/models/notices.dart';

class Dashboard extends StatefulWidget {
  Dashboard({
    Key key,
    this.auth,
    this.userId,
    this.logoutCallback,
    this.email,
  });
  final BaseAuth auth;
  final Function logoutCallback;
  final String userId;
  final String email;

  @override
  _DashboardState createState() => _DashboardState(uid: userId, email: email);
}

class _DashboardState extends State<Dashboard> {
  _DashboardState({
    this.uid,
    this.email,
  });
  final String uid;
  final String email;
  DocumentSnapshot snap;
  String username = "";
  bool isProfileComplete = false;
  bool isLoading = false;
  List dataKeys = [
    'fname',
    'mname',
    'lname',
    'standard',
    'email',
    'grnumber',
    'dob',
    'contact'
  ];
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    print(uid);
    print(snap.toString());
    setState(() {
      isLoading = true;
    });
    // Begin CPI
    fetchData(uid);
    super.initState();
  }

  void fetchData(String uid) async {
    try {
      snap =
          await Firestore.instance.collection('students').document(uid).get();
      // Document for the student is loaded
      if (!snap.exists) {
        print('Snap doesn\'t exist!! ****');
        setState(() {
          isProfileComplete = false;
        });
      } else if ((snap.exists && snap['verified'] == false)) {
        print('Snap exists but false, idk how :(');
        setState(() {
          isProfileComplete = false;
        });
      } else {
        print('Snap okay and verified');
        setState(() {
          isProfileComplete = snap['verified'];
          username = snap['fname'].toString();
          isLoading = false;
        });
        print(isProfileComplete.toString() + '\t' + isLoading.toString());
      }
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
        // Circle stops
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student Dashboard',
          style: TextStyle(fontFamily: 'Metropolis'),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.refresh,
            ),
            tooltip: 'Refresh status',
            onPressed: () {
              fetchData(uid);
              print('Refreshing now');
            },
          )
        ],
      ),
      drawer: dashboardDrawer(),
      body: Stack(
        children: <Widget>[
          showDashboard(),
          showProgress(),
        ],
      ),
    );
  }

  Widget dashboardDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).viewPadding.top,
          ),
          DrawerHeader(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [Colors.red, Colors.blue],
              ),
            ),
            curve: Curves.bounceInOut,
            child: Container(
              child: Center(
                child: Text(
                  'Student\'s App, KESBV',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).textScaleFactor*25,
                    fontFamily: 'Metropolis',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lightBlue[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.blue[900],
                  blurRadius: 3,
                  offset: Offset(2, 3),
                ),
              ],
            ),
            child: ListTile(
              leading: Icon(
                Icons.settings,
                size: 30,
                color: Colors.black87,
              ),
              title: Text(
                'Settings',
                style: TextStyle(fontSize: 18, fontFamily: 'Metropolis'),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => Settings()),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.lightBlue[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.blue[900],
                  blurRadius: 3,
                  offset: Offset(2, 3),
                ),
              ],
            ),
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 30,
                color: Colors.black87,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Metropolis',
                ),
              ),
              onTap: signOut,
              enabled: isProfileComplete,
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.lightBlue[200],
                boxShadow: [
                  BoxShadow(
                      color: Colors.blue[900],
                      blurRadius: 3,
                      offset: Offset(2, 3)),
                ]),
            child: ListTile(
              title: Text(
                'Your Profile',
                style: TextStyle(fontSize: 18, fontFamily: 'Metropolis'),
              ),
              enabled: isProfileComplete,
              subtitle: Text(
                uid,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Metropolis',
                ),
              ),
              onTap: () {
                print('Profile should open now..');
                if (snap.data != null) {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) =>
                          Profile(userdata: snap.data, keys: dataKeys),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget showDashboard() {
    return SingleChildScrollView(
      child: Container(
        // margin: EdgeInsets.fromLTRB(25, 5, 25, 5),
        // height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.grey[100]),
        child: Column(
          children: <Widget>[
            SizedBox(height: 25),
            Text(
              'Welcome ' + username + '!',
              style: TextStyle(
                fontFamily: 'Metropolis',
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(
              height: 30,
              thickness: 8,
              color: Colors.blue[700],
              indent: 40,
              endIndent: 40,
            ),
            isProfileComplete
                ? Container(
                    height: 0.0,
                    width: 0.0,
                  )
                : Container(
                    color: Colors.amber[100],
                    padding: const EdgeInsets.all(8.0),
                    margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: ListTile(
                      title: Text(
                        'Complete your profile',
                        style: TextStyle(fontFamily: 'Metropolis'),
                      ),
                      subtitle: Text(
                        'You must complete your profile before you can access the contents of the app. ' +
                            'Tap refresh if you have filled profile',
                        style: TextStyle(
                          fontFamily: 'Metropolis',
                        ),
                      ),
                      leading: Icon(
                        Icons.warning,
                        size: 30,
                        color: Colors.blue,
                      ),
                      trailing: Icon(
                        Icons.person_add,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => NewUser(
                              uid: uid,
                              email: email,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            rowOne(),
            rowTwo(),
            rowThree(),
            rowFour(),
            // rowFive(),
            SizedBox(
              height: 25,
            ),
            Text(
              'End of page',
              style: TextStyle(
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showProgress() {
    if (isLoading) {
      return Center(
        child: Container(
          height: 150,
          width: 150,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            strokeWidth: 6,
          ),
        ),
      );
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget rowOne() {
    return Container(
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: allGrads[0],
          ),
          boxShadow: [myShadow]),
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: ListTile(
        enabled: isProfileComplete,
        title: Text(
          allTitles[0],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: MediaQuery.of(context).textScaleFactor *22,
            fontWeight: FontWeight.bold,
            color: isProfileComplete ? Colors.black : Colors.grey,
          ),
        ),
        leading: Image.asset(
          allAssets[0],
          // height: 20,
          // width: 20,
        ),
        onTap: () {
          print('See all assignments please');
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => pages[0],
            ),
          );
        },
      ),
    );
  }

  Widget rowTwo() {
    return Container(
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: allGrads[1],
          ),
          boxShadow: [myShadow]),
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: ListTile(
        enabled: isProfileComplete,
        title: Text(
          allTitles[1],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: MediaQuery.of(context).textScaleFactor *22,
            fontWeight: FontWeight.bold,
            color: isProfileComplete ? Colors.black : Colors.grey,
          ),
        ),
        leading: Image.asset(
          allAssets[1],
          // height: 20,
          // width: 20,
        ),
        onTap: () {
          print('See all assignments please');
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => pages[1],
            ),
          );
        },
      ),
    );
  }

  Widget rowThree() {
    return Container(
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: allGrads[2],
          ),
          boxShadow: [myShadow]),
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: ListTile(
        enabled: isProfileComplete,
        title: Text(
          allTitles[2],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: MediaQuery.of(context).textScaleFactor *22,
            fontWeight: FontWeight.bold,
            color: isProfileComplete ? Colors.black : Colors.grey,
          ),
        ),
        leading: Image.asset(
          allAssets[2],
          // height: 20,
          // width: 20,
        ),
        onTap: () {
          print('See all assignments please');
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => pages[2],
            ),
          );
        },
      ),
    );
  }

  Widget rowFour() {
    return Container(
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: allGrads[3],
          ),
          boxShadow: [myShadow]),
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: ListTile(
        enabled: isProfileComplete,
        title: Text(
          allTitles[3],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: MediaQuery.of(context).textScaleFactor *22,
            fontWeight: FontWeight.bold,
            color: isProfileComplete ? Colors.black : Colors.grey,
          ),
        ),
        leading: Image.asset(
          allAssets[3],
          // height: 20,
          // width: 20,
        ),
        onTap: () {
          print('See all assignments please');
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => pages[3],
            ),
          );
        },
      ),
    );
  }

  Widget rowFive() {
    return Container(
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: allGrads[4],
          ),
          boxShadow: [myShadow]),
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: ListTile(
        enabled: isProfileComplete,
        title: Text(
          allTitles[4],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Metropolis',
            fontSize: MediaQuery.of(context).textScaleFactor *22,
            fontWeight: FontWeight.bold,
            color: isProfileComplete ? Colors.black : Colors.grey,
          ),
        ),
        leading: Image.asset(
          allAssets[4],
          // height: 20,
          // width: 20,
        ),
        onTap: () {
          print('See all assignments please');
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => pages[4],
            ),
          );
        },
      ),
    );
  }

  List<TextStyle> styles = [
    TextStyle(
        fontFamily: 'Arsenal',
        fontWeight: FontWeight.bold,
        fontSize: 36,
        color: Colors.white),
  ];

  List allGrads = [
    [Colors.amber[100], Colors.amber[400]],
    [Colors.pink[100], Colors.pink[400]],
    [Colors.teal[100], Colors.teal[400]],
    [Colors.blueAccent[100], Colors.blueAccent[400]],
    [Colors.amber[100], Colors.amber[400]]
  ];

  List allAssets = [
    'assets/assignment64.png',
    'assets/notice64.png',
    'assets/lecture80.png',
    'assets/about256.png',
    'assets/chat64.png',
  ];

  List allTitles = [
    'Assignments/Resources',
    'Noticeboard',
    'Live Lectures',
    'About App',
    'Chat Forum',
  ];

  int myStandard = 99;

  List pages = [Assgn(), Notices(), Lectures(), Developer(), ChatForum()];

  var myRadiusSet = BorderRadius.only(
    topLeft: Radius.circular(40),
    bottomRight: Radius.circular(40),
    topRight: Radius.circular(10),
    bottomLeft: Radius.circular(10),
  );
  BoxShadow myShadow = BoxShadow(
    color: Colors.grey[600],
    blurRadius: 8,
    offset: Offset(5, 8),
  );
  double buttonsHeight = 75;
  double buttonsWidth = double.infinity;
}
