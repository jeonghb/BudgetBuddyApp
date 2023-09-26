import 'package:flutter/material.dart';

class TitleText extends StatefulWidget {
  final String text;

  TitleText({
    Key? key,
    required this.text,
  }) : super(key: key,);

  @override
  State<TitleText> createState() => _TitleText();
}

class _TitleText extends State<TitleText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.text,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}