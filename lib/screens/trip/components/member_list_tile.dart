import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/extensions/string_extension.dart';
import 'package:trippidy/model/dto/item.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/providers/member_controller.dart';
import 'package:trippidy/providers/selected_category_provider.dart';
import 'package:trippidy/providers/show_tabs_provider.dart';

class MemberListTile extends ConsumerWidget {
  const MemberListTile(
      {super.key,
      required this.title,
      required this.target,
      required this.member,
      required this.items,
      this.showGroupIcon = false,
      this.subtitle = "",
      this.trailing = ""});

  final String title;
  final String subtitle;
  final String trailing;
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
                ref.read(selectedCategoryProvider.notifier).state = items.isNotEmpty ? items.first.key : "Other";
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
      subtitle: !member.accepted
          ? const Text("Invitation sent")
          : subtitle.isNotEmpty
              ? Text(subtitle)
              : null,
      leading: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: showGroupIcon
            ? const Icon(Icons.groups)
            : CircleAvatar(
                radius: 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(member.userProfileImage!.convertToImageProxy()),
                ),
              ),
      ),
      title: Text(title, style: context.txtTheme.titleMedium),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      mouseCursor: SystemMouseCursors.click,
      trailing: Text(trailing),
    );
  }
}
