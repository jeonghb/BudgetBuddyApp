import 'package:flutter/material.dart';

class Initialize extends StatelessWidget {
  const Initialize({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 90, 68, 223),
      body: Center(
        child: Text('SANDOL',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}