import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prueba/models/Fechas.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:prueba/pages/skateshop.dart';
import 'package:prueba/widgets/Header.dart';

import 'login.dart';

class DeudasPage extends StatefulWidget {
  final String manzana;
  final String lote;
  final String suministro;

  DeudasPage(this.manzana, this.lote, this.suministro, {Key? key})
      : super(key: key);

  @override
  _DeudasPageState createState() => _DeudasPageState();
}

class _DeudasPageState extends State<DeudasPage> {
  late Future<List<Fecha>> listadofecha;
  Future<List<Fecha>> getFechas() async {
    final response = await http.get(
        "https://www.jass-curipata.online/api/propiedades/" +
            widget.manzana +
            "/" +
            widget.lote +
            "/" +
            widget.suministro);
    List<Fecha> fechas = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      var date = DateTime.now();
      var fechaad = DateTime.parse(jsonData[0]["fecha_adeudo"]);
      for (var i = fechaad;
          i.compareTo(date) < 0;
          i = DateTime(i.year, i.month + 1, i.day)) {
        fechas.add(Fecha(i.toString()));
      }
      return fechas;
    } else {
      throw Exception("fallo la conexion");
    }
  }

  @override
  void initState() {
    super.initState();
    listadofecha = getFechas();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: listadofecha,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: _listaFechas(snapshot.data),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Wrap(children: [
                Text("La propiedad no tiene deudas pendientes",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue.shade800)),
                Image.asset("assets/images/tristeza.gif")
              ]),
            );
          }
          return Center(
            child: Image.asset("assets/images/cargar.gif"),
          );
        });
  }

  List<Widget> _listaFechas(data) {
    List<Widget> fechas = [];
    for (var fecha in data) {
      fechas.add(Card(
          color: Colors.grey.shade800,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Icon(Icons.monetization_on_rounded,
                        size: 20.0, color: Colors.cyanAccent),
                  ),
                  Expanded(
                    child: Text(
                      "DEUDA",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.cyanAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Icon(Icons.date_range_rounded,
                        size: 20.0, color: Colors.cyanAccent),
                  ),
                  Expanded(
                    child: Text(
                      "Inicio de deuda : " +
                          DateFormat.yMMMMd()
                              .format(DateTime.parse(fecha.fecha)),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Icon(Icons.calendar_today_rounded,
                        size: 20.0, color: Colors.cyanAccent),
                  ),
                  Expanded(
                    child: Text(
                      "Mes correspondiente : " +
                          DateFormat.MMMM().format(
                            DateTime.parse(fecha.fecha),
                          ),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ])));
    }
    return fechas;
  }
}
