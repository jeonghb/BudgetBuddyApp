import 'package:flutter/material.dart';

import '../widgets/menu_drawer.dart';
import '../widgets/top_bar.dart';

class ScreenFrame extends StatefulWidget {
  final Widget body;

  const ScreenFrame({super.key, required this.body});

  @override
  State<ScreenFrame> createState() => _ScreenFrame();
}

class _ScreenFrame extends State<ScreenFrame> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => { FocusScope.of(context).unfocus()},
      child: SingleChildScrollView(
        child: Scaffold(
          appBar: TopBar(type: Type.login),
          endDrawer: MenuDrawer(),
          backgroundColor: Colors.white,
          body: widget.body,
        ),
      ),
    );
  }
}