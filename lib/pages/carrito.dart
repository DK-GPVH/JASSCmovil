import 'package:flutter/material.dart';
import 'package:prueba/pages/skateshop.dart';

class Carrito extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          _AppBar(),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: [
          MaterialButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SkateShop())),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.greenAccent.shade400,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}
