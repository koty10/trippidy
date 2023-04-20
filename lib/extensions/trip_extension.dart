import '../model/trip.dart';

extension TripExtension on Trip {
  Iterable<String> getCategoriesFromTrip({required String userProfileId}) {
    var result = members
        .where((member) => member.userProfileId != userProfileId)
        .expand((member) => member.items)
        .where((item) => !item.isPrivate)
        .map((item) => item.categoryName)
        .toSet();
    result.addAll(members.firstWhere((member) => member.userProfileId == userProfileId).items.map((item) => item.categoryName));
    return result;
  }
}
