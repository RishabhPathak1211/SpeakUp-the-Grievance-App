import 'package:flutter/material.dart';
import 'package:speak_up_beta/constants.dart';

import '../network_handler.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  var response;
  String seenStatus;
  List users = [];
  NetworkHandler networkHandler = NetworkHandler();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    response = await networkHandler.get('/complaint/getComplaints');
    response = response['data'];
    print(response);
    setState(() {
      users = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerColor,
        title: Text(
          'History',
          style: TextStyle(color: widgetColour, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Card(
                elevation: 5,
                child: Container(
                  width: width,
                  height: 60,
                  color: containerColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        users[index]['date'].toString().substring(0, 10),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widgetColour,
                        ),
                      ),
                      Text(
                        users[index]['category'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widgetColour,
                        ),
                      ),
                      Text(
                        users[index]['status'] ? "Seen" : "Not seen",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widgetColour,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
