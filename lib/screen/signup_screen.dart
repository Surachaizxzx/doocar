// ignore_for_file: unused_import

import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:doocar/component/Navigator.dart';
import 'package:doocar/screen/home_screen.dart';
import 'package:doocar/screen/login.dart';
import 'package:flutter/material.dart';

import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences _prefs;
  bool _isLoggedIn = false;
  TextEditingController uname = TextEditingController();
  TextEditingController uemail = TextEditingController();
  TextEditingController upassword = TextEditingController();
  TextEditingController uidU = TextEditingController();
  TextEditingController uphone = TextEditingController();
  void saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  void saveSession(String session) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('session', session);
  }

  Future<void> register() async {
    try {
      String uri = "https://doocar.000webhostapp.com/register.php";
      var res = await http.post(
        Uri.parse(uri),
        body: {
          'name': uname.text,
          'email': uemail.text,
          'password': upassword.text,
          'idThai': uidU.text,
          'phone': uphone.text,
        },
      );
      var response = jsonDecode(res.body);
      if (response["status"] == "success") {
        saveLoginStatus();
        _showMyDialogRegistersuccess("สมัครบัญชีสำเร็จ");
      }
      if (response["status"] == "already") {
        _showMyDialogRegister("มีชื่อบัญชีผู้ใช้นี้เเล้ว");
      }
    } catch (e) {
      print(e);
    }
  }

  void _showMyDialogRegister(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            backgroundColor: const Color.fromARGB(255, 218, 199, 221),
            title: const Text(
              'Register ข้อผิดพลาด',
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
                onPressed: () => Navigator.pop(context, ""),
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

  void _showMyDialogRegistersuccess(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            backgroundColor: const Color.fromARGB(255, 218, 199, 221),
            title: const Text(
              'Register สำเร็จ',
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
                  saveSession(uname.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Navigatorbar(),
                    ),
                  );
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
    if (_formKey.currentState!.validate()) {
      register();
      // ดำเนินการเมื่อข้อมูลถูกต้อง
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/3.png"),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: uname,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'กรุณากรอกชื่อบัญชี';
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Username",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color.fromARGB(255, 218, 199, 221)
                              .withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.person),
                          labelText: 'ชื่อบัญชี',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: uemail,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่อีเมลล์';
                          }
                          if (!_isValidEmail(value)) {
                            return 'กรุณากรอกอีเมลล์อีกครั้ง';
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "UserEmail",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color.fromARGB(255, 218, 199, 221)
                              .withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.email),
                          labelText: 'อีเมลล์',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color.fromARGB(255, 218, 199, 221)
                              .withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.key),
                          labelText: 'ป้อนรหัส',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณาป้อนรหัสผ่าน';
                          }
                          if (!RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9]).{8,}$')
                              .hasMatch(value)) {
                            return 'รหัสผ่านต้องประกอบด้วยตัวอักษรและตัวเลข อย่างน้อย 8 ตัว';
                          }
                          return null;
                        },
                        controller: upassword,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color.fromARGB(255, 218, 199, 221)
                              .withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.key),
                          labelText: 'ยืนยันรหัสผ่าน',
                        ),
                        validator: (value) {
                          String upasswordtoo = upassword.text;
                          if (value!.isEmpty) {
                            return 'กรุณาใส่รหัสผ่าน';
                          } else if (value != upasswordtoo) {
                            return 'รหัสผ่านไม่ตรงกัน';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: uidU,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an ID number';
                          }
                          if (!_isValidIDNumber(value)) {
                            return 'Please enter a valid ID number';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "ID number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color.fromARGB(255, 218, 199, 221)
                              .withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.insert_drive_file),
                          labelText: 'รหัสบัตรประชาชน',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: uphone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a phone number';
                          }
                          if (!_isValidPhoneNumber(value)) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: "Phone number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color.fromARGB(255, 218, 199, 221)
                              .withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.numbers),
                          labelText: 'เบอร์โทรศัพท์',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          _submitForm();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          backgroundColor:
                              const Color.fromARGB(255, 223, 187, 232),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Navigatorbar(),
                              ),
                            );
                          },
                          child: const Text(
                            "กลับหน้าหลัก",
                            style:
                                TextStyle(color: Colors.purple, fontSize: 15),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginApp(),
                              ),
                            );
                          },
                          child: const Text(
                            "มีบัญชีเเล้ว?",
                            style:
                                TextStyle(color: Colors.purple, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool _isValidIDNumber(String value) {
    // ใช้ Regular Expression เพื่อตรวจสอบรูปแบบของเลขบัตรประชาชน
    // โดยใช้ RegExp สำหรับเลขบัตรประชาชนที่มีรูปแบบมาตรฐาน
    RegExp idRegExp = RegExp(
      r'^[0-9]{13}$',
      caseSensitive: false,
      multiLine: false,
    );
    return idRegExp.hasMatch(value);
  }

  bool _isValidEmail(String value) {
    // ใช้ Regular Expression เพื่อตรวจสอบรูปแบบของอีเมลล์
    // โดยใช้ RegExp สำหรับอีเมลล์ที่มีรูปแบบมาตรฐาน
    RegExp emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    return emailRegExp.hasMatch(value);
  }

  bool _isValidPhoneNumber(String value) {
    // ใช้ Regular Expression เพื่อตรวจสอบรูปแบบของเบอร์โทรศัพท์
    // โดยใช้ RegExp สำหรับเบอร์โทรศัพท์ที่มีรูปแบบมาตรฐาน
    RegExp phoneRegExp = RegExp(
      r'^[0-9]{10}$',
      caseSensitive: false,
      multiLine: false,
    );
    return phoneRegExp.hasMatch(value);
  }

  bool _isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}
