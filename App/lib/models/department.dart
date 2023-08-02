import 'package:flutter/material.dart';
import 'Position.dart';

class Department with ChangeNotifier {
  int departmentId = -1;
  String departmentName = '';
  bool activationStatus = true;
  List<Position> positionList = <Position>[];

  void setData(var json) {
    departmentId = int.parse(json['departmentId'].toString());
    departmentName = json['departmentName'];
    activationStatus = json['departmentActivationStatus'] == 1 ? true : false;
  }
}