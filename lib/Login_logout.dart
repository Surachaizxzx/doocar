import 'package:doocar/component/Navigator.dart';
import 'package:doocar/screen/login.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Login_logout_ extends StatefulWidget {
  const Login_logout_({super.key});

  @override
  State<Login_logout_> createState() => _Login_logout_State();
}

class _Login_logout_State extends State<Login_logout_> {
  late SharedPreferences _prefs;
  bool _isLoggedIn = false;

  @override
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

  Future<void> _logout() async {
    // ตั้งค่า isLoggedIn เป็น false และบันทึกลง SharedPreferences
    await _prefs.setBool('isLoggedIn', false);
    setState(() {
      _isLoggedIn = false;
    });
  }

  Future Edit_Profile() async {
    return;
  }

  Future Edit_Picture() async {
    return;
  }

  Future Setting() async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoggedIn ? _loggedInView() : _loggedOutView(),
    );
  }

  Widget _loggedInView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 20, 0, 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 50, 0),
                child: Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Edit_Profile();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        backgroundColor: Colors.white, // สีของตัวอักษรภายในปุ่ม
                        elevation: 5, // ความสูงของเงา
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            20,
                          ), // การกำหนดรูปร่างของปุ่ม
                        ),
                      ),
                      icon: const Icon(
                        Icons.person_3_outlined,
                        color: Color.fromARGB(255, 26, 25, 25),
                      ),
                      label: const Text(
                        '\t\t\t\t\tEdit Profile',
                        style: TextStyle(
                          fontFamily: 'CustomFont',
                          fontSize: 16,
                          fontWeight: FontWeight
                              .normal, // This can be FontWeight.bold for the bold version
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 50, 0),
                child: Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Edit_Picture();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        backgroundColor: Colors.white, // สีของตัวอักษรภายในปุ่ม
                        elevation: 5, // ความสูงของเงา
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // การกำหนดรูปร่างของปุ่ม
                        ),
                      ),
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text(
                        "\t\t\t\t\tEdit Picture",
                        style: TextStyle(
                          fontFamily: 'CustomFont',
                          fontSize: 16,
                          fontWeight: FontWeight
                              .normal, // This can be FontWeight.bold for the bold version
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 50, 0),
                child: Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Setting();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        backgroundColor: Colors.white, // สีของตัวอักษรภายในปุ่ม
                        elevation: 5, // ความสูงของเงา
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // การกำหนดรูปร่างของปุ่ม
                        ),
                      ),
                      icon: const Icon(Icons.settings),
                      label: const Text(
                        "\t\t\t\t\tSetting",
                        style: TextStyle(
                          fontFamily: 'CustomFont',
                          fontSize: 16,
                          fontWeight: FontWeight
                              .normal, // This can be FontWeight.bold for the bold version
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 50, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Navigatorbar(),
                          ),
                        );
                        _logout();
                      },
                      icon: const Icon(Icons.logout_outlined),
                      label: const Text(
                        '\t\t\t\t\tLogout',
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'CustomFont',
                          fontSize: 16,
                          fontWeight: FontWeight
                              .normal, // This can be FontWeight.bold for the bold version
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _loggedOutView() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 50, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('You are not logged in!'),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 50, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginApp(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.login_outlined,
                  color: Colors.black,
                ),
                label: const Text(
                  '\t\t\t\tLogIn now',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: 'CustomFont',
                    fontSize: 16,
                    fontWeight: FontWeight
                        .normal, // This can be FontWeight.bold for the bold version
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
