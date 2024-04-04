import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'banner_widget.dart';

export 'package:doocar/widget/shopping.dart';

class ShoppingListviewWidget extends StatefulWidget {
  const ShoppingListviewWidget({super.key});

  @override
  State<ShoppingListviewWidget> createState() => ShoppingListviewWidgetState();
}

class ShoppingListviewWidgetState extends State<ShoppingListviewWidget>
    with TickerProviderStateMixin {
  List recorde = [];
  String name = '';
  @override
  void initState() {
    imageformdb();
    _fetchName();
    super.initState();
  }

  Future<void> _fetchName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedName = prefs.getString('session');
    setState(() {
      name = storedName ??
          ''; // Assign the value obtained from SharedPreferences to 'name'
    });
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
      body: _buildGridView(),

      // เรียกใช้เมธอดสร้าง GridView
    );
  }

  Widget _buildGridView() {
    // สร้าง GridView
    return Column(
      children: [
        const BannerWidget(),
        Expanded(
          child: GridView.builder(
            itemCount: recorde.length, // จำนวนรายการทั้งหมด
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1),
            itemBuilder: (BuildContext context, int index) {
              // สร้าง Widget สำหรับแต่ละเซลล์ใน GridView
              return Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 30,
                  right: 30,
                ),
                child: Column(
                  children: [
                    Container(
                      width: 303,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 2.0),
                        borderRadius: BorderRadius.circular(30),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://doocar.000webhostapp.com/" +
                                recorde[index]["image"],
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text(
                          "โพสโดย " +
                              name +
                              "\t\tรหัสผู้ใช้\t\t" +
                              recorde[index]["user_id"],
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "รถรุ่น\t\t" + recorde[index]["name"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          recorde[index]["price"] + "\tบาท",
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 290,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 270, // Adjust the width as needed
                                child: Text(
                                  "คำอธิบาย\t\t" +
                                      recorde[index]["information"],
                                  overflow: TextOverflow.clip,
                                  maxLines: null, // Limit the number of lines
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
