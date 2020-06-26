import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatForum extends StatefulWidget {
  @override
  _ChatForumState createState() => _ChatForumState();
}

class _ChatForumState extends State<ChatForum>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  FirebaseDatabase mFirebaseDatabase;
  DatabaseReference mMessDatabaseReference;
  String st1 = 'This is still a pre-release app. ';
  String st2 = 'This chat forum is not yet fully managed or supervised. ';
  String st3 = 'So please do not use vulgar or swearing words. ';
  String st4 =
      'In case any such behaviour is found, I may directly remove access to your account. Thank you.';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // showDialog(
    //   context: context,
    //   child: AlertDialog(
    //     title: Text('Humble request'),
    //     content: Text(st1 + st2 + st3 + st4),
    //     actions: <Widget>[
    //       FlatButton(
    //         onPressed: () {
    //           Navigator.of(context).pop();
    //         },
    //         child: Text('Got it'),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // void addToDatabase() {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   if (_message != '') {
  //     print(_message);
  //     mFirebaseDatabase = FirebaseDatabase.instance;
  //     mMessDatabaseReference = mFirebaseDatabase.reference().child('st_chat');
  //     mMessDatabaseReference.push().set({
  //       'text': _message,
  //     });
  //     print('Supposedly added to database!');
  //     setState(() {
  //       _message = '';
  //       messageController.text = '';
  //     });
  //     printItems();
  //   }
  // }

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
      body: Stack(
        children: <Widget>[
          showApp(),
          showCircularProgress(),
        ],
      ),
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
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text('Chat Forum'),
          // leading: Icon(
          //   Icons.message,
          //   size: 26,
          // ),
          
          actions: <Widget>[],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            // Container(
            //   height: 600,
            //   child: ListView(
            //     children: <Widget>[
            //       Container(
            //         height: 400,
            //         margin: EdgeInsets.all(10),
            //         child: Center(
            //           child: ListView.builder(
            //             itemCount: _curList.length,
            //             itemBuilder: (context, index) =>
            //                 showList(context, _curList[index]),
            //           ),
            //         ),
            //       ),
            //       Container(
            //         color: Colors.amber[100],
            //         margin: EdgeInsets.only(left: 40, right: 40),
            //         child: TextField(
            //           textCapitalization: TextCapitalization.sentences,
            //           controller: messageController,
            //           textAlign: TextAlign.center,
            //           decoration: InputDecoration(
            //             fillColor: Colors.blue,
            //             hintText: 'Type a message',
            //             focusedBorder: InputBorder.none,
            //             enabledBorder: InputBorder.none,
            //           ),
            //           onChanged: (val) {
            //             _message = val.trim();
            //             // print(_message);
            //           },
            //           onEditingComplete: () {
            //             print(_message);
            //           },
            //         ),
            //       ),
            //       MaterialButton(
            //         child: Icon(
            //           Icons.send,
            //           size: 30,
            //           color: Colors.deepOrange,
            //         ),
            //         onPressed: addToDatabase,
            //       ),
            //       FlatButton(
            //         textColor: Colors.black,
            //         color: Colors.lightBlue,
            //         onPressed: printItems,
            //         child: Text('Read Data'),
            //       )
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top:158.0),
              child: Center(
                child: Text(
                  'Chat forum feature not available yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
            ),
          ]),
        )
      ],
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
}
