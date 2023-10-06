import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/model/app/future_payment.dart';
import 'package:trippidy/screens/trip/trip_payment_detail_screen.dart';

class PaymentListTile extends ConsumerWidget {
  const PaymentListTile({super.key, required this.futurePayment});

  final FuturePayment futurePayment;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TripPaymentDetailScreen(futurePayment: futurePayment),
            ),
          );
        },
        child: Row(
          children: [
            Container(
              width: 90,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: Text("${futurePayment.payer.userProfileFirstname} ${futurePayment.payer.userProfileLastname}"),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${futurePayment.amount.toInt()} Kč"),
                  const Icon(
                    Icons.trending_flat,
                    size: 32,
                  ),
                ],
              ),
            ),
            Container(
              width: 90,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: Text("${futurePayment.payee.userProfileFirstname} ${futurePayment.payee.userProfileLastname}"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
