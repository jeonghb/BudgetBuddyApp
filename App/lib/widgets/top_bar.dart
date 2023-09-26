import 'package:flutter/material.dart';
import '../screens/alarm_list.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final BarType type;
  final bool alarm;

  const TopBar({super.key, required this.type, this.alarm = false});

  @override
  State<TopBar> createState() => _TopBar();
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TopBar extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    Widget actionIcon;
    Widget leadingIcon;

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

    if (widget.alarm) {
      leadingIcon = IconButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AlarmList()),);
        },
        icon: Icon(
          Icons.notifications_none,
          color: Colors.black,
        )
      );
    }
    else {
      leadingIcon = IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black
        ),
      );
    }

    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text('SANDOL',
        style: TextStyle(
          color: Color.fromARGB(255, 90, 68, 223),
          fontWeight: FontWeight.w900
        ),
      ),
      leading: leadingIcon,
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