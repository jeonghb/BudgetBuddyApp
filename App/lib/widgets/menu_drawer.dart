import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_core.dart';
import '../models/receipt.dart';
import '../screens/receipt_request.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawer();
}

class _MenuDrawer extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                // backgroundImage: AppCore.getInstance().getUser().image,
              ),
              accountName: Text(AppCore.getInstance().getUser().userName.text),
              accountEmail: Text(AppCore.getInstance().getUser().userEmail.text),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 90, 68, 223),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                )
              ),
            ),
            ListTile(
              leading: Icon(Icons.add_box_outlined),
              iconColor: Color.fromARGB(255, 90, 68, 223),
              focusColor: Color.fromARGB(255, 90, 68, 223),
              title: Text('영수증 제출',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptRequest(receipt: Receipt(),)),);
              },
            ),
          ],
        ),
      ),
    );
  }
}