import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Developer extends StatefulWidget {
  @override
  _DeveloperState createState() => _DeveloperState();
}

class _DeveloperState extends State<Developer> {
  TextEditingController messageController = TextEditingController();
  List<TextStyle> devstyles = [
    TextStyle(
      fontSize: 20,
      fontFamily: 'Metropolis',
      fontWeight: FontWeight.bold,
    ),
    TextStyle(
      fontSize: 14,
      fontFamily: 'Metropolis',
      // fontWeight: FontWeight.bold,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Know the developer'),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.amber[400], Colors.blue[200]],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Made with ', style: devstyles[0]),
                  Image(
                    image: AssetImage('assets/heart-64.png'),
                    width: 30,
                    height: 30,
                  ),
                  Text(' In Flutter', style: devstyles[0]),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              FlutterLogo(
                size: 100,
                colors: Colors.blue,
              ),
              SizedBox(height: 70),
              GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Something you didn\'t like?\nWant to message the developer?',
                    textAlign: TextAlign.center,
                    style: devstyles[1],
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      title: Text('Type a message here'),
                      titlePadding: EdgeInsets.all(20),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            height: 100,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  child: TextField(
                                    maxLines: 3,
                                    controller: messageController,
                                    decoration: InputDecoration(
                                      hintText: 'Your message',
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            print('Sorry, cool');
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        FlatButton(
                          onPressed: () async {
                            print('Sending your message boii');
                            await addToMessage(messageController.text.trim());
                            messageController.text = "";
                            Navigator.of(context).pop();
                          },
                          child: Text('Send'),
                        )
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          height: 25,
          width: double.infinity,
          child: Text(
            'All icon assets by icons8.com',
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          ),
        ),
        onTap: open,
      ),
    );
  }

  Future<void> addToMessage(String m) async {
    var ref = Firestore.instance;
    var doc = ref.collection('messages').document();
    try {
      doc.setData({'message': m});
      // return true;
    } catch (e) {
      print(e);
      // return false;
    }
  }

  void open() async {
    if (await canLaunch('https://icons8.com')) {
      await launch('https://icons8.com');
    }
  }
}
