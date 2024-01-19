import 'package:ecommerce_app/AB_New_project/text_style_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  const RoundButtonWidget({super.key, required this.text, required this.onTap});

  @override
  State<RoundButtonWidget> createState() => _RoundButtonWidgetState();
}

class _RoundButtonWidgetState extends State<RoundButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
          child: Center(child:Text(widget.text,style: textStyle17,),
        ),
        )
      ),
      onTap: widget.onTap,
    );
  }
}
