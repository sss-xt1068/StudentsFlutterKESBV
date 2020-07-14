import 'package:flutter/material.dart';
import './services/authentication.dart';
import './pages/root_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'KESBV Students',
      debugShowCheckedModeBanner: true,
      theme: new ThemeData(
        primarySwatch: Colors.red,
        iconTheme: IconThemeData(
          color: Colors.black87,
          size: 30,
        ),
      ),
      home: new RootPage(
        auth: new Auth(),
      ),
    );
  }
}
