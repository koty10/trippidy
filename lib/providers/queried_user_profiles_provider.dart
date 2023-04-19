import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trippidy/api/api_caller.dart';

import '../model/user_profile.dart';

part 'queried_user_profiles_provider.g.dart';

@riverpod
Future<List<UserProfile>> queriedUserProfilesProvider(QueriedUserProfilesProviderRef ref, String query) async {
  return await ref.read(apiCallerProvider).getUserProfilesByQuery(query);
}
