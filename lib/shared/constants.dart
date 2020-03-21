// This dart file will contain all the constants that will be shared among all widgets

import 'package:flutter/material.dart';

// Custom variable for text input / field decoration
const textInputDecoration = InputDecoration(
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 2.0)));
