import 'package:flutter/material.dart';
import 'package:speak_up_beta/model/profileModel.dart';
import '../constants.dart';
import '../network_handler.dart';

class MainProfile extends StatefulWidget {
  @override
  _MainProfileState createState() => _MainProfileState();
}

class _MainProfileState extends State<MainProfile> {
  bool circular = true;
  NetworkHandler networkHandler = NetworkHandler();
  ProfileModel profileModel = ProfileModel();
  @override
  void initState() {
    super.initState();

    fetchData();
  }

  void fetchData() async {
    var response = await networkHandler.get("/user/getData");
    setState(() {
      profileModel = ProfileModel.fromJson(response["data"]);
      circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: containerColor,
        title: Text(
          'Profile',
          style: TextStyle(color: widgetColour, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "Username",
                    style: TextStyle(
                      color: containerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: 20,
                  ),
                  child: Text(
                    profileModel.username,
                    style: TextStyle(
                      color: containerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "RollNo",
                    style: TextStyle(
                      color: containerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: 20,
                  ),
                  child: Text(
                    profileModel.rollNo,
                    style: TextStyle(
                      color: containerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "Email",
                    style: TextStyle(
                      color: containerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: 20,
                  ),
                  child: Text(
                    profileModel.email,
                    style: TextStyle(
                      color: containerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "Department",
                    style: TextStyle(
                      color: containerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: 20,
                  ),
                  child: Text(
                    profileModel.dept,
                    style: TextStyle(
                      color: containerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    "Year",
                    style: TextStyle(
                      color: containerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    right: 20,
                  ),
                  child: Text(
                    profileModel.year,
                    style: TextStyle(
                      color: containerColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
