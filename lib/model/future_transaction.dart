// ignore_for_file: public_member_api_docs, sort_constructors_first

class FutureTransaction {
  final String id;
  final String payerId;
  final String itemId;
  FutureTransaction({
    required this.id,
    required this.payerId,
    required this.itemId,
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
      itemId: itemId ?? this.itemId,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'payerId': payerId,
        'itemId': itemId,
      };

  factory FutureTransaction.fromJson(Map<String, dynamic> map) {
    return FutureTransaction(
      id: map['id'] as String,
      payerId: map['payerId'] as String,
      itemId: map['itemId'] as String,
    );
  }

  @override
  String toString() {
    return 'FutureTransaction(id: $id, payerId: $payerId, itemId: $itemId)';
  }

  @override
  bool operator ==(covariant FutureTransaction other) {
    if (identical(this, other)) return true;

    return other.id == id && other.payerId == payerId && other.itemId == itemId;
  }

  @override
  int get hashCode {
    return id.hashCode ^ payerId.hashCode ^ itemId.hashCode;
  }
}
