import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

Item itemFromJson(String str) => json.decode(str);

String itemToJson(Item data) => json.encode(data);

@JsonSerializable()
class Item {
  Item({
    this.amount = 1,
    this.categoryId,
    required this.categoryName,
    this.id,
    required this.isChecked,
    required this.isPrivate,
    required this.isShared,
    required this.memberId,
    required this.name,
    required this.price,
  });

  int amount;
  int? categoryId;
  String categoryName;
  int? id;
  bool isChecked;
  bool isPrivate;
  bool isShared;
  int memberId;
  String name;
  int price;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        amount: json["amount"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        id: json["id"],
        isChecked: json["isChecked"],
        isPrivate: json["isPrivate"],
        isShared: json["isShared"],
        memberId: json["memberId"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "id": id,
        "isChecked": isChecked,
        "isPrivate": isPrivate,
        "isShared": isShared,
        "memberId": memberId,
        "name": name,
        "price": price,
      };
}
