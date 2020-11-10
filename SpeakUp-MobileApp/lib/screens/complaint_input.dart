import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:speak_up_beta/constants.dart';
import 'package:speak_up_beta/network_handler.dart';
import 'package:speak_up_beta/widgets/complaint_brain.dart';

class ComplaintInput extends StatefulWidget {
  @override
  _ComplaintInputState createState() => _ComplaintInputState();
}

class _ComplaintInputState extends State<ComplaintInput> {
  String _dropDownValue;
  bool circular = false;
  String subjectValue;
  String complaintValue;
  final mySubjectController = TextEditingController();
  final myComplaintController = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();

  sendComplaint() async {
    if (mySubjectController.text != null && myComplaintController != null) {
      Map<String, String> data = {
        "name": "Glen Dsouza",
        "email": "e19cse049@bennett.edu.in",
        "dept": "CSE",
        "year": "2019-23",
        "institution": "Bennett University",
        "subject": mySubjectController.text,
        "body": myComplaintController.text,
        "category": "",
        "status": "false"
      };
      print(data);
      await networkHandler.post("/complaint/add", data);
    }
  }

  @override
  void dispose() {
    myComplaintController.dispose();
    mySubjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Compose',
              style: TextStyle(
                color: widgetColour,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: mySubjectController,
                style: TextStyle(
                  fontSize: 18.0,
                  color: containerColor,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 18.0,
                    color: containerColor,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                  hintText: 'Subject',
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: DropdownButton(
                hint: _dropDownValue == null
                    ? Text(
                        'Type of Complaint',
                        style: TextStyle(
                          color: containerColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        _dropDownValue,
                        style: TextStyle(
                          color: containerColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: TextStyle(color: containerColor),
                items: ['Personal', 'Petition'].map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setState(
                    () {
                      _dropDownValue = val;
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: myComplaintController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 18.0,
                    color: containerColor,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                  hintText: 'Write your complaint here',
                ),
              ),
            ),
            SizedBox(
              height: 280.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: null,
                  child: Container(
                    width: 180.0,
                    padding: EdgeInsets.symmetric(vertical: 13),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Color(0xFFF3B340), width: 2),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF3B340)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: sendComplaint,
                  child: Container(
                    width: 180.0,
                    padding: EdgeInsets.symmetric(vertical: 13),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Color(0xFFF3B340), width: 2),
                    ),
                    child: Text(
                      'Send',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF3B340)),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: containerColor,
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: bottomBarHeight,
            ),
          ],
        ),
      ),
    );
  }
}
