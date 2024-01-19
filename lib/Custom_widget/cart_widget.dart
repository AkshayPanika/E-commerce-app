

import 'dart:ffi';

import 'package:flutter/material.dart';

class CardWidgetWithPadding extends StatelessWidget {
  final Widget child;
  final double padding;
  const CardWidgetWithPadding({super.key, required this.child, required this.padding});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
      child: Padding(padding:  EdgeInsets.all(padding),
      child: child,),
    );
  }
}

class CardWidget extends StatelessWidget {
  final Widget child;
  const CardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
      child: child,
    );
  }
}
