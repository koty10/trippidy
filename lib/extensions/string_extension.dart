import 'package:flutter/foundation.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return substring(0, 1).toUpperCase() + substring(1).toLowerCase();
  }

  String convertToImageProxy() {
    return kIsWeb ? 'https://trippidy.koten.dev:9680/external-img/?url=$this' : this;
  }
}
