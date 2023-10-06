import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/model/app/future_payment.dart';
import 'package:trippidy/screens/trip/trip_payment_detail_screen.dart';

class PaymentListTile extends ConsumerWidget {
  const PaymentListTile({super.key, required this.futurePayment});

  final FuturePayment futurePayment;

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripPaymentDetailScreen(futurePayment: futurePayment),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.colorScheme.secondaryContainer,
        ),
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: futurePayment.payer.userProfileImage == null
                        ? const AssetImage("images/user.png") as ImageProvider
                        : NetworkImage(futurePayment.payer.userProfileImage!),
                    radius: 16,
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      "${futurePayment.payer.userProfileFirstname} ${futurePayment.payer.userProfileLastname}",
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text("${futurePayment.amount.round()} Kč"),
                      ),
                      const Icon(
                        Icons.trending_flat,
                        size: 32,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      "${futurePayment.payee.userProfileFirstname} ${futurePayment.payee.userProfileLastname}",
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundImage: futurePayment.payee.userProfileImage == null
                        ? const AssetImage("images/user.png") as ImageProvider
                        : NetworkImage(futurePayment.payee.userProfileImage!),
                    radius: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
