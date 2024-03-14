import 'package:doocar/Login_logout.dart';
import 'package:flutter/material.dart';

import 'hidden_drawer.dart';

class Pay_in_installments extends StatelessWidget {
  const Pay_in_installments({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        leadingWidth: 100,
        title: const Text('คำนวณค่างวดผ่อน'),
      ),
      body: const Column(
        children: [Login_logout_()],
      ),
    );
  }
}
