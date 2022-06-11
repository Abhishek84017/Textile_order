import 'dart:math';

import 'package:intl/intl.dart';

/// extension for number (double/int)
extension DoubleExtension on num {
  /// method to convert number in indian place value format
  String toINR([int fractionDigit = 2]) {
    if (this == 0) {
      return '0';
    }
    String fraction = '';
    for (int i = 0; i < fractionDigit; i++) {
      fraction += '0';
    }
    final toINR = NumberFormat("#,##0.$fraction", "en_US");
    return toINR.format(this);
  }
}

/// int extensions
extension RandomInt on int {
  static int generate({int min = 1000, int max = 9999}) {
    final _random = Random();
    return min + _random.nextInt(max - min);
  }
}
