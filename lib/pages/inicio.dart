import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:prueba/models/Propiedad.dart';
import 'package:prueba/pages/skateshop.dart';
import 'package:prueba/models/Fechas.dart';
import 'package:prueba/pages/carrito.dart';
import 'package:prueba/pages/login.dart';
import 'package:prueba/pages/skateunit.dart';
import 'package:prueba/models/Propiedad.dart';

import 'categoria.dart';

class Inicio extends StatefulWidget {
  final String manzana;
  final String lote;
  final String suministro;

  Inicio(this.manzana, this.lote, this.suministro, {Key? key})
      : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  int _currentIndex = 0;
  final List<Widget> pages = [
    PropiedadPage(manzana.text, lote.text, suministro.text),
    DeudasPage(manzana.text, lote.text, suministro.text),
    ClientePage(manzana.text, lote.text, suministro.text),
    CategoriaPage(manzana.text, lote.text, suministro.text),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JASSC',
        home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: const Text('JASSC',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                )),
            actions: <Widget>[
              Row(
                children: [
                  Text("SALIR"),
                  IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    color: Colors.white,
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => LoginPage())),
                  ),
                ],
              ),
            ],
            backgroundColor: Colors.black,
          ),
          body: pages[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: onTapTapped,
            backgroundColor: Colors.black,
            fixedColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.house_rounded, color: Colors.white),
                label: 'Propiedad',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.date_range, color: Colors.white),
                label: 'Deudas',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_outlined, color: Colors.white),
                label: 'Cliente',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.location_city, color: Colors.white),
                label: 'Categoria',
              ),
            ],
          ),
        ));
  }

  void onTapTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
