import 'package:flutter/material.dart';
import 'package:boba_crew/models/boba.dart';

class BobaTile extends StatelessWidget {
  final Boba boba;
  BobaTile({this.boba});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25.0,
                backgroundColor: Colors.brown[boba.sweetLevel],
                backgroundImage: AssetImage('assets/bobalogo.png'),
              ),
              title: Text(boba.name),
              subtitle: Text(
                  'Likes ${boba.sweetLevel}% sweetness and ${boba.iceLevel}% ice.'),
            )));
  }
}
