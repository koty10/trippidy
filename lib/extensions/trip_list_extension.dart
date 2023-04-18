import '../model/trip.dart';

extension TripListExtension on List<Trip> {
  List<Trip> filterTrips({bool accepted = true, required String userProfileId}) {
    return where((t) => t.members.any((m) => m.userProfileId == userProfileId && m.accepted == accepted)).toList();
  }
}
