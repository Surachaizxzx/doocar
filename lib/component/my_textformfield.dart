import 'package:flutter/material.dart';

class MytextField extends StatelessWidget {
  const MytextField(
      {super.key,
      required this.Controller,
      required this.hintText,
      required this.obscureText,
      required this.labelText});
  final Controller;
  final String hintText;
  final bool obscureText;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: Controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 42,
            vertical: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue),
            gapPadding: 10,
          ),
        ),
      ),
    );
  }
}
