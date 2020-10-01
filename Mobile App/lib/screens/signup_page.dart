import 'package:flutter/material.dart';
import 'home_page.dart';

const widgetColour = Color(0xFF111328);
const bottomBarHeight = 40.0;
const containerColor = Color(0xFFF3B340);

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullName = new TextEditingController();
  TextEditingController collegeName = new TextEditingController();
  TextEditingController rollNo = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerColor,
        title: Text(
          'SpeakUp The Grievance App',
          style: TextStyle(color: widgetColour, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 35.0),
            child: Column(
              children: [
                SizedBox(
                  height: 80.0,
                ),
                TextField(
                  controller: fullName,
                  style: TextStyle(color: containerColor),
                  decoration: InputDecoration(
                    hintText: "College Email ID",
                    hintStyle: TextStyle(
                      color: containerColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: containerColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextField(
                  controller: password,
                  obscureText: true,
                  style: TextStyle(color: containerColor),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: containerColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: containerColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextField(
                  obscureText: true,
                  style: TextStyle(color: containerColor),
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(
                      color: containerColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: containerColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Set up Touch ID?",
                    style: TextStyle(
                      color: containerColor,
                      fontSize: 13,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 13),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Color(0xFFF3B340), width: 2),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF3B340)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?  ",
                      style: TextStyle(
                        color: containerColor,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "Log In Now",
                      style: TextStyle(
                        color: containerColor,
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
