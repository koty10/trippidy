import 'package:trippidy/api/api_caller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/model/user_profile.dart';

final userProfileProvider = StateNotifierProvider<UserProfileProvider, UserProfile>(
  (ref) {
    return UserProfileProvider(
      UserProfile(
        id: "",
        firstname: "",
        image: "",
        lastname: "",
        members: [],
      ),
      ref.watch(apiCallerProvider),
    );
  },
);

class UserProfileProvider extends StateNotifier<UserProfile> {
  final ApiCaller apiCaller;
  UserProfileProvider(super.state, this.apiCaller);

  void setUserProfile(UserProfile userProfile) {
    state = userProfile;
  }
}
