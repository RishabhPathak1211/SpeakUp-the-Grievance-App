import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:speak_up_beta/constants.dart';

class ComplaintInput extends StatefulWidget {
  @override
  _ComplaintInputState createState() => _ComplaintInputState();
}

class _ComplaintInputState extends State<ComplaintInput> {
  String _dropDownValue;

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
              style:
                  TextStyle(color: widgetColour, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 30.0,
            ),
            Container(
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.paperclip,
                    color: Colors.black54,
                    size: 25.0,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Icon(
                    FontAwesomeIcons.paperPlane,
                    color: Colors.black54,
                    size: 25.0,
                  ),
                ],
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
                style: TextStyle(
                  fontSize: 20.0,
                  color: containerColor,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: containerColor,
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
                          fontSize: 20.0,
                        ),
                      )
                    : Text(
                        _dropDownValue,
                        style: TextStyle(
                          color: containerColor,
                          fontSize: 20.0,
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
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(
                  fontSize: 20.0,
                  color: containerColor,
                ),
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 20.0,
                    color: containerColor,
                  ),
                  border: InputBorder.none,
                  hintText: 'Write your complaint here',
                ),
              ),
            ),
            SizedBox(
              height: 340.0,
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
