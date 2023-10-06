import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/model/app/future_payment.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/providers/auth_controller.dart';

import '../../../providers/trip_detail_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TripPaymentDetailScreen extends ConsumerWidget {
  const TripPaymentDetailScreen({super.key, required this.futurePayment});

  final FuturePayment futurePayment;
  static const routeName = '/tripPaymentDetailScreen';

  @override
  Widget build(BuildContext context, ref) {
    Trip currentTrip = ref.watch(tripDetailControllerProvider);
    // var futurePayments = currentTrip.getFuturePayments();
    // var format = DateFormat("dd.MM.yyyy");

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - detail platby"),
      ),
      body: Column(
        children: [
          Image.asset(
            "assets/images/future_payments.jpg",
            fit: BoxFit.cover,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Dlužník: ${futurePayment.payer.userProfileFirstname} ${futurePayment.payer.userProfileLastname}"),
                    Text("Příjemce: ${futurePayment.payee.userProfileFirstname} ${futurePayment.payee.userProfileLastname}"),
                    Text("Částka: ${futurePayment.amount} Kč"),
                    const SizedBox(height: 8),
                    QrImageView(
                      data: '1234567890',
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          if (futurePayment.payer.userProfileId == ref.read(authControllerProvider.notifier).getUserId())
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    foregroundColor: Colors.green,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Zaplatit",
                    style: TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    ref.read(tripDetailControllerProvider.notifier).addCompletedTransaction(futurePayment);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          const SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }
}
