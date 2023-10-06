// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:decimal/decimal.dart';

class CompletedTransaction {
  final String id;
  final String payerId;
  final String payerUserProfileId;
  final String payerUserProfileFirstname;
  final String payerUserProfileLastname;
  final String payerUserProfileImage;
  final String payeeId;
  final String payeeUserProfileId;
  final String payeeUserProfileFirstname;
  final String payeeUserProfileLastname;
  final String payeeUserProfileImage;
  final Decimal amount;
  final bool isCanceled;
  final String tripId;
  CompletedTransaction({
    required this.id,
    required this.payerId,
    required this.payerUserProfileId,
    required this.payerUserProfileFirstname,
    required this.payerUserProfileLastname,
    required this.payerUserProfileImage,
    required this.payeeId,
    required this.payeeUserProfileId,
    required this.payeeUserProfileFirstname,
    required this.payeeUserProfileLastname,
    required this.payeeUserProfileImage,
    required this.amount,
    required this.isCanceled,
    required this.tripId,
  });

  factory CompletedTransaction.empty() {
    return CompletedTransaction(
      id: "",
      payerId: "",
      payerUserProfileId: "",
      payerUserProfileFirstname: "",
      payerUserProfileLastname: "",
      payerUserProfileImage: "",
      payeeId: "",
      payeeUserProfileId: "",
      payeeUserProfileFirstname: "",
      payeeUserProfileLastname: "",
      payeeUserProfileImage: "",
      amount: Decimal.fromInt(0),
      isCanceled: false,
      tripId: "",
    );
  }

  CompletedTransaction copyWith({
    String? id,
    String? payerId,
    String? payerUserProfileId,
    String? payerUserProfileFirstname,
    String? payerUserProfileLastname,
    String? payerUserProfileImage,
    String? payeeId,
    String? payeeUserProfileId,
    String? payeeUserProfileFirstname,
    String? payeeUserProfileLastname,
    String? payeeUserProfileImage,
    Decimal? amount,
    bool? isCanceled,
    String? tripId,
  }) {
    return CompletedTransaction(
      id: id ?? this.id,
      payerId: payerId ?? this.payerId,
      payerUserProfileId: payerUserProfileId ?? this.payerUserProfileId,
      payerUserProfileFirstname: payerUserProfileFirstname ?? this.payerUserProfileFirstname,
      payerUserProfileLastname: payerUserProfileLastname ?? this.payerUserProfileLastname,
      payerUserProfileImage: payerUserProfileImage ?? this.payerUserProfileImage,
      payeeId: payeeId ?? this.payeeId,
      payeeUserProfileId: payeeUserProfileId ?? this.payeeUserProfileId,
      payeeUserProfileFirstname: payeeUserProfileFirstname ?? this.payeeUserProfileFirstname,
      payeeUserProfileLastname: payeeUserProfileLastname ?? this.payeeUserProfileLastname,
      payeeUserProfileImage: payeeUserProfileImage ?? this.payeeUserProfileImage,
      amount: amount ?? this.amount,
      isCanceled: isCanceled ?? this.isCanceled,
      tripId: tripId ?? this.tripId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'payerId': payerId,
      'payerUserProfileId': payerUserProfileId,
      'payerUserProfileFirstname': payerUserProfileFirstname,
      'payerUserProfileLastname': payerUserProfileLastname,
      'payerUserProfileImage': payerUserProfileImage,
      'payeeId': payeeId,
      'payeeUserProfileId': payeeUserProfileId,
      'payeeUserProfileFirstname': payeeUserProfileFirstname,
      'payeeUserProfileLastname': payeeUserProfileLastname,
      'payeeUserProfileImage': payeeUserProfileImage,
      'amount': amount,
      'isCanceled': isCanceled,
      'tripId': tripId,
    };
  }

  factory CompletedTransaction.fromJson(Map<String, dynamic> map) {
    return CompletedTransaction(
      id: map['id'] as String,
      payerId: map['payerId'] as String,
      payerUserProfileId: map['payerUserProfileId'] as String,
      payerUserProfileFirstname: map['payerUserProfileFirstname'] as String,
      payerUserProfileLastname: map['payerUserProfileLastname'] as String,
      payerUserProfileImage: map['payerUserProfileImage'] as String,
      payeeId: map['payeeId'] as String,
      payeeUserProfileId: map['payeeUserProfileId'] as String,
      payeeUserProfileFirstname: map['payeeUserProfileFirstname'] as String,
      payeeUserProfileLastname: map['payeeUserProfileLastname'] as String,
      payeeUserProfileImage: map['payeeUserProfileImage'] as String,
      amount: Decimal.parse(map['amount']),
      isCanceled: map['isCanceled'] as bool,
      tripId: map['tripId'] as String,
    );
  }

  @override
  String toString() {
    return 'CompletedTransaction(id: $id, payerId: $payerId, payerUserProfileId: $payerUserProfileId, payerUserProfileFirstname: $payerUserProfileFirstname, payerUserProfileLastname: $payerUserProfileLastname, payerUserProfileImage: $payerUserProfileImage, payeeId: $payeeId, payeeUserProfileId: $payeeUserProfileId, payeeUserProfileFirstname: $payeeUserProfileFirstname, payeeUserProfileLastname: $payeeUserProfileLastname, payeeUserProfileImage: $payeeUserProfileImage, amount: $amount, isCanceled: $isCanceled, tripId: $tripId)';
  }

  @override
  bool operator ==(covariant CompletedTransaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.payerId == payerId &&
        other.payerUserProfileId == payerUserProfileId &&
        other.payerUserProfileFirstname == payerUserProfileFirstname &&
        other.payerUserProfileLastname == payerUserProfileLastname &&
        other.payerUserProfileImage == payerUserProfileImage &&
        other.payeeId == payeeId &&
        other.payeeUserProfileId == payeeUserProfileId &&
        other.payeeUserProfileFirstname == payeeUserProfileFirstname &&
        other.payeeUserProfileLastname == payeeUserProfileLastname &&
        other.payeeUserProfileImage == payeeUserProfileImage &&
        other.amount == amount &&
        other.isCanceled == isCanceled &&
        other.tripId == tripId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        payerId.hashCode ^
        payerUserProfileId.hashCode ^
        payerUserProfileFirstname.hashCode ^
        payerUserProfileLastname.hashCode ^
        payerUserProfileImage.hashCode ^
        payeeId.hashCode ^
        payeeUserProfileId.hashCode ^
        payeeUserProfileFirstname.hashCode ^
        payeeUserProfileLastname.hashCode ^
        payeeUserProfileImage.hashCode ^
        amount.hashCode ^
        isCanceled.hashCode ^
        tripId.hashCode;
  }
}
