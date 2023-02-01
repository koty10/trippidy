// ignore_for_file: public_member_api_docs, sort_constructors_first

class Item {
  Item({
    required this.documentId,
    required this.category,
    required this.name,
    required this.checked,
    required this.amount,
    required this.private,
    required this.shared,
    required this.userId,
  });

  String documentId;
  String category;
  String name;
  bool checked;
  int amount;
  bool private;
  bool shared;

  // backlink
  // TODO maybe make it differently
  String userId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'name': name,
      'checked': checked,
      'amount': amount,
      'private': private,
      'shared': shared,
      'userId': userId,
    };
  }

  factory Item.fromMap(String id, Map<String, dynamic> map) {
    return Item(
      documentId: id,
      category: map['category'] as String,
      name: map['name'] as String,
      checked: map['checked'] as bool,
      amount: map['amount'] as int,
      private: map['private'] as bool,
      shared: map['shared'] as bool,
      userId: map['userId'] as String,
    );
  }
}
