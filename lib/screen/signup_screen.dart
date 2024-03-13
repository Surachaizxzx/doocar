// ignore_for_file: unused_import

import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:doocar/component/Navigator.dart';
import 'package:doocar/screen/home_screen.dart';
import 'package:doocar/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  TextEditingController uname = TextEditingController();
  TextEditingController uemail = TextEditingController();
  TextEditingController upassword = TextEditingController();
  TextEditingController uidU = TextEditingController();
  TextEditingController uphone = TextEditingController();
  void saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  Future<void> register() async {
    try {
      String uri = "http://10.0.2.2/ko/register.php";
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
      if (response["success"] == "true") {
        saveLoginStatus();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const Navigatorbar()),
          ),
        );
      }
      if (response["success"] == "false") {
        _showMyDialogRegister("เกิดข้อผิดพลาดกรุณาสมัครใหม่");
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
                fontSize: 30,
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
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const SignUpScreen()),
                  ),
                ),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          leadingWidth: 150,
          leading: TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginApp(),
                ),
              );
            },
            icon: const Icon(Icons.arrow_back),
            label: const Text(
              "เข้าสู่ระบบ",
              style: TextStyle(
                fontFamily: 'CustomFont',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 10,
                          ),
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
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: "Username",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none),
                                fillColor:
                                    const Color.fromARGB(255, 218, 199, 221)
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
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: "UserEmail",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none),
                                fillColor:
                                    const Color.fromARGB(255, 218, 199, 221)
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
                              controller: upassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Emtry';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none),
                                fillColor:
                                    const Color.fromARGB(255, 218, 199, 221)
                                        .withOpacity(0.1),
                                filled: true,
                                prefixIcon: const Icon(Icons.key),
                                labelText: 'ป้อนรหัส',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 350,
                            child: TextFormField(
                              controller: upassword,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Emtry';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none),
                                fillColor:
                                    const Color.fromARGB(255, 218, 199, 221)
                                        .withOpacity(0.1),
                                filled: true,
                                prefixIcon: const Icon(Icons.key),
                                labelText: 'ป้อนรหัสอีกครั้ง',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 350,
                            child: TextFormField(
                              controller: uidU,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "ID number",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none),
                                fillColor:
                                    const Color.fromARGB(255, 218, 199, 221)
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
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: "Phone number",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none),
                                fillColor:
                                    const Color.fromARGB(255, 218, 199, 221)
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
                                register();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const StadiumBorder(),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
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
                                      builder: (context) => const LoginApp(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Have a member ?",
                                  style: TextStyle(color: Colors.purple),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 200,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
