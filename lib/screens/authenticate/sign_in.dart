import 'package:boba_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:boba_crew/shared/constants.dart';
import 'package:boba_crew/shared/loading.dart';

class SignIn extends StatefulWidget {
  //  Create constructor for sign-in/register toggle
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // TextField state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    // Check to see if loading. If true, show loading screen, false show scaffold
    return loading
        ? Loading()
        : Scaffold(
            //resizeToAvoidBottomPadding: false,
            backgroundColor: Color(0xffBDF1FC),
            appBar: AppBar(
              backgroundColor: Colors.teal,
              elevation: 0.0,
              title: Text('Sign In'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Register'))
              ],
            ),
            body: Container(
                // Create Login form
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                // SingleChildScrollView widget to prevent overflow with keyboard
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Image(image: AssetImage('assets/bobahome.jpeg')),
                      Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Email"),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter an email' : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                }),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                                decoration: textInputDecoration.copyWith(
                                    hintText: "Password"),
                                validator: (val) => val.length < 6
                                    ? 'Enter a password that is at least 6 characters long'
                                    : null,
                                obscureText: true,
                                onChanged: (val) {
                                  setState(() => password = val);
                                }),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  child: RaisedButton(
                                    color: Colors.teal,
                                    child: Text(
                                      'Sign In',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() => loading = true);
                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
                                                email, password);
                                        if (result == null) {
                                          setState(() {
                                            error =
                                                'Could not sign in with those credentials';
                                            loading = false;
                                          });
                                        }
                                      }
                                      // print(email);
                                      // print(password);
                                    },
                                  ),
                                ),
                                Container(
                                  child: RaisedButton(
                                    padding: EdgeInsets.all(10.0),
                                    color: Colors.red,
                                    child: Text(
                                      'Forgot?',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      widget.toggleView();
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14.0),
                            )
                          ])),
                    ],
                  ),
                )));
  }
}
