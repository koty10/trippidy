import 'package:flutter/material.dart';
import 'package:trippidy/screens/notifications/trip_offer/trip_offer_screen.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key, required this.offersCount});

  final int offersCount;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.only(right: 16),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TripOfferScreen(),
          ),
        );
      },
      icon: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.notifications),
          ),
          if (offersCount > 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 16,
                height: 16,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "$offersCount",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
