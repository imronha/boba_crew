// import 'dart:html';

import 'package:boba_crew/services/database.dart';
import 'package:boba_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:boba_crew/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:boba_crew/models/user.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<int> sweetLevelPercentages = [0, 25, 50, 75, 100];
  final List<int> iceLevelPercentages = [0, 25, 50, 75, 100];

  // Form Values
  String _currentName;
  int _currentSweetness;
  int _currentIcelevel;

  // Streambuilder can be used to listen to streams instead of provider if only one specific widget needs to listen to the stream
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          // Check to see if there is data being passed down the stream (i.e check if data is in the snapshot)
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  Text('Update your boba settings',
                      style: TextStyle(fontSize: 18.0)),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Your name + drink name'),
                    validator: (val) =>
                        val.isEmpty ? 'Please enter your name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  // Dropdown
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSweetness ?? userData.sweetLevel,
                    items: sweetLevelPercentages.map((percent) {
                      return DropdownMenuItem(
                        value: percent,
                        child: Text('$percent% sweetness'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSweetness = val),
                  ),
                  SizedBox(height: 10.0),
                  // Dropdown and slider
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentIcelevel ?? userData.iceLevel,
                    items: iceLevelPercentages.map((percent) {
                      return DropdownMenuItem(
                        value: percent,
                        child: Text('$percent% ice'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentIcelevel = val),
                  ),
                  RaisedButton(
                      color: Colors.red,
                      child:
                          Text('Update', style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentIcelevel ?? userData.iceLevel,
                              _currentSweetness ?? userData.sweetLevel);
                          Navigator.pop(context);
                        }
                        // print(_currentName);
                        // print(_currentSweetness);
                        // print(_currentIcelevel);
                      })
                ]));
          } else {
            return Loading();
          }
        });
  }
}
