import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final IconData icono;
  final TextInputType type;
  final bool pass;
  final String texto;
  final TextEditingController controller;

  const TextFieldCustom(
      {required this.icono,
      required this.type,
      this.pass = false,
      required this.texto,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: type,
      obscureText: pass,
      decoration: InputDecoration(
        hintText: texto,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(icono, color: Colors.blue.shade800),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(50)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black87),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
