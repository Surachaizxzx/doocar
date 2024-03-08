// ignore_for_file: override_on_non_overriding_member, unused_import

import 'dart:convert';

import 'package:doocar/component/Navigator.dart';
import 'package:flutter/material.dart';
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
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  Future<void> Signin() async {
    if (name.text != "" || password.text != "") {
      try {
        String uri = "http://127.0.0.1/ko/login.php";
        var res = await http.post(
          Uri.parse(uri),
          body: {
            "name": name.text,
            "password": password.text,
          },
        );
        var $response = jsonDecode(res.body);

        if ($response["success"] == "true") {
          _showMyDialoglogin("Login success");
        } else {
          print("some issue");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Please Fill All fileds");
    }
     
  }
 

  void _showMyDialoglogin(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            backgroundColor: Color.fromARGB(255, 218, 199, 221),
            title: const Text('Login successfully'),
            content: Text(txtMsg),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => Navigatorbar())),
                ),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showMyDialog(String txtMsg) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Expanded(
          child: AlertDialog(
            backgroundColor: Colors.amberAccent,
            title: const Text('AlertDialog Title'),
            content: Text(txtMsg),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
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
        backgroundColor: const Color(0xFFF5F5F5),
        body: Center(
          child: Form(
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/3.png',
                      width: 300,
                      height: 250,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    const Text(
                      'Welcome',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: const Color.fromARGB(255, 218, 199, 221)
                              .withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.person),
                          labelText: 'Name',
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Empty';
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
                          fillColor: const Color.fromARGB(255, 218, 199, 221)
                              .withOpacity(0.1),
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                          labelText: 'Password',
                        ),
                        validator: (val) {
                          if (val!.isEmpty) {
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(260, 0, 0, 100),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text("Sign Up now"),
                      ),
                    ),
                    const SizedBox(
                      height: 300,
                    )
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
