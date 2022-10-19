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
            user: UserModel(name: "Pepa"),
            listItemCollection: [
              ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Sekera"),
              ),
              ListItemModel(
                amount: 4,
                checked: false,
                item: ItemModel(name: "Triko"),
              ),
              ListItemModel(
                amount: 10,
                checked: true,
                item: ItemModel(name: "Ponožky"),
              ),
            ],
          ),
          TripMemberListModel(
            user: UserModel(name: "Michal"),
            listItemCollection: [
              ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Ručník"),
              ),
              ListItemModel(
                amount: 2,
                checked: false,
                item: ItemModel(name: "Tepláky"),
              ),
            ],
          ),
          TripMemberListModel(
            user: UserModel(name: "Alex"),
            listItemCollection: [
              ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Pyžamo"),
              ),
            ],
          ),
        ],
      ),
      TripModel(
        name: "Itálie 2021",
        memberListCollection: [
          TripMemberListModel(
            user: UserModel(name: "Daniel"),
            listItemCollection: [
              ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Vývrtka"),
              ),
              ListItemModel(
                amount: 4,
                checked: false,
                item: ItemModel(name: "Triko"),
              ),
              ListItemModel(
                amount: 2,
                checked: true,
                item: ItemModel(name: "Kraťasy"),
              ),
            ],
          ),
          TripMemberListModel(
            user: UserModel(name: "Monča"),
            listItemCollection: [
              ListItemModel(
                amount: 2,
                checked: false,
                item: ItemModel(name: "Ručník"),
              ),
              ListItemModel(
                amount: 1,
                checked: false,
                item: ItemModel(name: "Fén"),
              ),
            ],
          ),
        ],
      ),
    ];
  }
}
