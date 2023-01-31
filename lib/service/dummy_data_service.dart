// import 'package:hive/hive.dart';
// import 'package:trippidy/model/enum/role.dart';

// import '../model/category.dart';
// import '../model/item.dart';
// import '../model/member.dart';
// import '../model/trip.dart';
// import '../model/user.dart';

// class DummyDataService {
//   void initHiveDb() {
//     Hive.box<Trip>("trips").add(
//       Trip(
//         name: "Dovolena 2022",
//         members: [
//           Member(
//             user: User(id: 1, name: "Daniel"),
//             items: [
//               Item(
//                 id: 1,
//                 category: Category(id: 1, name: "Obleceni"),
//                 name: "Triko",
//                 checked: false,
//                 amount: 2,
//                 private: true,
//                 shared: false,
//                 userId: 1,
//               ),
//             ],
//             role: Role.admin,
//             id: 1,
//           ),
//           Member(
//             user: User(id: 2, name: "Pepa"),
//             items: [
//               Item(
//                 id: 2,
//                 category: Category(id: 2, name: "Naradi"),
//                 name: "Kladivo",
//                 checked: false,
//                 amount: 1,
//                 private: false,
//                 shared: true,
//                 userId: 2,
//               ),
//             ],
//             role: Role.member,
//             id: 2,
//           ),
//         ],
//         id: 1,
//       ),
//     );
//   }

//   // List<Trip> getTrips() {
//   //   return [
//   //     Trip(
//   //       id: 1,
//   //       name: "Lipno 2022",
//   //       memberListCollection: [
//   //         Member(
//   //           user: User(id: 1, name: "Pepa"),
//   //           listItemCollection: [
//   //             ListItemModel(
//   //                 amount: 1,
//   //                 checked: false,
//   //                 item: Item(name: "Sekera", category: "Vybavení"),
//   //                 private: false,
//   //                 shared: false,
//   //                 userId: 1),
//   //             ListItemModel(
//   //                 amount: 4,
//   //                 checked: false,
//   //                 item: Item(name: "Triko", category: "Oblečení"),
//   //                 private: false,
//   //                 shared: false,
//   //                 userId: 1),
//   //             ListItemModel(
//   //                 amount: 10,
//   //                 checked: true,
//   //                 item: Item(name: "Ponožky", category: "Oblečení"),
//   //                 private: false,
//   //                 shared: false,
//   //                 userId: 1),
//   //           ],
//   //         ),
//   //         Member(
//   //           user: User(id: 2, name: "Michal"),
//   //           listItemCollection: [
//   //             ListItemModel(
//   //                 amount: 1,
//   //                 checked: false,
//   //                 item: Item(name: "Ručník", category: "Koupání"),
//   //                 private: false,
//   //                 shared: false,
//   //                 userId: 2),
//   //             ListItemModel(
//   //                 amount: 2,
//   //                 checked: false,
//   //                 item: Item(name: "Tepláky", category: "Oblečení"),
//   //                 private: false,
//   //                 shared: false,
//   //                 userId: 2),
//   //           ],
//   //         ),
//   //         Member(
//   //           user: User(id: 3, name: "Alex"),
//   //           listItemCollection: [
//   //             ListItemModel(
//   //                 amount: 1,
//   //                 checked: false,
//   //                 item: Item(name: "Pyžamo", category: "Oblečení"),
//   //                 private: false,
//   //                 shared: false,
//   //                 userId: 3),
//   //           ],
//   //         ),
//   //       ],
//   //       myListCollection: Member(
//   //         user: User(id: 4, name: "Admin"),
//   //         listItemCollection: [
//   //           ListItemModel(
//   //               amount: 10,
//   //               checked: false,
//   //               item: Item(name: "Rohlíky", category: "Jídlo"),
//   //               private: false,
//   //               shared: false,
//   //               userId: 4),
//   //         ],
//   //       ),
//   //     ),
//   //     Trip(
//   //       id: 2,
//   //       name: "Itálie 2021",
//   //       memberListCollection: [
//   //         Member(
//   //           user: User(id: 5, name: "Daniel"),
//   //           listItemCollection: [
//   //             ListItemModel(
//   //                 amount: 1,
//   //                 checked: false,
//   //                 item: Item(name: "Vývrtka", category: "Vybavení"),
//   //                 private: false,
//   //                 shared: true,
//   //                 userId: 5),
//   //             ListItemModel(
//   //                 amount: 4,
//   //                 checked: false,
//   //                 item: Item(name: "Triko", category: "Oblečení"),
//   //                 private: false,
//   //                 shared: false,
//   //                 userId: 5),
//   //             ListItemModel(
//   //                 amount: 2,
//   //                 checked: true,
//   //                 item: Item(name: "Kraťasy", category: "Oblečení"),
//   //                 private: false,
//   //                 shared: true,
//   //                 userId: 5),
//   //           ],
//   //         ),
//   //         Member(
//   //           user: User(id: 6, name: "Monča"),
//   //           listItemCollection: [
//   //             ListItemModel(
//   //                 amount: 2,
//   //                 checked: false,
//   //                 item: Item(name: "Ručník", category: "Jídlo"),
//   //                 private: false,
//   //                 shared: false,
//   //                 userId: 6),
//   //             ListItemModel(
//   //                 amount: 1,
//   //                 checked: false,
//   //                 item: Item(name: "Fén", category: "Vybavení"),
//   //                 private: false,
//   //                 shared: false,
//   //                 userId: 6),
//   //           ],
//   //         ),
//   //       ],
//   //       myListCollection: Member(
//   //         user: User(id: 7, name: "Admin"),
//   //         listItemCollection: [
//   //           ListItemModel(
//   //               amount: 1,
//   //               checked: false,
//   //               item: Item(name: "Chleba", category: "Jídlo"),
//   //               private: false,
//   //               shared: true,
//   //               userId: 7),
//   //           ListItemModel(
//   //               amount: 1,
//   //               checked: false,
//   //               item: Item(name: "Rohlíky", category: "Jídlo"),
//   //               private: false,
//   //               shared: false,
//   //               userId: 7),
//   //           ListItemModel(
//   //               amount: 1,
//   //               checked: false,
//   //               item: Item(name: "Salám", category: "Jídlo"),
//   //               private: false,
//   //               shared: false,
//   //               userId: 7),
//   //           ListItemModel(
//   //               amount: 1,
//   //               checked: true,
//   //               item: Item(name: "Triko", category: "Oblečení"),
//   //               private: false,
//   //               shared: true,
//   //               userId: 7),
//   //           ListItemModel(
//   //               amount: 1,
//   //               checked: false,
//   //               item: Item(name: "Kraťasy", category: "Oblečení"),
//   //               private: false,
//   //               shared: false,
//   //               userId: 7),
//   //         ],
//   //       ),
//   //     ),
//   //   ];
//   // }

//   // Map<String, List<Item>> getMyListItems({required int tripId}) {
//   //   var tmp =
//   //       getTrips().firstWhere((element) => element.id == tripId).owner.items;

//   //   var dict = <String, List<Item>>{};
//   //   for (var element in tmp) {
//   //     dict[element.category.name] != null
//   //         ? dict[element.category.name]?.add(element)
//   //         : dict.putIfAbsent(element.category.name, () => [element]);
//   //   }
//   //   return dict;
//   // }

//   // Map<String, List<Item>> getOurListItems({required int tripId}) {
//   //   var tmp = getTrips()
//   //       .where((trip) => trip.id == tripId)
//   //       .expand((element1) => element1.members + [element1.owner])
//   //       .expand((element2) => element2.items)
//   //       .where((element3) => element3.shared)
//   //       .toList();

//   //   var dict = <String, List<Item>>{};
//   //   for (var element in tmp) {
//   //     dict[element.category.name] != null
//   //         ? dict[element.category.name]?.add(element)
//   //         : dict.putIfAbsent(element.category.name, () => [element]);
//   //   }
//   //   return dict;
//   // }

//   // Map<String, List<Item>> getListItemsForUser(
//   //     {required int userId, required int tripId}) {
//   //   var tmp = getTrips()
//   //       .where((trip) => trip.id == tripId)
//   //       .expand((e) => e.members)
//   //       .where((element) => element.user.id == userId)
//   //       .expand((element2) => element2.items)
//   //       .toList();

//   //   var dict = <String, List<Item>>{};
//   //   for (var element in tmp) {
//   //     dict[element.category.name] != null
//   //         ? dict[element.category.name]?.add(element)
//   //         : dict.putIfAbsent(element.category.name, () => [element]);
//   //   }
//   //   return dict;

//   //   //return getTrips()
//   //   //    .expand((e) => e.memberListCollection)
//   //   //    .where((element) => element.user.id == userId)
//   //   //    .expand((element2) => element2.listItemCollection)
//   //   //    .toList();
//   // }
// }
