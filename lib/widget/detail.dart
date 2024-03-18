import 'package:doocar/component/my_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'slider.dart';

class detail extends StatelessWidget {
  const detail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      //mainAxisSize: MainAxisSize.max,
      children:[
        Row(
          children: [
        Container(
          margin: EdgeInsets.fromLTRB(10,10,50,0),
          padding: EdgeInsets.all(20.0),
          child: 
            const Text(
              "2011 Audi R8 4.2 (ปี 06-15) FSI 4WD Coupe",
              style: TextStyle(fontSize: 24, color: Colors.black,fontWeight: FontWeight.w900),
            ),
            //decoration: BoxDecoration(color: Colors.red),
            
        ),
          ],
        ),
         const SizedBox(
          height: 200,
        ),
        Row(
          children: [
            // Row(
            //   children:[
        Container(
          margin: EdgeInsets.fromLTRB(10,10,50,0),
          padding: EdgeInsets.all(20.0),
          child: 
            const Text(
              "ประเภทรถยนต์",
              style: TextStyle(fontSize: 24, color: Colors.black,fontWeight: FontWeight.w900),
            ),
            //decoration: BoxDecoration(color: Colors.red),
        ),
            //   ]
            // ),
        
            // Row(
            //   children:[
        Container(
          margin: EdgeInsets.fromLTRB(10,10,50,0),
          padding: EdgeInsets.all(20.0),
              child: 
            const Text(
              "รถสปอร์ต",
              style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w600),              
            ),
            //decoration: BoxDecoration(color: Colors.blue),
            ),
        //   ],
        // ),
          ]
        ),
         const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            // Row(
            //   children:[
        Container(
          margin: EdgeInsets.fromLTRB(10,10,50,0),
          padding: EdgeInsets.all(20.0),
          child: 
            const Text(
              "ราคา",
              style: TextStyle(fontSize: 24, color: Colors.black,fontWeight: FontWeight.w900),
            ),
            //decoration: BoxDecoration(color: Colors.red),
        ),
            //   ]
            // ),
        
            // Row(
            //   children:[
        Container(
          margin: EdgeInsets.fromLTRB(10,10,50,0),
          padding: EdgeInsets.all(20.0),
              child: 
            const Text(
              "4,250,000",
              style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w600),              
            ),
            //decoration: BoxDecoration(color: Colors.blue),
            ),
        //   ],
        // ),
          ]
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
        Container(
          margin: EdgeInsets.fromLTRB(10,10,50,0),
          padding: EdgeInsets.all(20.0),
          child: 
            const Text(
              "รายละเอียด",
              style: TextStyle(fontSize: 24, color: Colors.black,fontWeight: FontWeight.w900),
            ),
            //decoration: BoxDecoration(color: Colors.red),
        ),
          ],
        ),
        Row(
          children: [
        Container(
          margin: EdgeInsets.fromLTRB(10,10,50,10),
          padding: EdgeInsets.all(20.0),
              child: 
            const Text(
              "รถสวยจัดมาก ( ใช้เพียงแค่ 40,000 KM. ) เท่านั้น !!!เพราะ จะเอาไปขับแค่เฉพาะ วันอาทิตย์ เท่านั้นเป็นรุ่นพิเศษ ( Carbon-Edition ) แล้วกล้ายืนยัน สภาพใหม่จัด เหมือนรถป้ายแดง ของจริงแน่นอนไม่ต้องกังวลใจ เพราะ รถคันนี้ ถนอมแบบสุดหัวใจ จริงๆ",
              style: TextStyle(fontSize: 15, color: Colors.black,fontWeight: FontWeight.w600),              
            ),
            //decoration: BoxDecoration(color: Colors.blue),
            ),
        //   ],
        // ),
          ]
        ),
        Row(
          children: [
            Container(
              child: Mybutton(onTap: () {
                
              }, hinText: "เพิ่มลงMycar",),
            ),
            Container(
              child: Mybutton(onTap: () {}, hinText: "ซื้อ"),
              //decoration: BoxDecoration(color: Colors.amber),
            ),
          ],
            
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Container(
              child: Mybutton(onTap: () {
                
              }, hinText: "เพิ่มลงMycar",),
            ),
          ],
            
        ),
        
        
      ],
    );
  }
}
