import 'dart:convert';

Item itemFromJson(String str) => json.decode(str);

String itemToJson(Item data) => json.encode(data);

class Item {
  Item({
    this.amount = 1,
    required this.categoryId,
    required this.categoryName,
    required this.id,
    required this.isChecked,
    required this.isPrivate,
    required this.isShared,
    required this.memberId,
    required this.name,
    required this.price,
  });

  int amount;
  String categoryId;
  String categoryName;
  String id;
  bool isChecked;
  bool isPrivate;
  bool isShared;
  String memberId;
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
