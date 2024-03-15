import 'package:flutter/material.dart';
import 'package:doocar/widget/mycar.dart';
import 'hidden_drawer.dart';

class BuyMycar extends StatelessWidget {
  const BuyMycar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Mycar(),
    );
  }
}
