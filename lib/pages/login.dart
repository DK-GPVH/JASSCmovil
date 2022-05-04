import 'package:flutter/material.dart';
import 'package:prueba/pages/skateshop.dart';
import 'package:prueba/pages/skateunit.dart';
import 'package:prueba/pages/inicio.dart';
import 'package:prueba/widgets/Header.dart';
import 'package:prueba/widgets/Logo.dart';
import 'package:prueba/widgets/TextFieldCustom.dart';

TextEditingController manzana = TextEditingController(text: "");
TextEditingController lote = TextEditingController(text: "");
TextEditingController suministro = TextEditingController(text: "");

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        physics: BouncingScrollPhysics(),
        children: [
          Stack(
            children: [HeaderLogin(), LogoHeader()],
          ),
          _Titulo(),
          SizedBox(height: 40),
          _EmailAndPassword(),
          SizedBox(height: 40),
          _BottonSignIn()
        ],
      ),
    );
  }
}

class _BottonSignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Colors.blue.shade800, borderRadius: BorderRadius.circular(50)),
      child: TextButton(
        child: Text('INGRESAR',
            style: TextStyle(color: Colors.white, fontSize: 25)),
        onPressed: () {
          if (suministro.text == "" || lote.text == "" || manzana.text == "") {
            _nulldata(context);
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        Inicio(manzana.text, lote.text, suministro.text)));
          }
        },
      ),
    );
  }

  void _nulldata(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              child: Center(
            child: Wrap(
              children: [
                Center(
                  child: Icon(Icons.error_rounded, size: 30, color: Colors.red),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                      "Por favor complete todo los cuadros para poder realizar la consulta.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.blue.shade800)),
                ),
              ],
            ),
          ));
        });
  }
}

class _EmailAndPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextField(
            controller: manzana,
            keyboardType: TextInputType.number,
            obscureText: false,
            decoration: InputDecoration(
              hintText: 'Manzana',
              filled: true,
              fillColor: Colors.white,
              prefixIcon:
                  Icon(Icons.house_rounded, color: Colors.blue.shade800),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(50)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: lote,
            keyboardType: TextInputType.number,
            obscureText: false,
            decoration: InputDecoration(
              hintText: 'Lote',
              filled: true,
              fillColor: Colors.white,
              prefixIcon:
                  Icon(Icons.house_outlined, color: Colors.blue.shade800),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(50)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: suministro,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            decoration: InputDecoration(
              hintText: 'Suministro',
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.water, color: Colors.blue.shade800),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(50)),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Titulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        children: [
          Text('INGRESAR',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade800)),
        ],
      ),
    );
  }
}
