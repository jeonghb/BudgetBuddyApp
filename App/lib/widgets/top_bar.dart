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
    Widget leadingIcon;

    switch (widget.type) {
      case BarType.main:
        actionIcon = IconButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: Icon(
            Icons.menu,
            color: Colors.black
          ),
        );
        leadingIcon = IconButton(
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationList()),);
          },
          icon: Icon(
            Icons.notifications_none,
            color: Colors.black,
          )
        );
        break;
      case BarType.exit:
        actionIcon = IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.settings.name == '/Home');
          },
          icon: Icon(
            Icons.close,
            color: Colors.black
          ),
        );
        leadingIcon = IconButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black
          ),
        );
        break;
      default:
        actionIcon = Container();
        leadingIcon = Container();
    }

    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text('BudgetBuddy',
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
  main,
  exit,
  invisible,
}