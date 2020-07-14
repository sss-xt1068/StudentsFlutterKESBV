import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App settings'),
        backgroundColor: Colors.grey[600],
      ),
      backgroundColor: Colors.grey[400],
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.amber[100],
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
                leading: Icon(Icons.brightness_3),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
