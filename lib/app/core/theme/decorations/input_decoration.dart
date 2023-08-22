import 'package:flutter/material.dart';

const InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  fillColor: Colors.white,
  filled: true,
  prefixIconColor: Colors.indigoAccent,
  labelStyle: TextStyle(fontSize: 14, height: 20 / 14),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
    borderSide: BorderSide(color: Colors.white, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
    borderSide: BorderSide(color: Colors.indigoAccent, width: 1.0),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
  ),
);

const InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32),
    ),
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32),
    ),
    borderSide: BorderSide(color: Colors.white, width: 1.0),
  ),
);

const InputDecorationTheme leafInputDecorationTheme = InputDecorationTheme(
  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  fillColor: Colors.white,
  filled: true,
  prefixIconColor: Colors.indigoAccent,
  labelStyle: TextStyle(fontSize: 14, height: 20 / 14),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
    borderSide: BorderSide(color: Colors.white, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
    borderSide: BorderSide(color:Colors.indigoAccent, width: 1.0),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
  ),
);
