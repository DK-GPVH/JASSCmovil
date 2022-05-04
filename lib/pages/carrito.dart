import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prueba/models/Cliente.dart';
import 'package:prueba/models/Fechas.dart';
import 'package:prueba/pages/skateshop.dart';
import 'package:prueba/widgets/Header.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class ClientePage extends StatefulWidget {
  final String manzana;
  final String lote;
  final String suministro;

  ClientePage(this.manzana, this.lote, this.suministro, {Key? key})
      : super(key: key);

  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  late Future<List<Cliente>> datoscliente;
  Future<List<Cliente>> getCliente() async {
    final response = await http.get(
        "https://www.jass-curipata.online/api/propiedades/" +
            widget.manzana +
            "/" +
            widget.lote +
            "/" +
            widget.suministro);
    List<Cliente> cliente = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      int idcliente = jsonData[0]["cliente_id"];
      final clienteresponse = await http.get(
          "https://www.jass-curipata.online/api/clientes/" +
              idcliente.toString());
      if (clienteresponse.statusCode == 200) {
        String clientebody = utf8.decode(clienteresponse.bodyBytes);

        final data = jsonDecode(clientebody);

        cliente.add(Cliente(
            data["cliente"]["nombre"],
            data["cliente"]["apellidop"],
            data["cliente"]["apellidom"],
            data["cliente"]["nrodocumento"],
            data["cliente"]["fechanac"],
            data["cliente"]["telefono"]));

        return cliente;
      } else {
        throw Exception("fallo la conexion");
      }
    } else {
      throw Exception("fallo la conexion");
    }
  }

  @override
  void initState() {
    super.initState();
    datoscliente = getCliente();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: datoscliente,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: _listaCliente(snapshot.data),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Wrap(children: [
                Text("La propiedad no pertenece a ningun cliente",
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

  List<Widget> _listaCliente(data) {
    List<Widget> datosdelcliente = [];
    for (var cliente in data) {
      datosdelcliente.add(Card(
          color: Colors.black,
          child: Wrap(children: [
            Center(
                child: Column(children: [
              Text(
                "CLIENTE",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.cyanAccent),
              ),
              Icon(Icons.account_circle_rounded,
                  size: 100.0, color: Colors.cyanAccent)
            ])),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Icon(Icons.person_rounded,
                        size: 40.0, color: Colors.cyanAccent),
                  ),
                  Expanded(
                    child: Text(
                        "Cliente : " +
                            cliente.nombre +
                            "," +
                            cliente.apellidopaterno +
                            " " +
                            cliente.apellidomaterno,
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
                    child: Icon(Icons.badge_rounded,
                        size: 40.0, color: Colors.cyanAccent),
                  ),
                  Expanded(
                    child: Text("N° de documento : " + cliente.nrodedocumento,
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
                    child: Icon(Icons.calendar_today_rounded,
                        size: 40.0, color: Colors.cyanAccent),
                  ),
                  Expanded(
                    child: Text(
                        "Fecha de nacimiento : " + cliente.fechanacimiento,
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
                    child: Icon(Icons.contact_phone_rounded,
                        size: 40.0, color: Colors.cyanAccent),
                  ),
                  Expanded(
                    child: Text("Telefono/Celular : " + cliente.telefono,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white)),
                  ),
                ],
              ),
            )
          ])));
    }
    return datosdelcliente;
  }
}
