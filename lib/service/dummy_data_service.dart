import 'package:anti_forgetter/model/item_model.dart';
import 'package:anti_forgetter/model/list_item_model.dart';
import 'package:anti_forgetter/model/trip_model.dart';
import 'package:anti_forgetter/model/trip_member_list_model.dart';
import 'package:anti_forgetter/model/user_model.dart';

class DummyDataService {
  List<TripModel> getTrips() {
    return [
      TripModel(
        id: 1,
        name: "Lipno 2022",
        memberListCollection: [
          TripMemberListModel(
            user: UserModel(id: 1, name: "Pepa"),
            listItemCollection: [
              ListItemModel(
                  amount: 1,
                  checked: false,
                  item: ItemModel(name: "Sekera", category: "Vybavení"),
                  private: false,
                  shared: false,
                  userId: 1),
              ListItemModel(
                  amount: 4,
                  checked: false,
                  item: ItemModel(name: "Triko", category: "Oblečení"),
                  private: false,
                  shared: false,
                  userId: 1),
              ListItemModel(
                  amount: 10,
                  checked: true,
                  item: ItemModel(name: "Ponožky", category: "Oblečení"),
                  private: false,
                  shared: false,
                  userId: 1),
            ],
          ),
          TripMemberListModel(
            user: UserModel(id: 2, name: "Michal"),
            listItemCollection: [
              ListItemModel(
                  amount: 1,
                  checked: false,
                  item: ItemModel(name: "Ručník", category: "Koupání"),
                  private: false,
                  shared: false,
                  userId: 2),
              ListItemModel(
                  amount: 2,
                  checked: false,
                  item: ItemModel(name: "Tepláky", category: "Oblečení"),
                  private: false,
                  shared: false,
                  userId: 2),
            ],
          ),
          TripMemberListModel(
            user: UserModel(id: 3, name: "Alex"),
            listItemCollection: [
              ListItemModel(
                  amount: 1,
                  checked: false,
                  item: ItemModel(name: "Pyžamo", category: "Oblečení"),
                  private: false,
                  shared: false,
                  userId: 3),
            ],
          ),
        ],
        myListCollection: TripMemberListModel(
          user: UserModel(id: 4, name: "Admin"),
          listItemCollection: [
            ListItemModel(
                amount: 10,
                checked: false,
                item: ItemModel(name: "Rohlíky", category: "Jídlo"),
                private: false,
                shared: false,
                userId: 4),
          ],
        ),
      ),
      TripModel(
        id: 2,
        name: "Itálie 2021",
        memberListCollection: [
          TripMemberListModel(
            user: UserModel(id: 5, name: "Daniel"),
            listItemCollection: [
              ListItemModel(
                  amount: 1,
                  checked: false,
                  item: ItemModel(name: "Vývrtka", category: "Vybavení"),
                  private: false,
                  shared: true,
                  userId: 5),
              ListItemModel(
                  amount: 4,
                  checked: false,
                  item: ItemModel(name: "Triko", category: "Oblečení"),
                  private: false,
                  shared: false,
                  userId: 5),
              ListItemModel(
                  amount: 2,
                  checked: true,
                  item: ItemModel(name: "Kraťasy", category: "Oblečení"),
                  private: false,
                  shared: true,
                  userId: 5),
            ],
          ),
          TripMemberListModel(
            user: UserModel(id: 6, name: "Monča"),
            listItemCollection: [
              ListItemModel(
                  amount: 2,
                  checked: false,
                  item: ItemModel(name: "Ručník", category: "Jídlo"),
                  private: false,
                  shared: false,
                  userId: 6),
              ListItemModel(
                  amount: 1,
                  checked: false,
                  item: ItemModel(name: "Fén", category: "Vybavení"),
                  private: false,
                  shared: false,
                  userId: 6),
            ],
          ),
        ],
        myListCollection: TripMemberListModel(
          user: UserModel(id: 7, name: "Admin"),
          listItemCollection: [
            ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Chleba", category: "Jídlo"),
                private: false,
                shared: true,
                userId: 7),
            ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Rohlíky", category: "Jídlo"),
                private: false,
                shared: false,
                userId: 7),
            ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Salám", category: "Jídlo"),
                private: false,
                shared: false,
                userId: 7),
            ListItemModel(
                amount: 1,
                checked: true,
                item: ItemModel(name: "Triko", category: "Oblečení"),
                private: false,
                shared: true,
                userId: 7),
            ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Kraťasy", category: "Oblečení"),
                private: false,
                shared: false,
                userId: 7),
          ],
        ),
      ),
    ];
  }

  Map<String, List<ListItemModel>> getMyListItems({required int tripId}) {
    var tmp = getTrips()
        .firstWhere((element) => element.id == tripId)
        .myListCollection
        .listItemCollection;

    var dict = <String, List<ListItemModel>>{};
    for (var element in tmp) {
      dict[element.item.category] != null
          ? dict[element.item.category]?.add(element)
          : dict.putIfAbsent(element.item.category, () => [element]);
    }
    return dict;
  }

  Map<String, List<ListItemModel>> getOurListItems({required int tripId}) {
    var tmp = getTrips()
        .where((trip) => trip.id == tripId)
        .expand((element1) =>
            element1.memberListCollection + [element1.myListCollection])
        .expand((element2) => element2.listItemCollection)
        .where((element3) => element3.shared)
        .toList();

    var dict = <String, List<ListItemModel>>{};
    for (var element in tmp) {
      dict[element.item.category] != null
          ? dict[element.item.category]?.add(element)
          : dict.putIfAbsent(element.item.category, () => [element]);
    }
    return dict;
  }

  Map<String, List<ListItemModel>> getListItemsForUser(
      {required int userId, required int tripId}) {
    var tmp = getTrips()
        .where((trip) => trip.id == tripId)
        .expand((e) => e.memberListCollection)
        .where((element) => element.user.id == userId)
        .expand((element2) => element2.listItemCollection)
        .toList();

    var dict = <String, List<ListItemModel>>{};
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
