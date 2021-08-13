import 'package:flutter/material.dart';
import 'package:prueba/pages/login.dart';
import 'package:prueba/widgets/Header.dart';
import 'package:prueba/widgets/Logo.dart';
import 'package:prueba/widgets/TextFieldCustom.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade400,
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        physics: BouncingScrollPhysics(),
        children: [
          Stack(
            children: [HeaderSignUp(), LogoHeader()],
          ),
          _Titulo(),
          _TextField(),
          _Botton()
        ],
      ),
    );
  }
}

class _Botton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Colors.black87, borderRadius: BorderRadius.circular(50)),
      child: TextButton(
        child: Text('Registrarse',
            style: TextStyle(color: Colors.greenAccent.shade400, fontSize: 18)),
        onPressed: () {},
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextFieldCustom(
              icono: Icons.person, type: TextInputType.text, texto: 'Usuario'),
          SizedBox(height: 20),
          TextFieldCustom(
              icono: Icons.assignment_ind,
              type: TextInputType.emailAddress,
              texto: 'Cargo (Cliente/Vendedor)'),
          SizedBox(height: 20),
          TextFieldCustom(
              icono: Icons.phone,
              type: TextInputType.number,
              texto: 'Telefono/Celular'),
          SizedBox(height: 20),
          TextFieldCustom(
              icono: Icons.visibility_off,
              type: TextInputType.text,
              pass: true,
              texto: 'Contraseña'),
          SizedBox(height: 20),
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
          TextButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => LoginPage())),
            child: Text('Ingresar',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black26)),
          ),
          Text('/', style: TextStyle(fontSize: 20, color: Colors.grey)),
          TextButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SignUpPage())),
              child: Text('REGISTRATE',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)))
        ],
      ),
    );
  }
}
