import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/extensions/string_extension.dart';
import 'package:trippidy/providers/auth_controller.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';
import 'package:trippidy/screens/trip/trip_screen.dart';
import 'package:flutter/material.dart';

import '../../../model/dto/trip.dart';

class TripTile extends ConsumerWidget {
  const TripTile({super.key, required this.trip});

  final Trip trip;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var myItems = trip.members
        .firstWhere(
          (element) => element.userProfileId == ref.read(authControllerProvider).userProfile!.id,
        )
        .items;
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: context.colorScheme.onSecondary,
      title: Text(
        trip.name,
        style: context.txtTheme.titleMedium,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: trip.members
            .take(3)
            .toList()
            .map(
              (member) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: CircleAvatar(
                  radius: 12,
                  child: member.userProfileImage != null
                      ? ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(member.userProfileImage!.convertToImageProxy()))
                      : Text(
                          member.userProfileLastname[0],
                          style: const TextStyle(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.grey,
                                offset: Offset(2, 2),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            )
            .toList(),
      ),
      subtitle: Text("${myItems.where((element) => element.isChecked).length}/${myItems.length}"),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      onTap: () {
        ref.read(tripDetailControllerProvider.notifier).setTrip(trip);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TripScreen(),
          ),
        );
      },
    );
  }
}
