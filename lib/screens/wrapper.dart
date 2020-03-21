import 'package:boba_crew/screens/authenticate/authenticate.dart';
import 'package:boba_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boba_crew/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Listen to User stream for authentication
    final user = Provider.of<User>(context);

    // Return home widget or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
