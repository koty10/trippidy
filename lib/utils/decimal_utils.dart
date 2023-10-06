import 'package:decimal/decimal.dart';

Decimal minDecimal(Decimal a, Decimal b) {
  return a < b ? a : b;
}
