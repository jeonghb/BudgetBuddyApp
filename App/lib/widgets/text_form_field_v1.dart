import 'package:flutter/material.dart';

class TextFormFieldV1 extends StatefulWidget {
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final validator;
  final String? counterText;
  final Widget? suffixIcon;
  final int? maxLength;
  final onChanged;
  final String? hintText;
  final TextStyle? hintStyle;
  final bool? obscureText;
  final VoidCallback? onEditingComplete;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final bool? autofocus;
  final int? maxLines;

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
    this.hintText,
    this.hintStyle,
    this.obscureText,
    this.onEditingComplete,
    this.prefixIcon,
    this.textAlign = TextAlign.left,
    this.autofocus = false,
    this.maxLines = 1,
     }) : super(key: key,);

  @override
  State<TextFormFieldV1> createState() => _TextFormFieldV1();
}

class _TextFormFieldV1 extends State<TextFormFieldV1> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_handleTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTextChanged() {
    widget.onChanged?.call(widget.controller?.text);
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
          borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
        ),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        counterText: widget.counterText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon ?? IconButton(icon: Icon(Icons.clear), onPressed: () => widget.controller?.clear(),),
        filled: true,
        fillColor: Colors.white,
      ),
      textAlign: widget.textAlign ?? TextAlign.center,
      obscureText: widget.obscureText ?? false,
      autofocus: widget.autofocus ?? false,
      autovalidateMode: widget.autovalidateMode,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      validator: (value) { return widget.validator!(value);},
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      maxLines: widget.maxLines,
    );
  }
}