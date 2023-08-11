import 'package:flutter/material.dart';
import 'package:test/app_core.dart';

class BudgetYear {
  int departmentId = -1;
  int year = -1;
  TextEditingController budgetAmount = TextEditingController();

  void setData(var json) {
    departmentId = AppCore.getJsonInt(json, 'departmentId');
    year = AppCore.getJsonInt(json, 'year');
    budgetAmount.text = AppCore.getJsonString(json, 'budgetAmount');
  }
}