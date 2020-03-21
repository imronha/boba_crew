import 'package:boba_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:boba_crew/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  // Check to see if user is signed in
  bool showSignIn = true;

  // Toggle bool val if user is signed in
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
