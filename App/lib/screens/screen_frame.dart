import 'package:flutter/material.dart';
import 'package:test/app_core.dart';

import '../widgets/bottom_bar.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/top_bar.dart';

class ScreenFrame extends StatefulWidget {
  final Widget body;
  final BarType appBarType;
  final Color backgroundColor;
  final bool bottomBar;
  
  const ScreenFrame({
    super.key,
    this.appBarType = BarType.exit,
    required this.body,
    this.backgroundColor = Colors.white,
    this.bottomBar = true,
  });

  @override
  State<ScreenFrame> createState() => _ScreenFrame();
}

class _ScreenFrame extends State<ScreenFrame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBarType == BarType.invisible ? null : TopBar(type: widget.appBarType,),
      endDrawer: widget.appBarType == BarType.main ? MenuDrawer() : null,
      backgroundColor: widget.backgroundColor,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: widget.bottomBar ? BottomBar() : null,
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