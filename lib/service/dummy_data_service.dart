import 'package:anti_forgetter/model/item_base_model.dart';
import 'package:anti_forgetter/model/item_model.dart';
import 'package:anti_forgetter/model/trip_model.dart';
import 'package:anti_forgetter/model/member_model.dart';
import 'package:anti_forgetter/model/user_model.dart';

class DummyDataService {
  List<TripModel> getTrips() {
    return [
      TripModel(
        id: 1,
        name: "Lipno 2022",
        userItemsCollection: [
          MemberModel(
            user: UserModel(id: 1, name: "Pepa"),
            items: [
              ItemModel(
                  amount: 1,
                  checked: false,
                  item: ItemBaseModel(name: "Sekera", category: "Vybavení"),
                  private: false,
                  shared: false,
                  userId: 1),
              ItemModel(
                  amount: 4,
                  checked: false,
                  item: ItemBaseModel(name: "Triko", category: "Oblečení"),
                  private: false,
                  shared: false,
                  userId: 1),
              ItemModel(
                  amount: 10,
                  checked: true,
                  item: ItemBaseModel(name: "Ponožky", category: "Oblečení"),
                  private: false,
                  shared: false,
                  userId: 1),
            ],
          ),
          MemberModel(
            user: UserModel(id: 2, name: "Michal"),
            items: [
              ItemModel(
                  amount: 1,
                  checked: false,
                  item: ItemBaseModel(name: "Ručník", category: "Koupání"),
                  private: false,
                  shared: false,
                  userId: 2),
              ItemModel(
                  amount: 2,
                  checked: false,
                  item: ItemBaseModel(name: "Tepláky", category: "Oblečení"),
                  private: false,
                  shared: false,
                  userId: 2),
            ],
          ),
          MemberModel(
            user: UserModel(id: 3, name: "Alex"),
            items: [
              ItemModel(
                  amount: 1,
                  checked: false,
                  item: ItemBaseModel(name: "Pyžamo", category: "Oblečení"),
                  private: false,
                  shared: false,
                  userId: 3),
            ],
          ),
        ],
        myListCollection: MemberModel(
          user: UserModel(id: 4, name: "Admin"),
          items: [
            ItemModel(
                amount: 10,
                checked: false,
                item: ItemBaseModel(name: "Rohlíky", category: "Jídlo"),
                private: false,
                shared: false,
                userId: 4),
          ],
        ),
      ),
      TripModel(
        id: 2,
        name: "Itálie 2021",
        userItemsCollection: [
          MemberModel(
            user: UserModel(id: 5, name: "Daniel"),
            items: [
              ItemModel(
                  amount: 1,
                  checked: false,
                  item: ItemBaseModel(name: "Vývrtka", category: "Vybavení"),
                  private: false,
                  shared: true,
                  userId: 5),
              ItemModel(
                  amount: 4,
                  checked: false,
                  item: ItemBaseModel(name: "Triko", category: "Oblečení"),
                  private: false,
                  shared: false,
                  userId: 5),
              ItemModel(
                  amount: 2,
                  checked: true,
                  item: ItemBaseModel(name: "Kraťasy", category: "Oblečení"),
                  private: false,
                  shared: true,
                  userId: 5),
            ],
          ),
          MemberModel(
            user: UserModel(id: 6, name: "Monča"),
            items: [
              ItemModel(
                  amount: 2,
                  checked: false,
                  item: ItemBaseModel(name: "Ručník", category: "Jídlo"),
                  private: false,
                  shared: false,
                  userId: 6),
              ItemModel(
                  amount: 1,
                  checked: false,
                  item: ItemBaseModel(name: "Fén", category: "Vybavení"),
                  private: false,
                  shared: false,
                  userId: 6),
            ],
          ),
        ],
        myListCollection: MemberModel(
          user: UserModel(id: 7, name: "Admin"),
          items: [
            ItemModel(
                amount: 1,
                checked: false,
                item: ItemBaseModel(name: "Chleba", category: "Jídlo"),
                private: false,
                shared: true,
                userId: 7),
            ItemModel(
                amount: 1,
                checked: false,
                item: ItemBaseModel(name: "Rohlíky", category: "Jídlo"),
                private: false,
                shared: false,
                userId: 7),
            ItemModel(
                amount: 1,
                checked: false,
                item: ItemBaseModel(name: "Salám", category: "Jídlo"),
                private: false,
                shared: false,
                userId: 7),
            ItemModel(
                amount: 1,
                checked: true,
                item: ItemBaseModel(name: "Triko", category: "Oblečení"),
                private: false,
                shared: true,
                userId: 7),
            ItemModel(
                amount: 1,
                checked: false,
                item: ItemBaseModel(name: "Kraťasy", category: "Oblečení"),
                private: false,
                shared: false,
                userId: 7),
          ],
        ),
      ),
    ];
  }

  Map<String, List<ItemModel>> getMyListItems({required int tripId}) {
    var tmp = getTrips()
        .firstWhere((element) => element.id == tripId)
        .myListCollection
        .items;

    var dict = <String, List<ItemModel>>{};
    for (var element in tmp) {
      dict[element.item.category] != null
          ? dict[element.item.category]?.add(element)
          : dict.putIfAbsent(element.item.category, () => [element]);
    }
    return dict;
  }

  Map<String, List<ItemModel>> getOurListItems({required int tripId}) {
    var tmp = getTrips()
        .where((trip) => trip.id == tripId)
        .expand((element1) =>
            element1.userItemsCollection + [element1.myListCollection])
        .expand((element2) => element2.items)
        .where((element3) => element3.shared)
        .toList();

    var dict = <String, List<ItemModel>>{};
    for (var element in tmp) {
      dict[element.item.category] != null
          ? dict[element.item.category]?.add(element)
          : dict.putIfAbsent(element.item.category, () => [element]);
    }
    return dict;
  }

  Map<String, List<ItemModel>> getListItemsForUser(
      {required int userId, required int tripId}) {
    var tmp = getTrips()
        .where((trip) => trip.id == tripId)
        .expand((e) => e.userItemsCollection)
        .where((element) => element.user.id == userId)
        .expand((element2) => element2.items)
        .toList();

    var dict = <String, List<ItemModel>>{};
    for (var element in tmp) {
      dict[element.item.category] != null
          ? dict[element.item.category]?.add(element)
          : dict.putIfAbsent(element.item.category, () => [element]);
    }
    return dict;

    //return getTrips()
    //    .expand((e) => e.memberListCollection)
    //    .where((element) => element.user.id == userId)
    //    .expand((element2) => element2.listItemCollection)
    //    .toList();
  }
}
