import 'package:flutter/material.dart';
import 'package:speak_up_beta/network_handler.dart';
import 'package:speak_up_beta/screens/home_page.dart';
import 'package:speak_up_beta/screens/login_page.dart';

const widgetColour = Color(0xFF111328);
const bottomBarHeight = 40.0;
const containerColor = Color(0xFFF3B340);

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // AuthMethods authMethods = new AuthMethods();

  final formKey = GlobalKey<FormState>();
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController userName = new TextEditingController();
  TextEditingController rollNo = new TextEditingController();
  TextEditingController year = new TextEditingController();
  TextEditingController dept = new TextEditingController();
  TextEditingController emailID = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController passwordConfirm = new TextEditingController();

  String errorText;
  bool validate = true;
  bool circular = false;

  signMeUp() async {
    if (formKey.currentState.validate() &&
        password.text == passwordConfirm.text &&
        validate) {
      Map<String, String> data = {
        "username": userName.text,
        "rollNo": rollNo.text,
        "email": emailID.text,
        "year": year.text,
        "dept": dept.text,
        "password": password.text
      };
      print(data);
      await networkHandler.post("/user/register", data);
      setState(() {
        circular = false;
      });
    } else {
      setState(() {
        circular = false;
      });
    }
  }

  checkUser() async {
    if (emailID.text.length == 0) {
      setState(() {
        circular = false;
        validate = false;
        errorText = "Email cannot be empty";
      });
    } else {
      var response =
          await networkHandler.get("/user/checkemail/${emailID.text}");
      if (response["Status"]) {
        setState(() {
          circular = false;
          validate = false;
          errorText = "Email already exists";
        });
      } else {
        setState(() {
          circular = false;
          validate = true;
        });
      }
    }
  }

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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    validator: (val) {
                      return val.length <= 5 ? "Enter Full Name" : null;
                    },
                    controller: userName,
                    style: TextStyle(color: containerColor),
                    decoration: InputDecoration(
                      hintText: "Full Name",
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
                  TextFormField(
                    validator: (val) {
                      return val.length != 9 ? "Invalid RollNo" : null;
                    },
                    controller: rollNo,
                    style: TextStyle(color: containerColor),
                    decoration: InputDecoration(
                      hintText: "RollNo",
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
                  TextFormField(
                    controller: emailID,
                    style: TextStyle(color: containerColor),
                    decoration: InputDecoration(
                      errorText: validate ? null : "Email already exists",
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
                  TextFormField(
                    validator: (val) {
                      return val.length != 7 ? "Invalid year format" : null;
                    },
                    controller: year,
                    style: TextStyle(color: containerColor),
                    decoration: InputDecoration(
                      hintText: "Year",
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
                  TextFormField(
                    validator: (val) {
                      return val.length < 3 ? "Invalid Dept format" : null;
                    },
                    controller: dept,
                    style: TextStyle(color: containerColor),
                    decoration: InputDecoration(
                      hintText: "Department",
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
                  TextFormField(
                    validator: (val) {
                      return val.isEmpty || val.length < 6
                          ? "Password is weak"
                          : null;
                    },
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
                  TextFormField(
                    validator: (val) {
                      return password.text != passwordConfirm.text
                          ? "Password does not match"
                          : null;
                    },
                    controller: passwordConfirm,
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: circular
                        ? CircularProgressIndicator()
                        : Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Set up Touch ID?",
                              style: TextStyle(
                                color: containerColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        circular = true;
                      });
                      await checkUser();
                      signMeUp();
                      if (circular == false && validate == true) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                            (route) => false);
                      }
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          "Log In Now",
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
    );
  }
}
