import 'package:flutter/material.dart';

class IconsGenerator extends StatelessWidget {
  final IconData iconGender;
  final String category;
  IconsGenerator({@required this.iconGender, @required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconGender,
          size: 80.0,
          color: Color(0xFFF3B340),
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          category,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Color(0xFFF3B340),
          ),
        )
      ],
    );
  }
}
