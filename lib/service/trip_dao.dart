import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trippidy/model/dto/trip_dto.dart';
import 'package:trippidy/model/dto/user_dto.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/model/trip.dart';

class TripDao {
  Future<List<Trip>> getMyTrips() async {
    var db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection("users").doc("FKhyGx4kkHQM2WjZ2EI2").get();
    var userDto = UserDto.fromMap(snapshot.data()!);

    List<TripDto> trips = [];
    for (var trip in userDto.trips) {
      var f = db.collection("trips").where("id", isEqualTo: trip).snapshots();

      print(f.toString());

      //List<TripDto> tri =
      //await f.map((event) => event.docs.first.data() as TripDto).toList();

      //trips.add(f.docs.first.data() as TripDto);
    }

    // tripDto.members
    //       .map(
    //         (memberId) async => Member.fromDto(
    //           (await FirebaseFirestore.instance.doc("members/$memberId").get())
    //               as MemberDto,
    //         ),
    //       )
    //       .toList(),

    List<Trip> finalTrips = [];
    for (var trip in trips) {
      List<Member> members = [];
      for (var memberId in trip.members) {
        //Firebase call for user from id
        var result = await db.doc("users/$memberId").snapshots().first;
        members.add(Member.fromMap(result.data()!));
        // Returns user dto
        // var user = User.fromDTO()
        // users.add(user)
      }
      // finalTRips.add( Trip.fromDTo(tripDTO, List<USer> users))
      finalTrips.add(Trip.fromDto(trip, members));
    }
    return finalTrips;
  }
}
