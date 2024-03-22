import 'dart:io';
import 'dart:math';

import 'package:doocar/component/Navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

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
                                  _pickImageFromGallery();
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
                          if (val == null) {
                            return 'Empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color.fromARGB(255, 218, 199, 221)
                              .withOpacity(0.1),
                          filled: true,
                          labelText: 'รุ่นรถยนต์',
                          labelStyle: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        validator: (val) {
                          if (val == null) {
                            return 'Empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
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
                          if (val == null) {
                            return 'Empty';
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
                    onPressed: () {},
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
                    onPressed: () {},
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

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedIamge = File(returnedImage!.path);
    });
  }
}
