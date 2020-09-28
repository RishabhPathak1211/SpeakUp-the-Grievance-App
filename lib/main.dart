import 'package:flutter/material.dart';
import 'screens/welcome_page.dart';

void main() => runApp(SpeakUp());

class SpeakUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: WelcomePage(),
    );
  }
}
