import 'package:flutter/material.dart';

class Size {
  SizeType getSizeType(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 1000) {
      return SizeType.fullWindow;
    } else {
      return SizeType.halfWindow;
    }
  }
}

enum SizeType { fullWindow, halfWindow }
