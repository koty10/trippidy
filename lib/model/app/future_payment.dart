import 'package:trippidy/model/member.dart';

class FuturePayment {
  final Member payer;
  final Member payee;
  final double amount;

  FuturePayment(this.payer, this.payee, this.amount);
}
