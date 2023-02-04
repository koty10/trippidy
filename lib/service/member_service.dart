import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trippidy/model/item.dart';

class MemberService {
  Item addItem(String tripId, String name, {String category = ''}) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var db = FirebaseFirestore.instance;

    // If item does not exist yet
    Item newItem = Item(
      amount: 1,
      category: category.trim().toLowerCase(),
      checked: false,
      name: name.trim().toLowerCase(),
      price: 0,
      private: false,
      shared: true,
      userId: userId,
    );

    db.collection('trips').doc(tripId).update(
      {
        'members.$userId.items.${newItem.name}': newItem.toMap(),
      },
    );

    return newItem;
  }
}
