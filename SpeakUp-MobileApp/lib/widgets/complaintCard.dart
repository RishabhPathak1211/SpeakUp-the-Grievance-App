import 'dart:io';
import 'package:flutter/material.dart';
import 'package:speak_up_beta/model/complaintModel.dart';

import '../network_handler.dart';

class ComplaintCard extends StatelessWidget {
  const ComplaintCard({Key key, this.complaintModel, this.networkHandler})
      : super(key: key);

  final ComplaintModel complaintModel;
  final NetworkHandler networkHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            bottom: 2,
            child: Container(
              padding: EdgeInsets.all(8),
              height: 55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Text(
                complaintModel.category,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
