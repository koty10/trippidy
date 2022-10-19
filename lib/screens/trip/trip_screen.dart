import 'package:anti_forgetter/model/trip_model.dart';
import 'package:anti_forgetter/screens/members_list/members_list_screen.dart';
import 'package:anti_forgetter/screens/my_list/my_list_screen.dart';
import 'package:anti_forgetter/screens/trip/components/member_list_tile.dart';
import 'package:flutter/material.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key, required this.currentTrip});

  final TripModel currentTrip;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        title: Text(currentTrip.name),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://source.unsplash.com/50x50/?portrait',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 200,
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                InkWell(
                  child: const MemberListTile(
                    title: "Můj seznam",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyListScreen(
                          currentTrip: currentTrip,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  child: const MemberListTile(
                    title: "Společný seznam",
                  ),
                  onTap: () {
                    // TODO
                  },
                ),
              ],
            ),
          ),
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  'Seznamy ostatních členů',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: currentTrip.memberListCollection.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  child: MemberListTile(
                    title: currentTrip.memberListCollection[index].user.name,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MembersListScreen(
                          currentTrip: currentTrip,
                          currentMember:
                              currentTrip.memberListCollection[index].user,
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 16),
            ),
          ),
        ],
      ),
    );
  }
}
