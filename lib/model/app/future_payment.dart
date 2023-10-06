import 'package:decimal/decimal.dart';
import 'package:trippidy/model/member.dart';

class FuturePayment {
  final Member payer;
  final Member payee;
  final Decimal amount;

  FuturePayment(this.payer, this.payee, this.amount);
}
