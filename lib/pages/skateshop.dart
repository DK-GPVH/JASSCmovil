import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:prueba/models/Propiedad.dart';
import 'package:prueba/models/Fechas.dart';
import 'package:prueba/pages/carrito.dart';
import 'package:prueba/pages/login.dart';
import 'package:prueba/pages/skateunit.dart';
import 'package:prueba/models/Propiedad.dart';

import 'categoria.dart';

class PropiedadPage extends StatefulWidget {
  final String manzana;
  final String lote;
  final String suministro;

  PropiedadPage(this.manzana, this.lote, this.suministro, {Key? key})
      : super(key: key);

  @override
  _PropiedadPageState createState() => _PropiedadPageState();
}

class _PropiedadPageState extends State<PropiedadPage> {
  late Future<List<Propiedad>> listadoPropiedades;
  Future<List<Propiedad>> getPropiedad() async {
    final response = await http.get(
        "https://www.jass-curipata.online/api/propiedades/" +
            widget.manzana +
            "/" +
            widget.lote +
            "/" +
            widget.suministro);

    List<Propiedad> propiedad = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);

      final jsonData = jsonDecode(body);
      int id = jsonData[0]["id"];
      int man = jsonData[0]["manzana"];
      int lot = jsonData[0]["lote"];
      var cliente = jsonData[0]["cliente_id"];
      var categoria = jsonData[0]["categoria_id"];
      int estado = jsonData[0]["estado"];

      propiedad.add(Propiedad(
          id.toString(),
          man.toString(),
          lot.toString(),
          jsonData[0]["zona"],
          jsonData[0]["nrodesuministro"],
          cliente.toString(),
          categoria.toString(),
          estado.toString(),
          jsonData[0]["fecha_inscripcion"],
          jsonData[0]["fecha_adeudo"]));

      return propiedad;
    } else {
      throw Exception("fallo la conexion");
    }
  }

  @override
  void initState() {
    super.initState();
    listadoPropiedades = getPropiedad();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: listadoPropiedades,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: _listaPropiedad(snapshot.data),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Wrap(children: [
              Text("La propiedad no existe",
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
      },
    );
  }

  List<Widget> _listaPropiedad(data) {
    List<Widget> Propiedades = [];

    for (var propiedad in data) {
      Propiedades.add(
        Card(
            color: Colors.black,
            child: Column(
              children: [
                Center(
                    child: Column(children: [
                  Text(
                    "PROPIEDAD",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.cyanAccent),
                  ),
                  Icon(Icons.water_damage,
                      size: 100.0, color: Colors.cyanAccent)
                ])),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Icon(Icons.location_city_rounded,
                            size: 40.0, color: Colors.cyanAccent),
                      ),
                      Expanded(
                        child: Text(
                          "Manzana : " + propiedad.manzana,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Icon(Icons.crop_rounded,
                            size: 40.0, color: Colors.cyanAccent),
                      ),
                      Expanded(
                        child: Text("Lote : " + propiedad.lote,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Icon(Icons.branding_watermark_rounded,
                            size: 40.0, color: Colors.cyanAccent),
                      ),
                      Expanded(
                        child: Text("Zona : " + propiedad.zona,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Icon(Icons.calendar_today_rounded,
                            size: 40.0, color: Colors.cyanAccent),
                      ),
                      Expanded(
                        child: Text(
                            "Fecha de inscripcion : " + propiedad.fechains,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Icon(Icons.date_range_rounded,
                            size: 40.0, color: Colors.cyanAccent),
                      ),
                      Expanded(
                        child: Text("Fecha de adeudo : " + propiedad.fechaad,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      );
    }

    return Propiedades;
  }
}
