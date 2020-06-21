import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Developer extends StatefulWidget {
  @override
  _DeveloperState createState() => _DeveloperState();
}

class _DeveloperState extends State<Developer> {
  List<TextStyle> devstyles = [TextStyle(fontSize: 16)];

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
            // alignment: WrapAlignment.center,
            // runSpacing: 20,
            // direction: Axis.horizontal,
            children: <Widget>[
              Text('Developed by Sanket Sahasrabudhe\n', style: devstyles[0]),
              Text('Batch of 2015\n\n', style: devstyles[0]),
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
            ],
          ),
        ),
      ),
      bottomSheet: GestureDetector(
        child: Container(
          alignment: Alignment.center,
          height: 20,
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

  open() async {
    if (await canLaunch('https://icons8.com')) {
      launch('https://icons8.com');
    }
  }
}
