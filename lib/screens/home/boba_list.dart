import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:boba_crew/models/boba.dart';
import 'package:boba_crew/screens/home/boba_tile.dart';

class BobaList extends StatefulWidget {
  @override
  _BobaListState createState() => _BobaListState();
}

class _BobaListState extends State<BobaList> {
  @override
  Widget build(BuildContext context) {
    final bobas = Provider.of<List<Boba>>(context) ?? [];

    return ListView.builder(
      itemCount: bobas.length,
      itemBuilder: (context, index) {
        return BobaTile(boba: bobas[index]);
      },
    );
    // bobas.forEach((boba) {
    //   print(boba.name);
    //   print(boba.iceLevel);
    //   print(boba.sweetLevel);
    // });
    //print(bobas.documents);
    // for (var doc in bobas.documents) {
    //   print(doc.data);
    // }
    // return Container();
  }
}
