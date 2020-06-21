import 'package:flutter/material.dart';

class Assignments extends StatefulWidget {
  final String gr;
  Assignments({@required this.gr});

  @override
  _AssignmentsState createState() => _AssignmentsState(gr: gr);
}

int studentStandard;

class _AssignmentsState extends State<Assignments> {
  String gr;
  _AssignmentsState({@required this.gr});
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
        child: Text('Live lectures here'),
      ),
    );
  }
}
