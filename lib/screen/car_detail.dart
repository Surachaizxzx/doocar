import 'package:doocar/widget/detail.dart';
import 'package:flutter/material.dart';
import 'hidden_drawer.dart';

class carDetail extends StatelessWidget {
  const carDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        leadingWidth:100,
        title: const Text('รายละเอียดรถ'),
      ),
      body: detail(),
        
    );
  }
}