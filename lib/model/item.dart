// ignore_for_file: public_member_api_docs, sort_constructors_first

class Item {
  Item({
    required this.category,
    required this.name,
    required this.checked,
    required this.amount,
    required this.private,
    required this.shared,
    required this.userId,
    required this.price,
  });

  String category;
  String name;
  bool checked;
  int amount;
  bool private;
  bool shared;
  double price;

  // backlink
  // TODO maybe make it differently
  String userId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'category': category,
      'checked': checked,
      'amount': amount,
      'private': private,
      'shared': shared,
      'userId': userId,
      'price': price,
    };
  }

  factory Item.fromMap(String name, Map<String, dynamic> map) {
    return Item(
      category: map['category'] as String,
      name: name,
      checked: map['checked'] as bool,
      amount: map['amount'] as int,
      private: map['private'] as bool,
      shared: map['shared'] as bool,
      userId: map['userId'] as String,
      price: map['price'] as double,
    );
  }
}
