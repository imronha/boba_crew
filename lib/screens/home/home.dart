// This widget will wrap the boba list widget and the settings form
import 'package:boba_crew/screens/home/settings_form.dart';
import 'package:boba_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:boba_crew/services/database.dart';
import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boba_crew/screens/home/boba_list.dart';
import 'package:boba_crew/models/boba.dart';

class Home extends StatelessWidget {
  // Need an instance of the authservice in this widget
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: SettingsForm());
          });
    }

    return StreamProvider<List<Boba>>.value(
      value: DatabaseService().bobas,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Boba Crew'),
          backgroundColor: Colors.teal,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/bobabg.png'),
          //     fit: BoxFit.fitWidth,
          //   ),
          // ),
          child: BobaList(),
        ),
      ),
    );
  }
}
