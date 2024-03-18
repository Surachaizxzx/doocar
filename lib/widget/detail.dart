import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'slider.dart';

class detail extends StatelessWidget {
  const detail({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "ประเภทรถยนต์",
              style: TextStyle(fontSize: 22, color: Colors.black,fontWeight: FontWeight.w900),
            ),
            SizedBox(
          width: 10,
        ),
            Text(
              "รถยนต์มือสอง",
              style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "ราคา",
              style: TextStyle(fontSize: 22, color: Colors.black,fontWeight: FontWeight.w900),
            ),
            SizedBox(
          width: 10,
        ),
            Text(
              "บาท",
              style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "ข้อมูลของรถยนต์",
              style: TextStyle(fontSize: 22, color: Colors.black,fontWeight: FontWeight.w900),
            ),
            SizedBox(
          width: 10,
        ),
            Text(
              "รายละเอียดรถยนต์ database",
              style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
