import 'package:flutter/material.dart';

import '../widgets/menu_drawer.dart';
import '../widgets/top_bar.dart';

class ScreenFrame extends StatefulWidget {
  final Widget body;
  final bool isAppBar;
  final bool isDrawer;
  final Color backgroundColor;
  
  const ScreenFrame({
    super.key,
    this.isAppBar = true,
    this.isDrawer = true,
    required this.body,
    this.backgroundColor = Colors.white,
  });

  @override
  State<ScreenFrame> createState() => _ScreenFrame();
}

class _ScreenFrame extends State<ScreenFrame> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isAppBar ? TopBar(type: BarType.login) : null,
      endDrawer: widget.isDrawer ? MenuDrawer() : null,
      backgroundColor: widget.backgroundColor,
      body: GestureDetector(
        onTap: () => { FocusScope.of(context).unfocus()},
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: widget.body,
        )
      ),
    );
  }
}