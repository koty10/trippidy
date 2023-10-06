import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/extensions/trip_extension.dart';
import 'package:trippidy/model/trip.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/screens/trip/components/completed_transaction_list_tile.dart';
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

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text("${currentTrip.name} - platby"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentTrip.completedTransactions.isNotEmpty)
              Text(
                "Provedené platby",
                style: context.txtTheme.bodyLarge,
              ),
            if (currentTrip.completedTransactions.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 16, bottom: 24),
                child: Row(
                  //direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    currentTrip.completedTransactions.length,
                    (index) => CompletedTransactionListTile(completedTransaction: currentTrip.completedTransactions[index]),
                  ),
                ),
              ),
            if (futurePayments.isNotEmpty)
              Text(
                "Zbývající platby",
                style: context.txtTheme.bodyLarge,
              ),
            futurePayments.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 16),
                      itemCount: futurePayments.length,
                      itemBuilder: (BuildContext context, int index) {
                        var curFuturePayment = futurePayments[index];
                        return PaymentListTile(
                          futurePayment: curFuturePayment,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 24),
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
      ),
    );
  }
}
