import 'package:flutter/material.dart';
import 'package:speak_up_beta/screens/home_page.dart';
import 'screens/welcome_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() => runApp(SpeakUp());

class SpeakUp extends StatefulWidget {
  @override
  _SpeakUpState createState() => _SpeakUpState();
}

class _SpeakUpState extends State<SpeakUp> {
  Widget page = WelcomePage();
  final storage = FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String token = await storage.read(key: "token");
    if (token != null) {
      setState(() {
        page = HomePage();
      });
    } else {
      setState(() {
        page = WelcomePage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: page,
    );
  }
}
