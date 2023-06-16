import 'package:flutter/material.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  State<TopBar> createState() => _TopBar();
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TopBar extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('SANDOL',
          style: TextStyle(
            color: Color.fromARGB(255, 90, 68, 223),
            fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
            icon: Icon(Icons.menu),
          ),
        ],
      ),
    );
  }
}