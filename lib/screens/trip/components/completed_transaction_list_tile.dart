import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trippidy/extensions/build_context_extension.dart';
import 'package:trippidy/model/completed_transaction.dart';

class CompletedTransactionListTile extends ConsumerWidget {
  const CompletedTransactionListTile({super.key, required this.completedTransaction});

  final CompletedTransaction completedTransaction;

  @override
  Widget build(BuildContext context, ref) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 100),
      child: Container(
        margin: const EdgeInsets.only(left: 0, right: 16, top: 0, bottom: 0),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.colorScheme.secondaryContainer),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(completedTransaction.payerUserProfileImage),
                  radius: 20,
                ),
                const SizedBox(width: 8.0),
                Text(
                  completedTransaction.payerUserProfileFirstname,
                  style: context.txtTheme.bodySmall,
                ),
                Text(
                  completedTransaction.payerUserProfileLastname,
                  style: context.txtTheme.bodySmall,
                )
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(4),
                  height: 40,
                  child: Text(
                    '${completedTransaction.amount.round()} Kč',
                    style: context.txtTheme.bodySmall,
                  ),
                ),
                const Icon(Icons.arrow_right_alt)
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(completedTransaction.payeeUserProfileImage),
                  radius: 20,
                ),
                const SizedBox(width: 8.0),
                Text(
                  completedTransaction.payeeUserProfileFirstname,
                  style: context.txtTheme.bodySmall,
                ),
                Text(
                  completedTransaction.payeeUserProfileLastname,
                  style: context.txtTheme.bodySmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
