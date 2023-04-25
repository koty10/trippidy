import 'package:flutter/material.dart';

extension WidgetPaddingX on Widget {
  Widget padding({
    double? all,
    double left = 0,
    double right = 0,
    double bottom = 0,
    double top = 0,
  }) {
    if (all != null) {
      return Padding(
        padding: EdgeInsets.all(all),
        child: this,
      );
    }
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: this,
    );
  }
}
