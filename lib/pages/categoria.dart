import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prueba/models/Cliente.dart';
import 'package:prueba/models/Categoria.dart';
import 'package:prueba/models/Fechas.dart';
import 'package:prueba/pages/skateshop.dart';
import 'package:prueba/widgets/Header.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class CategoriaPage extends StatefulWidget {
  final String manzana;
  final String lote;
  final String suministro;

  CategoriaPage(this.manzana, this.lote, this.suministro, {Key? key})
      : super(key: key);

  @override
  _CategoriaPageState createState() => _CategoriaPageState();
}

class _CategoriaPageState extends State<CategoriaPage> {
  late Future<List<Categorias>> datoscategoria;
  Future<List<Categorias>> getCategoria() async {
    final response = await http.get(
        "https://www.jass-curipata.online/api/propiedades/" +
            widget.manzana +
            "/" +
            widget.lote +
            "/" +
            widget.suministro);
    List<Categorias> categoria = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      int categoriaid = jsonData[0]["categoria_id"];
      final categoriaresponse = await http.get(
          "https://www.jass-curipata.online/api/categorias/" +
              categoriaid.toString());
      if (categoriaresponse.statusCode == 200) {
        String categoriabody = utf8.decode(categoriaresponse.bodyBytes);
        final categoriaData = jsonDecode(categoriabody);
        var monto =
            categoriaData["categoria"]["monto_correspondiente"].toDouble();

        categoria.add(Categorias(
            categoriaData["categoria"]["descripcion"], monto.toString()));
      } else {
        throw Exception("fallo la conexion");
      }
      return categoria;
    } else {
      throw Exception("fallo la conexion");
    }
  }

  @override
  void initState() {
    super.initState();
    datoscategoria = getCategoria();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: datoscategoria,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: _listaCategoria(snapshot.data),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Wrap(children: [
                Text("La propiedad no pertenece a ninguna categoria",
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

  List<Widget> _listaCategoria(data) {
    List<Widget> datosdelacategoria = [];
    for (var categoria in data) {
      datosdelacategoria.add(Card(
          color: Colors.black,
          child: Column(children: [
            Center(
                child: Column(children: [
              Text(
                "CATEGORIA",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.cyanAccent),
              ),
              Icon(Icons.location_city_rounded,
                  size: 100.0, color: Colors.cyanAccent)
            ])),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Icon(Icons.water_damage_rounded,
                        size: 40.0, color: Colors.cyanAccent),
                  ),
                  Expanded(
                    child: Text("Categoria : " + categoria.categoria,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white)),
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
                    child: Icon(Icons.attach_money_rounded,
                        size: 40.0, color: Colors.cyanAccent),
                  ),
                  Expanded(
                    child: Text("Monto : " + categoria.monto,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white)),
                  ),
                ],
              ),
            ),
          ])));
    }
    return datosdelacategoria;
  }
}
