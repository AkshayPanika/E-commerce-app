

import 'package:flutter/material.dart';

TextStyle textStyle17 = const TextStyle(color: Colors.black,fontSize: 17);
TextStyle textStyle15 = const TextStyle(color: Colors.black, fontSize: 15);



extension SizeBox on num{
  SizedBox get height => SizedBox(height: toDouble(),);
  SizedBox get width => SizedBox(width: toDouble(),);
}