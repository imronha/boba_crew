import 'package:flutter/material.dart';
import 'package:boba_crew/services/auth.dart';
import 'package:boba_crew/shared/constants.dart';
import 'package:boba_crew/shared/loading.dart';

class Register extends StatefulWidget {
  //  Create constructor for sign-in/register toggle
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  bool loading = false;

  // Used for form validation
  final _formKey = GlobalKey<FormState>();

  // TextField state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Color(0xffAAF1DF),
            appBar: AppBar(
              backgroundColor: Colors.teal,
              elevation: 0.0,
              title: Text('Register'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Sign In'))
              ],
            ),
            body: Container(
                // Create Login form
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/bobaregister.jpeg',
                        height: 225,
                        width: 225,
                      ),
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
                            RaisedButton(
                              color: Colors.red,
                              child: Text(
                                'Register',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() => loading = true);
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                          email, password);
                                  if (result == null) {
                                    setState(() {
                                      error = 'Please enter a valid email';
                                      loading = false;
                                    });
                                  }
                                }
                                // print(email);
                                // print(password);
                              },
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
