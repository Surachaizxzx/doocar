import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../screen/bill.dart';
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
  String id = '';
  String name = '';
  @override
  void initState() {
    imageformdb();
    _fetchId();
    _fetchName();
    super.initState();
  }

  Future<void> _fetchName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedname = prefs.getString('session')!;
    setState(() {
      name = storedname!;
      print(name);
      ''; // Assign the value obtained from SharedPreferences to 'name'
    }); // ใช้ ! เพื่อรับประกันว่าค่า session ไม่เป็น null
  }

  Future<void> _fetchId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedid = prefs.getString('ID');
    setState(() {
      id = storedid!;
      print(id);
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

  Future<void> shopping() async {
    try {
      String uri = "https://doocar.000webhostapp.com/post.php";

      var res = await http.post(
        Uri.parse(uri),
        body: {},
      );
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: const BannerWidget(),
        ),
        Expanded(
          child: GridView.builder(
            itemCount: recorde.length, // จำนวนรายการทั้งหมด
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 10, // ระยะห่างในแนวนอนระหว่างรูปภาพ
              mainAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              bool isCurrentUser = (id == recorde[index]["user_id"]);
              // print(name);
              // print(recorde[index]["user_id"]);

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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "โพสโดย " +
                              "\t\tรหัสผู้ใช้\t\t" +
                              recorde[index]["user_id"],
                          style: TextStyle(
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (isCurrentUser)
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              // Handle delete action
                              // Call method to delete post
                            },
                          ),
                        IconButton(
                          icon: Icon(
                            Icons.shopping_bag,
                            color: Color.fromARGB(255, 54, 244, 70),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ),
                            );
                          },
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
                                width: 270,
                                // Adjust the width as needed
                                child: Text(
                                  "คำอธิบาย\t\t" +
                                      recorde[index]["information"],
                                  overflow: TextOverflow.clip,
                                  maxLines: 4, // Limit the number of lines
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
