import 'package:flutter/material.dart';
import 'package:prueba/pages/carrito.dart';
import 'package:prueba/pages/login.dart';
import 'package:prueba/pages/skateunit.dart';

class SkateShop extends StatefulWidget {
  @override
  _SkateShopState createState() => _SkateShopState();
}

class _SkateShopState extends State<SkateShop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          _AppBar(),
          SkateItemWidget(
            title: 'SK8',
            imagePath: 'assets/images/skate2.png',
            price: "\$ 150",
            backgroundColor: Colors.black87,
          ),
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
                .push(MaterialPageRoute(builder: (_) => LoginPage())),
            child: Icon(
              Icons.exit_to_app,
              color: Colors.greenAccent.shade400,
              size: 40,
            ),
          ),
          MaterialButton(
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Carrito())),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.greenAccent.shade400,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }
}

class SkateItemWidget extends StatelessWidget {
  final String title;
  final String imagePath;
  final String price;
  final Color backgroundColor;

  const SkateItemWidget(
      {required this.title,
      required this.imagePath,
      required this.price,
      required this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: 350,
      child: Column(
        children: [
          Image.asset(imagePath),
          Text(
            title,
            style: TextStyle(
                color: Colors.greenAccent.shade400,
                fontSize: 15,
                letterSpacing: 5),
          ),
          Text(
            price,
            style: TextStyle(
                color: Colors.greenAccent.shade400,
                fontSize: 25,
                letterSpacing: 5),
          ),
          TextButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SkateUnit())),
              child: Text('DETALLES',
                  style: TextStyle(
                    color: Colors.greenAccent.shade400,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.double,
                  )))
        ],
      ),
    );
  }
}
