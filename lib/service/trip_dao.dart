import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trippidy/model/dto/trip_dto.dart';
import 'package:trippidy/model/dto/user_dto.dart';
import 'package:trippidy/model/member.dart';
import 'package:trippidy/model/trip.dart';
import 'package:trippidy/model/user.dart';

class TripDao {
  Future<List<Trip>> getMyTrips() async {
    var db = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await db.collection("users").doc("ia4OZLsqVsIrD2Ss6Ncw").get();
    var userDto = UserDto.fromMap(snapshot.data()!);

    List<TripDto> trips = [];
    for (var trip in userDto.trips) {
      var query = await db.collection("trips").doc(trip).get();
      var data = query.data();
      if (data != null) {
        var tripDto = TripDto.fromMap(data);
        trips.add(tripDto);
        print(tripDto.toJson());
      }

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
      for (var member in trip.members) {
        //Firebase call for user from id
        var result =
            (await db.doc("users/${member.user}").snapshots().first).data();
        if (result != null) {
          var userDto = UserDto.fromMap(result);
          var user = User.fromDto(userDto);
          members.add(Member.fromDto(member, user));
        }

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
