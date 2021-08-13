import 'package:flutter/material.dart';
import 'package:prueba/pages/signup.dart';
import 'package:prueba/pages/skateunit.dart';
import 'package:prueba/widgets/Header.dart';
import 'package:prueba/widgets/Logo.dart';
import 'package:prueba/widgets/TextFieldCustom.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade400,
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
          color: Colors.black87, borderRadius: BorderRadius.circular(50)),
      child: TextButton(
        child: Text('INGRESAR',
            style: TextStyle(color: Colors.greenAccent.shade400, fontSize: 20)),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => SkateUnit())),
      ),
    );
  }
}

class _EmailAndPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextFieldCustom(
              icono: Icons.person,
              type: TextInputType.emailAddress,
              texto: 'Usuario'),
          SizedBox(height: 20),
          TextFieldCustom(
              icono: Icons.visibility_off,
              type: TextInputType.text,
              pass: true,
              texto: 'Contraseña'),
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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(' /', style: TextStyle(fontSize: 20, color: Colors.black87)),
          TextButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SignUpPage())),
              child: Text('Registrate',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black26)))
        ],
      ),
    );
  }
}
