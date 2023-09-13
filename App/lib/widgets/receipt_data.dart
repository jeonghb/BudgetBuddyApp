import 'package:flutter/material.dart';

class ReceiptData extends StatefulWidget {
  final String title;
  final String data;

  ReceiptData({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key,);

  @override
  State<ReceiptData> createState() => _ReceiptData();
}

class _ReceiptData extends State<ReceiptData> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(widget.title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black38,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            widget.data,
            style: TextStyle(
              fontSize: 20
            ),
          ),
        ),
      ],
    );
  }
}