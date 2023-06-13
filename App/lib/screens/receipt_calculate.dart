import 'package:flutter/material.dart';

class ReceiptRequest extends StatefulWidget {

  const ReceiptRequest({super.key});

  @override
  State<ReceiptRequest> createState() => _ReceiptRequest();
}

class _ReceiptRequest extends State<ReceiptRequest> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => { FocusScope.of(context).unfocus()},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('SANDOL',
            style: TextStyle(
              color: Color.fromARGB(255, 90, 68, 223),
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                ]
              )
            )
          )
        )
      )
    );
  }
}