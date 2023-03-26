import 'item.dart';

class Member {
  Member({
    required this.accepted,
    this.id,
    required this.items,
    required this.role,
    this.tripId,
    this.userProfileFirstname,
    this.userProfileLastname,
    this.userProfileId,
    this.userProfileImage,
  });

  bool accepted;
  int? id;
  List<Item> items;
  String role;
  int? tripId;
  String? userProfileFirstname;
  String? userProfileLastname;
  String? userProfileId;
  String? userProfileImage;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        accepted: json["accepted"],
        id: json["id"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        role: json["role"],
        tripId: json["tripId"],
        userProfileFirstname: json["userProfileFirstname"],
        userProfileLastname: json["userProfileLastname"],
        userProfileId: json["userProfileId"],
        userProfileImage: json["userProfileImage"],
      );

  Map<String, dynamic> toJson() => {
        "accepted": accepted,
        "id": id,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "role": role,
        "tripId": tripId,
        "userProfileFirstname": userProfileFirstname,
        "userProfileLastname": userProfileLastname,
        "userProfileId": userProfileId,
        "userProfileImage": userProfileImage,
      };
}
