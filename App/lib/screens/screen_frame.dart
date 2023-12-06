import 'package:flutter/material.dart';
import 'package:test/app_core.dart';

import '../widgets/menu_drawer.dart';
import '../widgets/top_bar.dart';

class ScreenFrame extends StatefulWidget {
  final Widget body;
  final BarType appBarType;
  final bool isDrawer;
  final Color backgroundColor;
  final bool isAlarm;
  
  const ScreenFrame({
    super.key,
    this.appBarType = BarType.logout,
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
      appBar: widget.appBarType == BarType.invisible ? null : TopBar(type: widget.appBarType, alarm: widget.isAlarm,),
      endDrawer: widget.isDrawer ? MenuDrawer() : null,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: true,
      body : Stack(
        children: [
          GestureDetector(
            onTap: () => { FocusScope.of(context).unfocus()},
            child: widget.body,
          ),
          if (AppCore.isLoading)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      )
    );
  }
}