import 'package:flutter/material.dart';

class Department with ChangeNotifier {
  int departmentId = -1;
  String departmentName = '';
  bool activationStatus = true;

  void setData(var json) {
    departmentId = int.parse(json['departmentId']);
    departmentName = json['departmentName'];
    activationStatus = json['activationStatus'] == 1 ? true : false;
  }
}