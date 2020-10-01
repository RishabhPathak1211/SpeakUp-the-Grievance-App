import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'welcome_page.dart';
import '../widgets/resuable_card.dart';
import '../widgets/icons_generator.dart';
import 'complaint_input.dart';
import 'package:speak_up_beta/constants.dart';

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

  gotoComplaintInput(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ComplaintInput()),
    );
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
                      setState(() {
                        selectedCategory = Categories.history;
                      });
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
