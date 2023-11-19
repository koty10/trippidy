// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trippidy/extensions/trip_extension.dart';
import 'package:trippidy/model/dto/future_transaction.dart';
import 'package:trippidy/model/dto/item.dart';
import 'package:trippidy/model/dto/member.dart';
import 'package:trippidy/model/dto/trip.dart';
import 'package:trippidy/model/enum/role.dart';

void main() {
  group("Future transactions test group", () {
    var futureTransactionTemplate = FutureTransaction(
      id: "future-transaction-id-1",
      payerId: "member-id-1",
      itemId: "item-id-1",
    );

    var itemTemplate = Item(
      amount: 0,
      categoryId: "category-id-1",
      categoryName: "Test category",
      id: "item-id-1",
      isChecked: false,
      isPrivate: false,
      isShared: true,
      memberId: "member-id-1",
      name: "Test item",
      price: Decimal.fromInt(100),
      futureTransactions: [
        //futureTransaction,
      ],
    );

    var tripTemplate = Trip(
      id: "trip-id-1",
      members: [],
      name: "Test trip",
      isDeleted: false,
      completedTransactions: [],
    );

    var memberTemplate = Member(
      accepted: true,
      id: "member-id-1",
      items: [
        //item,
      ],
      role: Role.member.name,
      tripId: "trip-id-1",
      userProfileFirstname: "John",
      userProfileLastname: "Doe",
      userProfileId: "user-profile-id-1",
      futureTransactions: [
        //futureTransaction,
      ],
      completedTransactionsSent: [],
      completedTransactionsReceived: [],
      userProfileBankAccountNumber: "",
      userProfileIban: "",
      userProfileEmail: "test-1@example.com",
    );

    test('Basic future transactions test', () {
      var trip = tripTemplate.copyWith();
      trip.members = [
        memberTemplate.copyWith(
          items: [
            itemTemplate.copyWith(
              futureTransactions: [
                futureTransactionTemplate.copyWith(),
              ],
            ),
          ],
        ),
      ];

      var futurePayments = trip.getFuturePayments();

      expect(futurePayments, isEmpty);
    });

    test('Two users future transactions test', () {
      var trip = tripTemplate.copyWith();
      trip.members = [
        memberTemplate.copyWith(
          id: "member-id-1",
          items: [
            itemTemplate.copyWith(
              price: Decimal.fromInt(100),
              futureTransactions: [
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-1",
                  itemId: "item-id-1",
                  payerId: "member-id-1",
                ),
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-2",
                  itemId: "item-id-1",
                  payerId: "member-id-2",
                ),
              ],
            ),
          ],
        ),
        memberTemplate.copyWith(
          id: "member-id-2",
        ),
      ];

      var futurePayments = trip.getFuturePayments();

      expect(futurePayments.length, equals(1));
      expect(futurePayments.first.amount, equals(Decimal.fromInt(50)));
      expect(futurePayments.first.payer.id, equals("member-id-2"));
      expect(futurePayments.first.payee.id, equals("member-id-1"));
    });
  });
}
