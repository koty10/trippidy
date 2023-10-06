// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:trippidy/model/completed_transaction.dart';
import 'package:trippidy/model/enum/role.dart';

import 'package:trippidy/model/future_transaction.dart';

import 'item.dart';

class Member {
  bool accepted;
  String id;
  List<Item> items;
  String role;
  String tripId;
  String userProfileFirstname;
  String userProfileLastname;
  String userProfileId;
  String? userProfileImage;
  List<FutureTransaction> futureTransactions;
  List<CompletedTransaction> completedTransactionsSent;
  List<CompletedTransaction> completedTransactionsReceived;

  Decimal balance = Decimal.zero;

  Member({
    required this.accepted,
    required this.id,
    required this.items,
    required this.role,
    required this.tripId,
    required this.userProfileFirstname,
    required this.userProfileLastname,
    required this.userProfileId,
    this.userProfileImage,
    required this.futureTransactions,
    required this.completedTransactionsSent,
    required this.completedTransactionsReceived,
  });

  Decimal get totalPrice => items.fold(Decimal.zero, (sum, item) => sum + item.price);

  factory Member.empty() {
    return Member(
      accepted: false,
      items: List.empty(),
      role: Role.member.name,
      userProfileId: '',
      tripId: "",
      id: "",
      userProfileFirstname: "",
      userProfileLastname: "",
      userProfileImage: "",
      futureTransactions: [],
      completedTransactionsSent: [],
      completedTransactionsReceived: [],
    );
  }

  Member copyWith({
    bool? accepted,
    String? id,
    List<Item>? items,
    String? role,
    String? tripId,
    String? userProfileFirstname,
    String? userProfileLastname,
    String? userProfileId,
    String? userProfileImage,
    List<FutureTransaction>? futureTransactions,
    List<CompletedTransaction>? completedTransactionsSent,
    List<CompletedTransaction>? completedTransactionsReceived,
  }) {
    return Member(
      accepted: accepted ?? this.accepted,
      id: id ?? this.id,
      items: items ?? this.items,
      role: role ?? this.role,
      tripId: tripId ?? this.tripId,
      userProfileFirstname: userProfileFirstname ?? this.userProfileFirstname,
      userProfileLastname: userProfileLastname ?? this.userProfileLastname,
      userProfileId: userProfileId ?? this.userProfileId,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      futureTransactions: futureTransactions ?? this.futureTransactions,
      completedTransactionsSent: completedTransactionsSent ?? this.completedTransactionsSent,
      completedTransactionsReceived: completedTransactionsReceived ?? this.completedTransactionsReceived,
    );
  }

  Map<String, dynamic> toJson() => {
        'accepted': accepted,
        'id': id,
        'items': items.map((x) => x.toJson()).toList(),
        'role': role,
        'tripId': tripId,
        'userProfileFirstname': userProfileFirstname,
        'userProfileLastname': userProfileLastname,
        'userProfileId': userProfileId,
        'userProfileImage': userProfileImage,
        'futureTransactions': futureTransactions.map((x) => x.toJson()).toList(),
        'completedTransactionsSent': completedTransactionsSent.map((x) => x.toJson()).toList(),
        'completedTransactionsReceived': completedTransactionsReceived.map((x) => x.toJson()).toList(),
      };

  factory Member.fromJson(Map<String, dynamic> map) {
    return Member(
      accepted: map['accepted'] as bool,
      id: map['id'] as String,
      items: List<Item>.from(map["items"].map((x) => Item.fromJson(x))),
      role: map['role'] as String,
      tripId: map['tripId'] as String,
      userProfileFirstname: map['userProfileFirstname'] as String,
      userProfileLastname: map['userProfileLastname'] as String,
      userProfileId: map['userProfileId'] as String,
      userProfileImage: map['userProfileImage'] != null ? map['userProfileImage'] as String : null,
      futureTransactions: List<FutureTransaction>.from(map["futureTransactions"].map((x) => FutureTransaction.fromJson(x))),
      completedTransactionsSent: List<CompletedTransaction>.from(map["completedTransactionsSent"].map((x) => CompletedTransaction.fromJson(x))),
      completedTransactionsReceived: List<CompletedTransaction>.from(map["completedTransactionsReceived"].map((x) => CompletedTransaction.fromJson(x))),
    );
  }

  @override
  String toString() {
    return 'Member(accepted: $accepted, id: $id, items: $items, role: $role, tripId: $tripId, userProfileFirstname: $userProfileFirstname, userProfileLastname: $userProfileLastname, userProfileId: $userProfileId, userProfileImage: $userProfileImage, futureTransactions: $futureTransactions, completedTransactionsSent: $completedTransactionsSent, completedTransactionsReceived: $completedTransactionsReceived)';
  }

  @override
  bool operator ==(covariant Member other) {
    if (identical(this, other)) return true;

    return other.accepted == accepted &&
        other.id == id &&
        listEquals(other.items, items) &&
        other.role == role &&
        other.tripId == tripId &&
        other.userProfileFirstname == userProfileFirstname &&
        other.userProfileLastname == userProfileLastname &&
        other.userProfileId == userProfileId &&
        other.userProfileImage == userProfileImage &&
        listEquals(other.futureTransactions, futureTransactions) &&
        listEquals(other.completedTransactionsSent, completedTransactionsSent) &&
        listEquals(other.completedTransactionsReceived, completedTransactionsReceived);
  }

  @override
  int get hashCode {
    return accepted.hashCode ^
        id.hashCode ^
        items.hashCode ^
        role.hashCode ^
        tripId.hashCode ^
        userProfileFirstname.hashCode ^
        userProfileLastname.hashCode ^
        userProfileId.hashCode ^
        userProfileImage.hashCode ^
        futureTransactions.hashCode ^
        completedTransactionsSent.hashCode ^
        completedTransactionsReceived.hashCode;
  }
}
