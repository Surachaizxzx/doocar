import 'package:doocar/component/Navigator.dart';
import 'package:doocar/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
    return Scaffold();
  }

  Widget _loggedOutView() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(200, 510, 20, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(211, 255, 1, 1)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginApp(),
                    ),
                  );
                  _logout();
                },
                icon: const Icon(Icons.login_outlined, color: Colors.white),
                label: const Text(
                  '\t\t\tLogin',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontFamily: 'CustomFont',
                    fontSize: 16,
                    fontWeight: FontWeight
                        .bold, // This can be FontWeight.bold for the bold version
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
