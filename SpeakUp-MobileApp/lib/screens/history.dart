import 'package:flutter/material.dart';
import 'package:speak_up_beta/constants.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerColor,
        title: Text(
          'History',
          style: TextStyle(color: widgetColour, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 50,
            color: containerColor,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '27/09/2020',
                    style: historyStyle,
                  ),
                  Text('Canteen', style: historyStyle),
                  Text('Solved', style: historyStyle),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 50,
            color: containerColor,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '28/09/2020',
                    style: historyStyle,
                  ),
                  Text('Hostel', style: historyStyle),
                  Text('Solved', style: historyStyle),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 50,
            color: containerColor,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '28/09/2020',
                    style: historyStyle,
                  ),
                  Text('Academic', style: historyStyle),
                  Text('Seen', style: historyStyle),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: 50,
            color: containerColor,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '28/09/2020',
                    style: historyStyle,
                  ),
                  Text('Academic', style: historyStyle),
                  Text('Unseen', style: historyStyle),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 280.0,
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
