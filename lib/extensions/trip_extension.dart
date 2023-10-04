import 'dart:math';

import 'package:trippidy/model/app/future_payment.dart';
import 'package:trippidy/model/member.dart';

import '../model/trip.dart';

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

    for (var member in membersCopy) {
      for (var item in member.items.where((i) => i.price > 0 && i.futureTransactions.isNotEmpty)) {
        int share = (item.price / item.futureTransactions.length).round();
        for (var futureTransaction in item.futureTransactions) {
          if (futureTransaction.payerId != item.memberId) {
            // if current member is not a buyer
            membersCopy.firstWhere((element) => element.id == futureTransaction.payerId).balance -= share; // current member owes his share
          }
        }
        member.balance += item.price - share; // buyer already payed whole price but still owes his share
      }
    }
    return membersCopy;
  }

  List<FuturePayment> getFuturePayments() {
    List<Member> membersWithCalculatedBalance = getMembersWithCalculatedBalances();
    List<Member> debtors = membersWithCalculatedBalance.where((p) => p.balance < 0).toList();
    List<Member> creditors = membersWithCalculatedBalance.where((p) => p.balance > 0).toList();
    List<FuturePayment> futurePayments = [];

    while (debtors.isNotEmpty && creditors.isNotEmpty) {
      debtors.sort((a, b) => b.balance.compareTo(a.balance));
      creditors.sort((a, b) => b.balance.compareTo(a.balance));

      var debtor = debtors.first;
      var creditor = creditors.first;

      var transactionAmount = min(debtor.balance.abs(), creditor.balance);

      debtor.balance += transactionAmount;
      creditor.balance -= transactionAmount;

      if (debtor.balance == 0) debtors.remove(debtor);
      if (creditor.balance == 0) creditors.remove(creditor);

      futurePayments.add(FuturePayment(debtor, creditor, transactionAmount));
    }
    return futurePayments;
  }
}
