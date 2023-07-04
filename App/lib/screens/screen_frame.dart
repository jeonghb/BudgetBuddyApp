import 'package:flutter/material.dart';

import '../widgets/menu_drawer.dart';
import '../widgets/top_bar.dart';

class ScreenFrame extends StatefulWidget {
  final Widget body;
  final bool isAppBar;
  final bool isDrawer;
  final Color backgroundColor;
  final bool isAlarm;
  
  const ScreenFrame({
    super.key,
    this.isAppBar = true,
    this.isDrawer = true,
    required this.body,
    this.backgroundColor = Colors.white,
    this.isAlarm = false,
  });

  @override
  State<ScreenFrame> createState() => _ScreenFrame();
}

class _ScreenFrame extends State<ScreenFrame> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppBar ? TopBar(type: BarType.login, alarm: widget.isAlarm,) : null,
      endDrawer: widget.isDrawer ? MenuDrawer() : null,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => { FocusScope.of(context).unfocus()},
        child: widget.body,
      ),
    );
  }
}