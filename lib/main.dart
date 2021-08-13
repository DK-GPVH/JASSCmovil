import 'package:prueba/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:prueba/pages/signup.dart';
import 'package:prueba/pages/skateunit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHOPPINGXD',
      initialRoute: 'login',
      routes: {
        'login': (_) => LoginPage(),
        'signup': (_) => SignUpPage(),
        'skateunit': (_) => SkateUnit(),
        //'skateshop': (_) =>SkateShop(),
      },
    );
  }
}
