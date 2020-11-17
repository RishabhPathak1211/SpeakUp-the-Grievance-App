import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import '../network_handler.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  var response;
  NetworkHandler networkHandler = NetworkHandler();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    response = await networkHandler.get('/user/getData');
    response = response['data'];
    print(response['username']);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      routes: {
        "/": (_) => WebviewScaffold(
              url: "http://54a949ac4333.ngrok.io/home/student",
              appBar: AppBar(
                title: Text("Chat Window"),
              ),
            ),
      },
    );
  }
}
