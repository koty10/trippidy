import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/api/api_caller.dart';

import '../model/dto/user_profile.dart';

part 'queried_user_profiles_provider.g.dart';

@riverpod
Future<List<UserProfile>> queriedUserProfilesProvider(QueriedUserProfilesProviderRef ref, String query, String tripId) async {
  // return Future.delayed(const Duration(milliseconds: 2000), () {
  //   return [
  //     UserProfile(firstname: "aaa", id: "", image: "", lastname: "bbb", members: []),
  //   ];
  // });
  return await ref.read(apiCallerProvider).getUserProfilesByQuery(query, tripId);
}
