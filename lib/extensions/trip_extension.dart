import 'package:decimal/decimal.dart';
import 'package:trippidy/model/app/future_payment.dart';
import 'package:trippidy/model/dto/item.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/utils/decimal_utils.dart';
import 'package:trippidy/utils/string_utils.dart';

import '../model/dto/trip.dart';

extension TripExtension on Trip {
  Iterable<String> getCategoriesFromTrip({required String userProfileId}) {
    var result = members
        .where((member) => member.userProfileId != userProfileId)
        .expand((member) => member.items)
        .where((item) => !item.isPrivate)
        .map((item) => item.categoryName)
        .toSet();
    result.addAll(members.firstWhere((member) => member.userProfileId == userProfileId).items.map((item) => item.categoryName));
    return result;
  }

  List<Member> getMembersWithCalculatedBalances() {
    var membersCopy = members.map((e) => e.copyWith()).toList();
    var completedTransactionsCopy = completedTransactions.map((e) => e.copyWith()).toList();

    for (var member in membersCopy) {
      for (var item in member.items.where((i) => i.price > Decimal.zero && i.futureTransactions.isNotEmpty)) {
        Decimal share = (item.price / Decimal.fromInt(item.futureTransactions.length)).toDecimal(scaleOnInfinitePrecision: 2);
        for (var futureTransaction in item.futureTransactions) {
          if (futureTransaction.payerId != item.memberId) {
            // if current member is not a buyer
            membersCopy.firstWhere((element) => element.id == futureTransaction.payerId).balance -= share; // current member owes his share
          }
        }
        member.balance += item.price - share; // buyer already payed whole price but still owes his share
      }
    }
    // Apply existing transactions
    for (var transaction in completedTransactionsCopy.where((element) => !element.isCanceled)) {
      membersCopy.firstWhere((element) => element.id == transaction.payerId).balance += transaction.amount;
      membersCopy.firstWhere((element) => element.id == transaction.payeeId).balance -= transaction.amount;
    }
    return membersCopy;
  }

  List<FuturePayment> getFuturePayments() {
    List<Member> membersWithCalculatedBalance = getMembersWithCalculatedBalances();
    List<Member> debtors = membersWithCalculatedBalance.where((p) => p.balance < Decimal.zero).toList();
    List<Member> creditors = membersWithCalculatedBalance.where((p) => p.balance > Decimal.zero).toList();
    List<FuturePayment> futurePayments = [];

    while (debtors.isNotEmpty && creditors.isNotEmpty) {
      debtors.sort((a, b) => b.balance.compareTo(a.balance));
      creditors.sort((a, b) => b.balance.compareTo(a.balance));

      var debtor = debtors.first;
      var creditor = creditors.first;

      var transactionAmount = minDecimal(debtor.balance.abs(), creditor.balance);

      debtor.balance += transactionAmount;
      creditor.balance -= transactionAmount;

      if (debtor.balance == Decimal.zero) debtors.remove(debtor);
      if (creditor.balance == Decimal.zero) creditors.remove(creditor);

      futurePayments.add(FuturePayment(debtor, creditor, transactionAmount));
    }
    return futurePayments;
  }

  Map<String, List<Item>> getListItemsForUser({required String userId, bool showPrivate = false}) {
    var member = members.firstWhere((element) => element.id == userId);
    var tmp = showPrivate ? member.items : member.items.where((element) => !element.isPrivate);

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.categoryName] != null ? dict[element.categoryName]?.add(element) : dict.putIfAbsent(element.categoryName, () => [element]);
    }

    // Sort the Map by keys
    dict = Map.fromEntries(dict.entries.toList()..sort((e1, e2) => customOrderSortKey(e1.key).compareTo(customOrderSortKey(e2.key))));

    // Sort each list inside the Map
    dict.forEach((key, value) {
      value.sort((s1, s2) => customOrderSortKey(s1.name).compareTo(customOrderSortKey(s2.name)));
    });

    return dict;
  }

  Map<String, List<Item>> getOurListItems({required Member loggedUserMember}) {
    var tmp = (members.where((m) => m.userProfileId != loggedUserMember.userProfileId).toList() + [loggedUserMember])
        .expand((element2) => element2.items)
        .where((element3) => element3.isShared)
        .toList();

    var dict = <String, List<Item>>{};
    for (var element in tmp) {
      dict[element.categoryName] != null ? dict[element.categoryName]?.add(element) : dict.putIfAbsent(element.categoryName, () => [element]);
    }

    // Sort the Map by keys
    dict = Map.fromEntries(dict.entries.toList()..sort((e1, e2) => customOrderSortKey(e1.key).compareTo(customOrderSortKey(e2.key))));

    // Sort each list inside the Map
    dict.forEach((key, value) {
      value.sort((s1, s2) => customOrderSortKey(s1.name).compareTo(customOrderSortKey(s2.name)));
    });

    return dict;
  }

  List<Item> getAllSharedItems() {
    return members.expand((e) => e.items.where((item) => item.isShared)).toList();
  }
}
