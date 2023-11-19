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

    test('One user with one item should be without future transactions test', () {
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

    test('Two users with one item should result in one future transaction test', () {
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

    test('Two users with more items where one is bigger that another should result in one future transaction test', () {
      var trip = tripTemplate.copyWith();
      trip.members = [
        memberTemplate.copyWith(
          id: "member-id-1",
          items: [
            itemTemplate.copyWith(
              id: "item-id-1",
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
          items: [
            itemTemplate.copyWith(
              id: "item-id-2",
              memberId: "member-id-2",
              price: Decimal.fromInt(50),
              futureTransactions: [
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-3",
                  itemId: "item-id-2",
                  payerId: "member-id-1",
                ),
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-4",
                  itemId: "item-id-2",
                  payerId: "member-id-2",
                ),
              ],
            ),
          ],
        ),
      ];

      var futurePayments = trip.getFuturePayments();

      expect(futurePayments.length, equals(1));
      expect(futurePayments.first.amount, equals(Decimal.fromInt(25)));
      expect(futurePayments.first.payer.id, equals("member-id-2"));
      expect(futurePayments.first.payee.id, equals("member-id-1"));
    });

    test('Three users with more items with the same price should be without future transactions test', () {
      var trip = tripTemplate.copyWith();
      trip.members = [
        memberTemplate.copyWith(
          id: "member-id-1",
          items: [
            itemTemplate.copyWith(
              id: "item-id-1",
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
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-3",
                  itemId: "item-id-1",
                  payerId: "member-id-3",
                ),
              ],
            ),
          ],
        ),
        memberTemplate.copyWith(
          id: "member-id-2",
          items: [
            itemTemplate.copyWith(
              id: "item-id-2",
              memberId: "member-id-2",
              price: Decimal.fromInt(100),
              futureTransactions: [
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-4",
                  itemId: "item-id-2",
                  payerId: "member-id-1",
                ),
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-5",
                  itemId: "item-id-2",
                  payerId: "member-id-2",
                ),
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-6",
                  itemId: "item-id-2",
                  payerId: "member-id-3",
                ),
              ],
            ),
          ],
        ),
        memberTemplate.copyWith(
          id: "member-id-3",
          items: [
            itemTemplate.copyWith(
              id: "item-id-3",
              memberId: "member-id-3",
              price: Decimal.fromInt(100),
              futureTransactions: [
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-7",
                  itemId: "item-id-3",
                  payerId: "member-id-1",
                ),
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-8",
                  itemId: "item-id-2",
                  payerId: "member-id-2",
                ),
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-9",
                  itemId: "item-id-2",
                  payerId: "member-id-3",
                ),
              ],
            ),
          ],
        ),
      ];

      var futurePayments = trip.getFuturePayments();

      expect(futurePayments, isEmpty);
    });

    test('Three users with more items have same balance test', () {
      var trip = tripTemplate.copyWith();
      trip.members = [
        memberTemplate.copyWith(
          id: "member-id-1",
          items: [
            itemTemplate.copyWith(
              id: "item-id-1",
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
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-3",
                  itemId: "item-id-1",
                  payerId: "member-id-3",
                ),
              ],
            ),
          ],
        ),
        memberTemplate.copyWith(
          id: "member-id-2",
          items: [
            itemTemplate.copyWith(
              id: "item-id-2",
              memberId: "member-id-2",
              price: Decimal.fromInt(50),
              futureTransactions: [
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-4",
                  itemId: "item-id-2",
                  payerId: "member-id-1",
                ),
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-5",
                  itemId: "item-id-2",
                  payerId: "member-id-2",
                ),
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-6",
                  itemId: "item-id-2",
                  payerId: "member-id-3",
                ),
              ],
            ),
          ],
        ),
        memberTemplate.copyWith(
          id: "member-id-3",
          items: [
            itemTemplate.copyWith(
              id: "item-id-3",
              memberId: "member-id-3",
              price: Decimal.fromInt(50),
              futureTransactions: [
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-7",
                  itemId: "item-id-3",
                  payerId: "member-id-1",
                ),
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-8",
                  itemId: "item-id-2",
                  payerId: "member-id-2",
                ),
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-9",
                  itemId: "item-id-2",
                  payerId: "member-id-3",
                ),
              ],
            ),
          ],
        ),
      ];

      var futurePayments = trip.getFuturePayments();
      var balances = [];

      var memberBalance1 = Decimal.fromInt(-100) +
          sumIfNotEmpty(futurePayments.where((x) => x.payee.id == "member-id-1").map((x) => x.amount)) -
          sumIfNotEmpty(futurePayments.where((x) => x.payer.id == "member-id-1").map((x) => x.amount));
      var memberBalance2 = Decimal.fromInt(-50) +
          sumIfNotEmpty(futurePayments.where((x) => x.payee.id == "member-id-2").map((x) => x.amount)) -
          sumIfNotEmpty(futurePayments.where((x) => x.payer.id == "member-id-2").map((x) => x.amount));
      var memberBalance3 = Decimal.fromInt(-50) +
          sumIfNotEmpty(futurePayments.where((x) => x.payee.id == "member-id-3").map((x) => x.amount)) -
          sumIfNotEmpty(futurePayments.where((x) => x.payer.id == "member-id-3").map((x) => x.amount));

      balances.add(memberBalance1);
      balances.add(memberBalance2);
      balances.add(memberBalance3);

      Decimal minValue = balances.reduce((a, b) => a < b ? a : b);
      Decimal maxValue = balances.reduce((a, b) => a > b ? a : b);

      expect(maxValue - minValue < Decimal.fromInt(1), isTrue);
    });

    test('Three users with more items where some items is shared with a subset of users should still result in minimum number of future transactions test', () {
      var trip = tripTemplate.copyWith();
      trip.members = [
        memberTemplate.copyWith(
          id: "member-id-1",
          items: [
            itemTemplate.copyWith(
              id: "item-id-1",
              price: Decimal.fromInt(90),
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
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-3",
                  itemId: "item-id-1",
                  payerId: "member-id-3",
                ),
              ],
            ),
          ],
        ),
        memberTemplate.copyWith(
          id: "member-id-2",
          items: [
            itemTemplate.copyWith(
              id: "item-id-2",
              memberId: "member-id-2",
              price: Decimal.fromInt(30),
              futureTransactions: [
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-4",
                  itemId: "item-id-2",
                  payerId: "member-id-1",
                ),
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-5",
                  itemId: "item-id-2",
                  payerId: "member-id-2",
                ),
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-6",
                  itemId: "item-id-2",
                  payerId: "member-id-3",
                ),
              ],
            ),
          ],
        ),
        memberTemplate.copyWith(
          id: "member-id-3",
          items: [
            itemTemplate.copyWith(
              id: "item-id-3",
              memberId: "member-id-3",
              price: Decimal.fromInt(20),
              futureTransactions: [
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-8",
                  itemId: "item-id-2",
                  payerId: "member-id-2",
                ),
                futureTransactionTemplate.copyWith(
                  id: "future-transaction-9",
                  itemId: "item-id-2",
                  payerId: "member-id-3",
                ),
              ],
            ),
          ],
        ),
      ];

      var futurePayments = trip.getFuturePayments();

      expect(futurePayments.length, equals(2));
      expect(
        futurePayments.any(
          (futurePayment) => futurePayment.payer.id == "member-id-2" && futurePayment.payee.id == "member-id-1" && futurePayment.amount == Decimal.fromInt(20),
        ),
        isTrue,
      );
      expect(
        futurePayments.any(
          (futurePayment) => futurePayment.payer.id == "member-id-3" && futurePayment.payee.id == "member-id-1" && futurePayment.amount == Decimal.fromInt(30),
        ),
        isTrue,
      );
    });
  });
}

Decimal sumIfNotEmpty(Iterable<Decimal> list) {
  return list.isNotEmpty ? list.reduce((a, b) => a + b) : Decimal.zero;
}
