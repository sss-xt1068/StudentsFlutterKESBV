import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatForum extends StatefulWidget {
  @override
  _ChatForumState createState() => _ChatForumState();
}

class _ChatForumState extends State<ChatForum> {
  FirebaseDatabase mFirebaseDatabase;
  DatabaseReference mMessDatabaseReference;
  String st1 = 'This is still a pre-release app. ';
  String st2 = 'This chat forum is not yet fully managed or supervised. ';
  String st3 = 'So please do not use vulgar or swearing words. ';
  String st4 =
      'In case any such behaviour is found, I may directly remove your message. Thank you.';
  String _message = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addToDatabase() {
    setState(() {
      _isLoading = true;
    });
    if (_message != '') {
      print(_message);
      mFirebaseDatabase = FirebaseDatabase.instance;
      mMessDatabaseReference = mFirebaseDatabase.reference().child('st_chat');
      mMessDatabaseReference.push().set({
        'text': _message,
      });
      print('Supposedly added to database!');
      setState(() {
        _message = '';
        messageController.text = '';
      });
      printItems();
    }
  }

  List<TextStyle> chatStyles = [
    TextStyle(
      fontFamily: 'Comfortaa',
      fontWeight: FontWeight.bold,
      fontSize: 24,
    )
  ];
  bool _isLoading = false;
  var messageController = TextEditingController();
  List _curList = [''];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Forum'),
      ),
      body: Stack(
        children: <Widget>[
          showApp(),
          Positioned(
            bottom: 2,
            left: 2,
            child: showMessageBar(),
          ),
          showCircularProgress(),
        ],
      ),
      // bottomSheet: Row(
      //   children: <Widget>[
      //     Container(
      //       color: Colors.amber[100],
      //       margin: EdgeInsets.only(left: 40, right: 40),
      //       child: TextField(
      //         textCapitalization: TextCapitalization.sentences,
      //         controller: messageController,
      //         textAlign: TextAlign.center,
      //         decoration: InputDecoration(
      //           fillColor: Colors.blue,
      //           hintText: 'Type a message',
      //           focusedBorder: InputBorder.none,
      //           enabledBorder: InputBorder.none,
      //         ),
      //         onChanged: (val) {
      //           _message = val.trim();
      //         },
      //         onEditingComplete: () {
      //           print(_message);
      //         },
      //       ),
      //     ),
      //     FlatButton(
      //       textColor: Colors.black,
      //       color: Colors.lightBlue,
      //       onPressed: printItems,
      //       child: Text('Read Data'),
      //     ),
      //   ],
      // ),
    );
  }

  Widget showCircularProgress() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 6,
        ),
      );
    }
    return Container(
      height: 0,
      width: 0,
    );
  }

  Widget showApp() {
    return SingleChildScrollView(
      child: Center(
        child: Text('Chat Forum not enabled yet'),
      ),
      // child: Column(
      //   children: <Widget>[

      // Container(
      //   height: 400,
      //   margin: EdgeInsets.all(10),
      //   child: Center(
      //     child: ListView.builder(
      //       itemCount: _curList.length,
      //       itemBuilder: (context, index) => showList(
      //         context,
      //         _curList[index],
      //       ),
      //     ),
      //   ),
      // ),
      // // Container(
      // //   color: Colors.amber[100],
      // //   margin: EdgeInsets.only(left: 40, right: 40),
      // //   child: TextField(
      // //     textCapitalization: TextCapitalization.sentences,
      // //     controller: messageController,
      // //     textAlign: TextAlign.center,
      // //     decoration: InputDecoration(
      // //       fillColor: Colors.blue,
      // //       hintText: 'Type a message',
      // //       focusedBorder: InputBorder.none,
      // //       enabledBorder: InputBorder.none,
      // //     ),
      // //     onChanged: (val) {
      // //       _message = val.trim();
      // //     },
      // //     onEditingComplete: () {
      // //       print(_message);
      // //     },
      // //   ),
      // // ),
      // MaterialButton(
      //   child: Icon(
      //     Icons.send,
      //     size: 30,
      //     color: Colors.deepOrange,
      //   ),
      //   onPressed: addToDatabase,
      // ),
      // // FlatButton(
      // //   textColor: Colors.black,
      // //   color: Colors.lightBlue,
      // //   onPressed: printItems,
      // //   child: Text('Read Data'),
      // // ),
      // ],
      // ),
    );
  }

  Widget showList(BuildContext context, String data) {
    return Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.only(top: 9),
      color: Colors.amber[200],
      child: ListTile(
        title: Text(data),
      ),
    );
  }

  void printItems() async {
    await FirebaseDatabase.instance
        .reference()
        .child('st_chat')
        .orderByKey()
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        _curList = [];
        for (var val in snapshot.value.values) {
          _curList.add(val['text'].toString());
        }
        _isLoading = false;
      });
      // _curMessages =
      // print(snapshot.value.values.toString());
    });
  }

  Widget showMessageBar() {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      // controller: messageController,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        fillColor: Colors.blue,
        hintText: 'Type a message',
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
      onChanged: (val) {
        _message = val.trim();
      },
      onEditingComplete: () {
        print('Wanna send => ' + _message);
      },
    );
  }
}
