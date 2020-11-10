import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:speak_up_beta/screens/welcome_page.dart';
import '../widgets/resuable_card.dart';
import '../widgets/icons_generator.dart';
import 'complaint_input.dart';
import 'package:speak_up_beta/constants.dart';
import 'history.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum Categories {
  complaint,
  history,
  petition,
  message,
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Categories selectedCategory;
  final storage = FlutterSecureStorage();

  gotoComplaintInput(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ComplaintInput()),
    );
  }

  gotoHistory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => History()),
    );
  }

  void logMeOut() async {
    await storage.delete(key: "token");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Username",
                    style: TextStyle(
                        color: containerColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(
                    color: containerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              trailing: Icon(
                FontAwesomeIcons.user,
                color: containerColor,
              ),
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => MainProfile()),
              //   );
              // },
            ),
            ListTile(
              title: Text(
                'Settings',
                style: TextStyle(
                    color: containerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              trailing: Icon(
                FontAwesomeIcons.wrench,
                color: containerColor,
              ),
            ),
            ListTile(
              title: Text(
                'Log Out',
                style: TextStyle(
                    color: containerColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
              trailing: Icon(
                FontAwesomeIcons.signOutAlt,
                color: containerColor,
              ),
              onTap: logMeOut,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: containerColor,
        title: Text(
          'SpeakUp The Grievance App',
          style: TextStyle(
            color: widgetColour,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      gotoComplaintInput(context);
                    },
                    child: ReusableCard(
                      colour: widgetColour,
                      cardChild: IconsGenerator(
                        iconGender: FontAwesomeIcons.userEdit,
                        category: 'Complaint',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      gotoHistory(context);
                    },
                    child: ReusableCard(
                      colour: widgetColour,
                      cardChild: IconsGenerator(
                        iconGender: FontAwesomeIcons.history,
                        category: 'History',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = Categories.petition;
                      });
                    },
                    child: ReusableCard(
                      colour: widgetColour,
                      cardChild: IconsGenerator(
                        iconGender: FontAwesomeIcons.penNib,
                        category: 'Petition',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = Categories.message;
                      });
                    },
                    child: ReusableCard(
                      colour: widgetColour,
                      cardChild: IconsGenerator(
                        iconGender: FontAwesomeIcons.comments,
                        category: 'Message',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: containerColor,
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            height: bottomBarHeight,
          ),
        ],
      ),
    );
  }
}
