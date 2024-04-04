import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:http/http.dart' as http;
import 'package:doocar/component/Navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hidden_drawer.dart';

class Postui extends StatefulWidget {
  const Postui({super.key});

  @override
  State<Postui> createState() => _PostuiState();
}

class _PostuiState extends State<Postui> {
  TextEditingController carname = TextEditingController();
  TextEditingController carinfomation = TextEditingController();
  TextEditingController carprice = TextEditingController();
  TextEditingController user_id = TextEditingController();
  File? _selectedIamge;
  final _formKey = GlobalKey<FormState>();
  String? imagename;
  String? imagedata;
  ImagePicker imagePicker = new ImagePicker();
  Future<void> getImage() async {
    var getimage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedIamge = File(getimage!.path);
      imagename = getimage.path.split('/').last;
      imagedata = base64Encode(_selectedIamge!.readAsBytesSync());
      print(_selectedIamge);
      print(imagename);
      print(imagedata);
    });
  }

  void _showMyDialog(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            title: const Text(
              'กรุณาตรวจสอบอีกครั้ง',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'CustomFont',
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 2, 2, 2),
              ),
            ),
            content: Text(
              txtMsg,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'CustomFont',
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedIamge != null) {
      setState(() {
        uploadimage();
      });
      // ดำเนินการเมื่อข้อมูลถูกต้อง
    } else {
      _showMyDialog("โพสไม่สำเร็จ");
    }
  }

  Future<void> deleteImage() async {
    if (_selectedIamge != null) {
      await _selectedIamge!.delete(); // ลบรูปภาพจากระบบไฟล์
      setState(() {
        _selectedIamge = null; // เคลียร์ค่า _selectedIamge
        imagename = ''; // เคลียร์ค่า imagename
        imagedata = ''; // เคลียร์ค่า imagedata
      });
      print('Image deleted successfully');
    } else {
      print('No image selected to delete');
    }
  }

  Future<String?> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('session');
  }

  Future<String> getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .getString('ID')!; // ใช้ ! เพื่อรับประกันว่าค่า session ไม่เป็น null
  }

  Future<void> uploadimage() async {
    try {
      String uri = "https://doocar.000webhostapp.com/post.php";
      String userId = await getid();
      var res = await http.post(
        Uri.parse(uri),
        body: {
          "carname": carname.text, //caption
          "carinfomation": carinfomation.text, //caption
          "carprice": carprice.text, //caption
          "uid": userId, //caption
          "data": imagedata,
          "name": imagename,
        },
      );
      var $res = jsonDecode(res.body);

      if ($res["status"] == "success") {
        print("กุเพิ่มละ");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Navigatorbar(),
          ),
        );
      } else if ($res["status"] == "error") {
        print("some issue");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 100,
            left: 30,
            right: 30,
          ),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Upload your file",
                    style: TextStyle(
                      fontFamily: 'CustomFont',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.all(10),
                width: max(200, 300),
                height: max(250, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    style: BorderStyle.solid,
                    color: const Color.fromARGB(120, 0, 0, 0),
                  ),
                ),
                child: _selectedIamge != null
                    ? Image.file(
                        _selectedIamge!,
                        fit: BoxFit.cover,
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  getImage();
                                },
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.image_search,
                                      color: Color.fromARGB(120, 0, 0, 0),
                                    ),
                                    Text(
                                      "เพิ่มรุปภาพ",
                                      style: TextStyle(
                                        color: Color.fromARGB(120, 0, 0, 0),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color.fromARGB(255, 218, 199, 221)
                              .withOpacity(0.1),
                          filled: true,
                          labelText: 'ชื่อสินค้า',
                          labelStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'กรุณากรอกชื่อสินค้า';
                          }
                          return null;
                        },
                        controller: carname,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: carprice,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color.fromARGB(255, 218, 199, 221)
                              .withOpacity(0.1),
                          filled: true,
                          labelText: 'ราคา',
                          labelStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'กรุณากรอกราคา';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: carinfomation,
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color.fromARGB(255, 218, 199, 221)
                              .withOpacity(0.1),
                          filled: true,
                          labelText: 'คำอธิบาย',
                          labelStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'กรุณาใส่คำอธิบาย';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 0, 0),

                      padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15), // ขนาดการเว้นระยะของปุ่ม
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10)), // รูปร่างของปุ่ม
                      textStyle:
                          const TextStyle(fontSize: 16), // สไตล์ข้อความบนปุ่ม
                    ),
                    onPressed: () {
                      deleteImage();
                    },
                    child: const Text("ลบรูปภาพ"),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Colors.blue, // เปลี่ยนเป็นสีแดง
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 15), // ขนาดการเว้นระยะของปุ่ม
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20)), // รูปร่างของปุ่ม
                      textStyle:
                          const TextStyle(fontSize: 16), // สไตล์ข้อความบนปุ่ม
                    ),
                    onPressed: () {
                      _submitForm();
                    },
                    child: const Text("โพส"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
