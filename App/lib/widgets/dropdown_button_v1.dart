import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownButtonV1 extends StatefulWidget {
  final List<DropdownMenuItem<dynamic>> items;
  final Function(dynamic) onChanged;
  final dynamic value;
  final bool isExpanded;

  DropdownButtonV1({
    Key? key,
    required this.items,
    required this.onChanged,
    required this.value,
    this.isExpanded = true,
  }) : super(key: key,);

  @override
  State<DropdownButtonV1> createState() => _DropdownButtonV1();
}

class _DropdownButtonV1 extends State<DropdownButtonV1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey),
      ),
      child : DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: widget.isExpanded,
          value: widget.value,
          items: widget.items,
          onChanged: widget.onChanged,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}