import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/model/app/future_payment.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';

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
        title: Text("${currentTrip.name} - detail platby ${futurePayment.payee.userProfileFirstname}"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          QrImageView(
            data: '1234567890',
            version: QrVersions.auto,
            size: 200.0,
          ),
        ],
      ),
    );
  }
}
