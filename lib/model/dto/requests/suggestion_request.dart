// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

class SuggestionRequest {
  final String tripName;
  final String itemsCategory;
  final List<String> alreadyPackedItems;
  SuggestionRequest({
    required this.tripName,
    required this.itemsCategory,
    required this.alreadyPackedItems,
  });

  SuggestionRequest copyWith({
    String? tripName,
    String? itemsCategory,
    List<String>? alreadyPackedItems,
  }) {
    return SuggestionRequest(
      tripName: tripName ?? this.tripName,
      itemsCategory: itemsCategory ?? this.itemsCategory,
      alreadyPackedItems: alreadyPackedItems ?? this.alreadyPackedItems,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tripName': tripName,
      'itemsCategory': itemsCategory,
      'alreadyPackedItems': alreadyPackedItems,
    };
  }

  factory SuggestionRequest.fromJson(Map<String, dynamic> map) {
    return SuggestionRequest(
        tripName: map['tripName'] as String,
        itemsCategory: map['itemsCategory'] as String,
        alreadyPackedItems: List<String>.from(
          (map['alreadyPackedItems'] as List<String>),
        ));
  }

  @override
  String toString() => 'SuggestionRequest(tripName: $tripName, itemsCategory: $itemsCategory, alreadyPackedItems: $alreadyPackedItems)';

  @override
  bool operator ==(covariant SuggestionRequest other) {
    if (identical(this, other)) return true;

    return other.tripName == tripName && other.itemsCategory == itemsCategory && listEquals(other.alreadyPackedItems, alreadyPackedItems);
  }

  @override
  int get hashCode => tripName.hashCode ^ itemsCategory.hashCode ^ alreadyPackedItems.hashCode;
}
