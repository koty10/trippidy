import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class SuggestionResponse {
  final List<String> suggestedItems;
  SuggestionResponse({
    required this.suggestedItems,
  });

  SuggestionResponse copyWith({
    List<String>? suggestedItems,
  }) {
    return SuggestionResponse(
      suggestedItems: suggestedItems ?? this.suggestedItems,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'suggestedItems': suggestedItems,
    };
  }

  factory SuggestionResponse.fromJson(Map<String, dynamic> map) {
    return SuggestionResponse(
      suggestedItems: List<String>.from(map['suggestedItems'] ?? []),
    );
  }

  @override
  String toString() => 'SuggestionResponse(suggestedItems: $suggestedItems)';

  @override
  bool operator ==(covariant SuggestionResponse other) {
    if (identical(this, other)) return true;

    return listEquals(other.suggestedItems, suggestedItems);
  }

  @override
  int get hashCode => suggestedItems.hashCode;
}
