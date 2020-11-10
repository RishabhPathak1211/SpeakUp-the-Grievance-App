import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:speak_up_beta/screens/signup_page.dart';
import '../network_handler.dart';
import 'home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const widgetColour = Color(0xFF111328);
const bottomBarHeight = 40.0;
const containerColor = Color(0xFFF3B340);

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool vis = true;
  final globalkey = GlobalKey<FormState>();

  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController emailID = TextEditingController();
  TextEditingController password = TextEditingController();

  String errorText;
  bool validate = false;
  bool circular = false;
  final storage = new FlutterSecureStorage();

  logMeIn() async {
    Map<String, String> data = {
      "email": emailID.text,
      "password": password.text,
    };
    var response = await networkHandler.post("/user/login", data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> output = json.decode(response.body);
      storage.write(key: "token", value: output["token"]);
      print(output["token"]);
      setState(() {
        validate = true;
        circular = false;
      });
    } else {
      setState(() {
        validate = false;
        errorText = "Incorrect email/password combination";
        circular = false;
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
      home: Scaffold(
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
              child: Form(
                key: globalkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 80.0,
                    ),
                    TextField(
                      controller: emailID,
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
                        errorText: validate ? null : errorText,
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
                      height: 30.0,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: containerColor,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          circular = true;
                        });
                        await logMeIn();
                        if (circular == false && validate == true) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                              (route) => false);
                        }
                      },
                      child: circular
                          ? CircularProgressIndicator()
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(vertical: 13),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                border: Border.all(
                                    color: Color(0xFFF3B340), width: 2),
                              ),
                              child: Text(
                                'Login',
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
                          "Don't have an account?  ",
                          style: TextStyle(
                            color: containerColor,
                            fontSize: 13,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()),
                            );
                          },
                          child: Text(
                            "Register Now",
                            style: TextStyle(
                              color: containerColor,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                            ),
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
        ),
      ),
    );
  }
}
