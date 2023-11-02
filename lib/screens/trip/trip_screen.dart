import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/extensions/trip_extension.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:trippidy/providers/trip_detail_controller.dart';
import 'package:trippidy/screens/item_lists/my_list/my_list_screen.dart';
import 'package:trippidy/screens/item_lists/our_list/our_list_screen.dart';
import 'package:trippidy/screens/trip/components/member_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:trippidy/screens/trip/components/members_list_view.dart';
import 'package:trippidy/screens/trip/trip_payments_screen.dart';
import 'package:trippidy/screens/trip/trip_settings_screen.dart';

import '../../model/dto/member.dart';
import '../../providers/auth_controller.dart';
import '../../providers/member_controller.dart';
import '../add_member/add_member_screen.dart';

class TripScreen extends ConsumerWidget {
  const TripScreen({super.key});

  static const routeName = '/tripScreen';

  @override
  Widget build(BuildContext context, ref) {
    Trip currentTrip = ref.watch(tripDetailControllerProvider);
    List<Member> members = currentTrip.members.where((element) => element.userProfileId != ref.read(authControllerProvider).userProfile!.id).toList();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(currentTrip.name),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TripPaymentsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.attach_money),
            padding: const EdgeInsets.all(16),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TripSettingsScreen(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
            padding: const EdgeInsets.all(16),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(tripDetailControllerProvider.notifier).refreshTrip(),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        MemberListTile(
                          title: "My list",
                          currentTrip: currentTrip,
                          target: const MyListScreen(),
                          member: ref.read(memberControllerProvider.notifier).getLoggedInMemberFromTrip(currentTrip),
                          items: currentTrip
                              .getListItemsForUser(userId: ref.read(memberControllerProvider.notifier).getLoggedInMemberFromTrip(currentTrip).id)
                              .entries,
                        ),
                        const SizedBox(height: 16),
                        MemberListTile(
                          title: "Shared list",
                          currentTrip: currentTrip,
                          target: const OurListScreen(),
                          member: ref.read(memberControllerProvider.notifier).getLoggedInMemberFromTrip(currentTrip),
                          items: currentTrip
                              .getOurListItems(loggedUserMember: ref.read(memberControllerProvider.notifier).getLoggedInMemberFromTrip(currentTrip))
                              .entries,
                          showGroupIcon: true,
                        ),
                      ],
                    ),
                  ),
                  if (members.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: Text(
                        'Lists of other members',
                        textAlign: TextAlign.left,
                        style: context.txtTheme.bodyMedium,
                      ),
                    ),
                  if (members.isEmpty)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieBuilder.asset(
                            'assets/lotties/people.json',
                            height: 200,
                          ),
                          const SizedBox(height: 20),
                          const Text('There are no members here yet.'),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            if (members.isNotEmpty) MembersListView(currentTrip: currentTrip),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Add member"),
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddMemberScreen(),
            ),
          );
        },
      ),
    );
  }
}
