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
      
      
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            
            children: [
              Text("ชื่อรุ่น Database",
          style: TextStyle(
            fontFamily: 'Customfont',
            fontSize: 40,
            fontWeight: FontWeight.w900,
          ),
          ),

            ],
          ),
          SizedBox(
            height: 100,
          ),
          detail(),
          SizedBox(
            height: 100,
          ),
          Text("ข้อมูลของรถยนต์",
            style: TextStyle(
              fontFamily: 'Customfont',
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),          
          ),
          Text("รายละเอียดรถยนต์ database ",style: TextStyle(
            fontFamily: 'Customfont',
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          ),
        ],
      ),
        
    );
  }
}