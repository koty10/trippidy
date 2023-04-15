import 'package:flutter/material.dart';
import 'package:trippidy/screens/notifications/trip_offer/trip_offer_screen.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TripOfferScreen(),
          ),
        );
      },
      child: const Icon(Icons.notifications),
    );
  }
}
