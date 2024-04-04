import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

export 'package:doocar/widget/shopping.dart';

class ShoppingListviewWidget extends StatefulWidget {
  const ShoppingListviewWidget({super.key});

  @override
  State<ShoppingListviewWidget> createState() => ShoppingListviewWidgetState();
}

class ShoppingListviewWidgetState extends State<ShoppingListviewWidget>
    with TickerProviderStateMixin {
  List recorde = [];

  @override
  void initState() {
    imageformdb();
    super.initState();
  }

  Future<void> imageformdb() async {
    try {
      String uri = "https://doocar.000webhostapp.com/viewimage.php";
      var response = await http.get(Uri.parse(uri));
      setState(() {
        recorde = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My GridView Example'),
      ),
      body: _buildGridView(), // เรียกใช้เมธอดสร้าง GridView
    );
  }

  Widget _buildGridView() {
    // สร้าง GridView
    return GridView.builder(
      itemCount: recorde.length, // จำนวนรายการทั้งหมด
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1, // จำนวนคอลัมน์ใน GridView
      ),
      itemBuilder: (BuildContext context, int index) {
        // สร้าง Widget สำหรับแต่ละเซลล์ใน GridView
        return Card(
          margin: EdgeInsets.all(8),
          child: Column(
            children: [
              Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://doocar.000webhostapp.com/" +
                          recorde[index]["image"],
                    ),
                  ),
                ),
                child: Text(
                  recorde[index]["information"],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}
