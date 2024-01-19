import 'package:flutter/material.dart';

import '../../../Custom_widget/text_style_widget.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  const TextFormFieldWidget({super.key, required this.hintText, required this.controller});

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape:  const OutlineInputBorder(borderSide: BorderSide(color:Colors.black54 )),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: TextFormField(
          controller: widget.controller,
          style: textStyle17,
          decoration:  InputDecoration(
              hintText:widget.hintText,
              border: InputBorder.none
          ),
        ),
      ),
    );
  }
}
