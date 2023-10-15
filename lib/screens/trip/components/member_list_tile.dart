import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/model/dto/item.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/selected_category_provider.dart';
import 'package:trippidy/providers/show_tabs_provider.dart';

import '../../../model/dto/trip.dart';

class MemberListTile extends ConsumerWidget {
  const MemberListTile(
      {super.key, required this.title, required this.currentTrip, required this.target, required this.member, required this.items, this.showGroupIcon = false});

  final String title;
  final Trip currentTrip;
  final Widget target;
  final Member member;
  final bool showGroupIcon;
  final Iterable<MapEntry<String, List<Item>>> items;

  @override
  Widget build(BuildContext context, ref) {
    return ListTile(
      onTap: !member.accepted
          ? null
          : () {
              if (ref.read(showTabsProvider)) {
                ref.read(selectedCategoryProvider.notifier).state = items.first.key;
              } else {
                ref.read(selectedCategoryProvider.notifier).state = "";
              }
              ref.read(memberControllerProvider.notifier).setMember(member);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => target,
                ),
              );
            },
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: !member.accepted ? context.colorScheme.onInverseSurface : context.colorScheme.onSecondary,
      subtitle: !member.accepted ? const Text("Pozvánka odeslána") : null,
      leading: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: showGroupIcon
            ? const Icon(Icons.groups)
            : CircleAvatar(
                radius: 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(currentTrip.members.firstWhere((element) => element.id == member.id).userProfileImage!),
                ),
              ),
      ),
      title: Text(title, style: context.txtTheme.titleMedium),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      mouseCursor: SystemMouseCursors.click,
    );
  }
}
