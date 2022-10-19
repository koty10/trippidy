import 'package:anti_forgetter/model/item_model.dart';
import 'package:anti_forgetter/model/list_item_model.dart';
import 'package:anti_forgetter/model/trip_model.dart';
import 'package:anti_forgetter/model/trip_member_list_model.dart';
import 'package:anti_forgetter/model/user_model.dart';

class DummyDataService {
  List<TripModel> getTrips() {
    return [
      TripModel(
        name: "Lipno 2022",
        memberListCollection: [
          TripMemberListModel(
            user: UserModel(id: 1, name: "Pepa"),
            listItemCollection: [
              ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Sekera", category: "Vybavení"),
              ),
              ListItemModel(
                amount: 4,
                checked: false,
                item: ItemModel(name: "Triko", category: "Oblečení"),
              ),
              ListItemModel(
                amount: 10,
                checked: true,
                item: ItemModel(name: "Ponožky", category: "Oblečení"),
              ),
            ],
          ),
          TripMemberListModel(
            user: UserModel(id: 2, name: "Michal"),
            listItemCollection: [
              ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Ručník", category: "Koupání"),
              ),
              ListItemModel(
                amount: 2,
                checked: false,
                item: ItemModel(name: "Tepláky", category: "Oblečení"),
              ),
            ],
          ),
          TripMemberListModel(
            user: UserModel(id: 3, name: "Alex"),
            listItemCollection: [
              ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Pyžamo", category: "Oblečení"),
              ),
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
            ),
          ],
        ),
      ),
      TripModel(
        name: "Itálie 2021",
        memberListCollection: [
          TripMemberListModel(
            user: UserModel(id: 5, name: "Daniel"),
            listItemCollection: [
              ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Vývrtka", category: "Vybavení"),
              ),
              ListItemModel(
                amount: 4,
                checked: false,
                item: ItemModel(name: "Triko", category: "Oblečení"),
              ),
              ListItemModel(
                amount: 2,
                checked: true,
                item: ItemModel(name: "Kraťasy", category: "Oblečení"),
              ),
            ],
          ),
          TripMemberListModel(
            user: UserModel(id: 6, name: "Monča"),
            listItemCollection: [
              ListItemModel(
                amount: 2,
                checked: false,
                item: ItemModel(name: "Ručník", category: "Jídlo"),
              ),
              ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Fén", category: "Vybavení"),
              ),
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
            ),
          ],
        ),
      ),
    ];
  }

  Map<String, List<ListItemModel>> getMyListItems() {
    var tmp = getTrips()[0].myListCollection.listItemCollection;

    var dict = <String, List<ListItemModel>>{};
    for (var element in tmp) {
      dict[element.item.category] != null
          ? dict[element.item.category]?.add(element)
          : dict.putIfAbsent(element.item.category, () => [element]);
    }
    return dict;
  }

  List<ListItemModel> getOurListItems() {
    return [
      ListItemModel(
        amount: 1,
        checked: false,
        item: ItemModel(name: "Něco našeho", category: "Vybavení"),
      ),
    ];
  }

  Map<String, List<ListItemModel>> getListItemsForUser({required userId}) {
    var tmp = getTrips()
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
