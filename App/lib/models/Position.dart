import 'package:flutter/material.dart';

class Position with ChangeNotifier {
  int departmentId = -1;
  int positionId = -1;
  String positionName = '';
  int authFlag = 0;
  bool activationStatus = true;

  void setData(var json) {
    positionId = int.parse(json['positionId']);
    positionName = json['positionName'];
    activationStatus = json['activationStatus'] == 1 ? true : false;
  }
}