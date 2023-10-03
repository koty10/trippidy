// ignore_for_file: public_member_api_docs, sort_constructors_first

class FutureTransaction {
  final String id;
  final String payerId;
  final String payeeId;
  final String itemId;
  final String itemName;
  final bool itemIsChecked;
  final int itemAmount;
  final bool itemIsPrivate;
  final bool itemIsShared;
  final int itemPrice;
  FutureTransaction({
    required this.id,
    required this.payerId,
    required this.payeeId,
    required this.itemId,
    required this.itemName,
    required this.itemIsChecked,
    required this.itemAmount,
    required this.itemIsPrivate,
    required this.itemIsShared,
    required this.itemPrice,
  });

  FutureTransaction copyWith({
    String? id,
    String? payerId,
    String? payeeId,
    String? itemId,
    String? itemName,
    bool? itemIsChecked,
    int? itemAmount,
    bool? itemIsPrivate,
    bool? itemIsShared,
    int? itemPrice,
  }) {
    return FutureTransaction(
      id: id ?? this.id,
      payerId: payerId ?? this.payerId,
      payeeId: payeeId ?? this.payeeId,
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      itemIsChecked: itemIsChecked ?? this.itemIsChecked,
      itemAmount: itemAmount ?? this.itemAmount,
      itemIsPrivate: itemIsPrivate ?? this.itemIsPrivate,
      itemIsShared: itemIsShared ?? this.itemIsShared,
      itemPrice: itemPrice ?? this.itemPrice,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'payerId': payerId,
        'payeeId': payeeId,
        'itemId': itemId,
        'itemName': itemName,
        'itemIsChecked': itemIsChecked,
        'itemAmount': itemAmount,
        'itemIsPrivate': itemIsPrivate,
        'itemIsShared': itemIsShared,
        'itemPrice': itemPrice,
      };

  factory FutureTransaction.fromJson(Map<String, dynamic> map) {
    return FutureTransaction(
      id: map['id'] as String,
      payerId: map['payerId'] as String,
      payeeId: map['payeeId'] as String,
      itemId: map['itemId'] as String,
      itemName: map['itemName'] as String,
      itemIsChecked: map['itemIsChecked'] as bool,
      itemAmount: map['itemAmount'] as int,
      itemIsPrivate: map['itemIsPrivate'] as bool,
      itemIsShared: map['itemIsShared'] as bool,
      itemPrice: map['itemPrice'] as int,
    );
  }

  @override
  String toString() {
    return 'FutureTransaction(id: $id, payerId: $payerId, payeeId: $payeeId, itemId: $itemId, itemName: $itemName, itemIsChecked: $itemIsChecked, itemAmount: $itemAmount, itemIsPrivate: $itemIsPrivate, itemIsShared: $itemIsShared, itemPrice: $itemPrice)';
  }

  @override
  bool operator ==(covariant FutureTransaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.payerId == payerId &&
        other.payeeId == payeeId &&
        other.itemId == itemId &&
        other.itemName == itemName &&
        other.itemIsChecked == itemIsChecked &&
        other.itemAmount == itemAmount &&
        other.itemIsPrivate == itemIsPrivate &&
        other.itemIsShared == itemIsShared &&
        other.itemPrice == itemPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        payerId.hashCode ^
        payeeId.hashCode ^
        itemId.hashCode ^
        itemName.hashCode ^
        itemIsChecked.hashCode ^
        itemAmount.hashCode ^
        itemIsPrivate.hashCode ^
        itemIsShared.hashCode ^
        itemPrice.hashCode;
  }
}
