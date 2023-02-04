import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trippidy/model/item.dart';

class ItemService {
  void updateItem(String tripId, Item item) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var db = FirebaseFirestore.instance;

    db
        .collection('trips')
        .doc(tripId)
        .update({'members.$userId.items.${item.name}': item.toMap()});
  }
}
