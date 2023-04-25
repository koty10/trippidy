import 'package:flutter/material.dart';

extension PaddingX on int {
  SizedBox get tall {
    return SizedBox(height: toDouble());
  }

  SizedBox get wide {
    return SizedBox(width: toDouble());
  }
}
