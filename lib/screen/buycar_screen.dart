import 'package:flutter/material.dart';
import 'package:doocar/widget/mycar.dart';
import 'hidden_drawer.dart';

class BuyMycar extends StatelessWidget {
  const BuyMycar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        leadingWidth: 100,
        title: const Text('สินค้าที่เลือก'),
      ),
      body: Mycar(),
    );
  }
}
