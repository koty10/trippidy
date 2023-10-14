// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:trippidy/model/dto/future_transaction.dart';

class Item {
  int amount;
  String categoryId;
  String categoryName;
  String id;
  bool isChecked;
  bool isPrivate;
  bool isShared;
  String memberId;
  String name;
  Decimal price;
  List<FutureTransaction> futureTransactions;
  Item({
    required this.amount,
    required this.categoryId,
    required this.categoryName,
    required this.id,
    required this.isChecked,
    required this.isPrivate,
    required this.isShared,
    required this.memberId,
    required this.name,
    required this.price,
    required this.futureTransactions,
  });

  Item copyWith({
    int? amount,
    String? categoryId,
    String? categoryName,
    String? id,
    bool? isChecked,
    bool? isPrivate,
    bool? isShared,
    String? memberId,
    String? name,
    Decimal? price,
    List<FutureTransaction>? futureTransactions,
  }) {
    return Item(
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      id: id ?? this.id,
      isChecked: isChecked ?? this.isChecked,
      isPrivate: isPrivate ?? this.isPrivate,
      isShared: isShared ?? this.isShared,
      memberId: memberId ?? this.memberId,
      name: name ?? this.name,
      price: price ?? this.price,
      futureTransactions: futureTransactions ?? this.futureTransactions,
    );
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'categoryId': categoryId,
        'categoryName': categoryName,
        'id': id,
        'isChecked': isChecked,
        'isPrivate': isPrivate,
        'isShared': isShared,
        'memberId': memberId,
        'name': name,
        'price': price,
        'futureTransactions': futureTransactions.map((x) => x.toJson()).toList(),
      };

  factory Item.fromJson(Map<String, dynamic> map) {
    return Item(
      amount: map['amount'] as int,
      categoryId: map['categoryId'] as String,
      categoryName: map['categoryName'] as String,
      id: map['id'] as String,
      isChecked: map['isChecked'] as bool,
      isPrivate: map['isPrivate'] as bool,
      isShared: map['isShared'] as bool,
      memberId: map['memberId'] as String,
      name: map['name'] as String,
      price: Decimal.parse(map['price']),
      futureTransactions: List<FutureTransaction>.from(map["futureTransactions"].map((x) => FutureTransaction.fromJson(x))),
    );
  }

  @override
  String toString() {
    return 'Item(amount: $amount, categoryId: $categoryId, categoryName: $categoryName, id: $id, isChecked: $isChecked, isPrivate: $isPrivate, isShared: $isShared, memberId: $memberId, name: $name, price: $price, futureTransactions: $futureTransactions)';
  }

  @override
  bool operator ==(covariant Item other) {
    if (identical(this, other)) return true;

    return other.amount == amount &&
        other.categoryId == categoryId &&
        other.categoryName == categoryName &&
        other.id == id &&
        other.isChecked == isChecked &&
        other.isPrivate == isPrivate &&
        other.isShared == isShared &&
        other.memberId == memberId &&
        other.name == name &&
        other.price == price &&
        listEquals(other.futureTransactions, futureTransactions);
  }

  @override
  int get hashCode {
    return amount.hashCode ^
        categoryId.hashCode ^
        categoryName.hashCode ^
        id.hashCode ^
        isChecked.hashCode ^
        isPrivate.hashCode ^
        isShared.hashCode ^
        memberId.hashCode ^
        name.hashCode ^
        price.hashCode ^
        futureTransactions.hashCode;
  }
}
