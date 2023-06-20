import 'package:flutter/material.dart';

class TextFormFieldV1 extends StatefulWidget {
  final autovalidateMode;
  final keyboardType;
  final controller;
  final textInputAction;
  final validator;
  final counterText;
  final suffixIcon;
  final maxLength;
  final onChanged;
  final labelText;
  final hintText;
  final hintStyle;
  final obscureText;

  TextFormFieldV1({
    Key? key,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.keyboardType,
    this.controller,
    this.textInputAction,
    this.validator,
    this.counterText,
    this.suffixIcon,
    this.maxLength,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.hintStyle,
    this.obscureText,
     }) : super(key: key,);

  @override
  State<TextFormFieldV1> createState() => _TextFormFieldV1();
}

class _TextFormFieldV1 extends State<TextFormFieldV1> {

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_handleTextChanged);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleTextChanged);
    super.dispose();
  }

  void _handleTextChanged() {
    widget.onChanged?.call(widget.controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.grey)
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red)
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.red)
        ),
        labelText: widget.labelText,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        counterText: widget.counterText,
        suffixIcon: widget.suffixIcon ?? IconButton(icon: Icon(Icons.clear), onPressed: () => widget.controller.clear(),),
        filled: true,
        fillColor: Colors.white,
      ),
      obscureText: widget.obscureText ?? false,
      autofocus: true,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      validator: (value) { return widget.validator!(value);},
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
    );
  }
}