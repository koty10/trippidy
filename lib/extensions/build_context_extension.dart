import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }

  TextTheme get txtTheme {
    return Theme.of(this).textTheme;
  }

  Size get screenSize {
    return MediaQuery.of(this).size;
  }
}
