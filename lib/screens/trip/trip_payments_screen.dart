import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trippidy/extensions/trip_extension.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/screens/trip/components/payment_list_tile.dart';
import 'package:lottie/lottie.dart';

import '../../../providers/trip_detail_controller.dart';

class TripPaymentsScreen extends ConsumerWidget {
  const TripPaymentsScreen({super.key});

  static const routeName = '/tripPaymentsScreen';

  @override
  Widget build(BuildContext context, ref) {
    Trip currentTrip = ref.watch(tripDetailControllerProvider);
    var futurePayments = currentTrip.getFuturePayments();
    var format = DateFormat("dd.MM.yyyy");

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - platby"),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          futurePayments.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: futurePayments.length,
                    itemBuilder: (BuildContext context, int index) {
                      var curFuturePayment = futurePayments[index];
                      return PaymentListTile(
                        futurePayment: curFuturePayment,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16),
                  ),
                )
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                        'assets/lotties/empty_box.json',
                        height: 200,
                      ),
                      const SizedBox(height: 20),
                      const Center(child: Text('Nikdo zatím nikomu nedluží.')),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
