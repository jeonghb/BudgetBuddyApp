import 'package:flutter/material.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final BarType type;

  const TopBar({super.key, required this.type});

  @override
  State<TopBar> createState() => _TopBar();
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TopBar extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    Widget actionIcon;

    switch (widget.type) {
      case BarType.login:
        actionIcon = IconButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: Colors.black
          ),
        );
        break;
      case BarType.logout:
        actionIcon = IconButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
          icon: Icon(
            Icons.close,
            color: Colors.black
          ),
        );
        break;
      default:
        actionIcon = Container();
    }

    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text('SANDOL',
        style: TextStyle(
          color: Color.fromARGB(255, 90, 68, 223),
          fontWeight: FontWeight.bold
        ),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black
        ),
      ),
      actions: [
        actionIcon
      ],
    );
  }
}

enum BarType {
  login,
  logout,
}