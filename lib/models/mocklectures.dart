import 'package:flutter/material.dart';

class Lectures extends StatefulWidget {

  @override
  _LecturesState createState() => _LecturesState();
}

int studentStandard;

class _LecturesState extends State<Lectures> {
 
  @override
  void initState() {
    super.initState();
    // findMyStandard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduled live lectures'),
      ),
      body: Center(
        child: Text(
          'Live lectures scheduling not available yet',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Comfortaa',
          ),
        ),
      ),
    );
  }
}
