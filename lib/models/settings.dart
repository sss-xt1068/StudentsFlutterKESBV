import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App settings'),
        backgroundColor: Colors.grey[600],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.touch_app),
            onPressed: () {
              setState(() {
                isTapped = !isTapped;
              });
            },
          )
        ],
      ),
      backgroundColor: Colors.grey[400],
      body: Container(
        child: ListView(
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: isTapped ? Colors.amber[100] : Colors.purple[200],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 3,
                    offset: Offset(2, 4),
                  )
                ],
              ),
              child: ListTile(
                title: Text(
                  'Settings will be available in a later release',
                  style: TextStyle(
                    fontFamily: 'Metropolis',
                  ),
                ),
                leading: Icon(
                  isTapped ? Icons.brightness_7 : Icons.brightness_3,
                ),
                onTap: () {
                  setState(() {
                    isTapped = !isTapped;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
