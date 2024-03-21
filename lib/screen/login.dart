// ignore_for_file: override_on_non_overriding_member, unused_import

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:doocar/component/Navigator.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

import 'package:http/http.dart' as http;

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

  @override
  State<LoginApp> createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  @override
  final formKey = GlobalKey<FormState>();
  late SharedPreferences _prefs;
  late SharedPreferences prefs;
  bool _isLoggedIn = false;
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<String?> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('session');
  }

  void printSession() async {
    String? session = await getSession();
    if (session != null) {
      print('Session is ready');
    } else {
      print('unSession is ready');
    }
  }

  Future<void> Signin() async {
    if (name.text != "" || password.text != "") {
      try {
        String uri = "https://doocar.000webhostapp.com/login.php";
        var res = await http.post(
          Uri.parse(uri),
          body: {
            "name": name.text,
            "password": password.text,
          },
        );
        var $response = jsonDecode(res.body);

        if ($response["status"] == "success") {
          saveLoginStatus();
          _showMyDialoglogin("เข้าสู่ระบบสำเร็จ");
        } else if ($response["status"] == "error") {
          print("some issue");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please Fill All fileds");
    }
  }

  void saveLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
  }

  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    _prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  void saveSession(String session) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('session', session);
  }

  void removeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('session');
  }

  Future<void> _logout() async {
    // ตั้งค่า isLoggedIn เป็น false และบันทึกลง SharedPreferences
    await _prefs.setBool('isLoggedIn', false);
    removeSession();
    setState(() {
      _isLoggedIn = false;
    });
  }

  void _showMyDialoglogin(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            backgroundColor: const Color.fromARGB(255, 218, 199, 221),
            title: const Text(
              'Login successfully',
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
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                  _logout();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  saveSession(name.text);
                  printSession();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const Navigatorbar()),
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/3.png',
                      width: 300,
                      height: 150,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    const Text(
                      'Welcome',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 300,
                      height: 300,
                      child: Column(
                        children: [
                          SizedBox(
                            width: 350,
                            child: TextFormField(
                              obscureText: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none),
                                fillColor:
                                    const Color.fromARGB(255, 218, 199, 221)
                                        .withOpacity(0.1),
                                filled: true,
                                prefixIcon: const Icon(Icons.person),
                                labelText: 'Name',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'กรุณาป้อนชื่อบัญชี';
                                }
                                return null;
                              },
                              controller: name,
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
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18),
                                    borderSide: BorderSide.none),
                                fillColor:
                                    const Color.fromARGB(255, 218, 199, 221)
                                        .withOpacity(0.1),
                                filled: true,
                                prefixIcon: const Icon(Icons.password),
                                labelText: 'Password',
                              ),
                              validator: (val) {
                                if (val == null) {
                                  return 'Empty';
                                }
                                return null;
                              },
                              controller: password,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 350,
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 218, 199, 221),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              onPressed: () {
                                // printSession();
                                Signin();
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 15),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Navigatorbar(),
                                    ),
                                  );
                                },
                                child: const Text("กลับไปหน้าหลัก"),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 15),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ),
                                  );
                                },
                                child: const Text("สมัครบัญชี"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
