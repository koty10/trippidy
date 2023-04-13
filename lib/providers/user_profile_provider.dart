

// final userProfileProvider = StateNotifierProvider<UserProfileProvider, UserProfile>(
//   (ref) {
//     return UserProfileProvider(
//       UserProfile(
//         id: "",
//         firstname: "",
//         image: "",
//         lastname: "",
//         members: [],
//       ),
//       ref.watch(apiCallerProvider),
//     );
//   },
// );

// class UserProfileProvider extends StateNotifier<UserProfile> {
//   final ApiCaller apiCaller;
//   UserProfileProvider(super.state, this.apiCaller);

//   void setUserProfile(UserProfile userProfile) {
//     state = userProfile;
//   }
// }

// part 'user_profile_provider.g.dart';

// @riverpod
// class UserProfileController extends _$UserProfileController {
//   @override
//   UserProfile build() {
//     return UserProfile.initial();
//   }

//   Future<void> setUserProfile() async {
//     final result = await ref.read(apiCallerProvider).getUserProfile();
//     log(result.toString());
//     state = result;
//   }
// }
