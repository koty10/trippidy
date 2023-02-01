// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  String documentId;
  String name;
  User({
    required this.documentId,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory User.fromMap(String id, Map<String, dynamic> map) {
    return User(
      documentId: id,
      name: map['name'] as String,
    );
  }
}
