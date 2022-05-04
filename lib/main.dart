import 'dart:convert';

import 'package:prueba/models/Propiedad.dart';
import 'package:prueba/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:prueba/pages/inicio.dart';
import 'package:http/http.dart' as http;
import 'package:prueba/models/Propiedad.dart';
import 'package:prueba/pages/skateshop.dart';
import 'package:prueba/pages/skateunit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'JASSC',
      initialRoute: 'login',
      routes: {
        'login': (_) => LoginPage(),
        // 'skateunit': (_) => SkateUnit(),
        // 'skateshop': (_) => SkateShop(),
      },
    );
  }
}
