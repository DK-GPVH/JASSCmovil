import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:prueba/pages/skateshop.dart';
import 'package:prueba/widgets/Header.dart';

class SkateUnit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade400,
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        physics: BouncingScrollPhysics(),
        children: [
          Stack(
            children: [Blue()],
          ),
          _AppBar(),
          _Content(),
          _Button(),
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
              Icons.arrow_back_ios,
              color: Colors.greenAccent.shade400,
              size: 40,
            ),
          ),
          Text(
            'SK8',
            style: TextStyle(
                color: Colors.amber.shade900, letterSpacing: 10, fontSize: 35),
          ),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/images/skate2.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            children: [
              Text('DISEÑO INSPIRADO EN REKI KYAN',
                  style: TextStyle(color: Colors.amber.shade900, fontSize: 30)),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 20,
              ),
              Text('TAMAÑO',
                  style: TextStyle(color: Colors.amber.shade900, fontSize: 25)),
              SizedBox(
                height: 10,
              ),
              Text('8" X 12"',
                  style: TextStyle(color: Colors.black87, fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              Text('MATERIAL',
                  style: TextStyle(color: Colors.amber.shade900, fontSize: 25)),
              SizedBox(
                height: 10,
              ),
              Text('FIBRA DE CARBONO',
                  style: TextStyle(color: Colors.black87, fontSize: 20)),
              SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                height: 48,
                color: Colors.yellow,
                alignment: Alignment.center,
                child: CustomPaint(
                  painter: _DieCuttingPainter(),
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text('\$150',
                        style: Theme.of(context).textTheme.headline3),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: Colors.black87, borderRadius: BorderRadius.circular(50)),
      child: TextButton(
        child: Text('COMPRAR',
            style: TextStyle(
                color: Colors.greenAccent.shade400,
                fontSize: 20,
                letterSpacing: 5)),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => SkateUnit())),
      ),
    );
  }
}

class _DieCuttingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.black26;
    var x = size.height / 6;
    var path = Path();
    path.moveTo(0, 0);
    for (var i = 0; i < 3; i++) {
      path.relativeLineTo(x, x);
      path.relativeLineTo(-x, x);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
