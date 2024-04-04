import 'package:doocar/Login_logout.dart';
import 'package:doocar/screen/editinfo.dart';
import 'package:doocar/screen/post.dart';
import 'package:doocar/screen/settingprofile.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:doocar/service/classuser.dart';
import 'package:flutter/widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late SharedPreferences prefs;

  bool _isLoggedIn = false;
  Future<void> _checkLoginStatus() async {
    prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _logout() async {
    // ตั้งค่า isLoggedIn เป็น false และบันทึกลง SharedPreferences
    await prefs.setBool('isLoggedIn', false);
    removeSession();
    removeid();
    setState(() {
      _isLoggedIn = false;
    });
  }

  void saveID(String ID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ID', ID);
  }

  void removeSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('session');
  }

  Future<String> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(
        'session')!; // ใช้ ! เพื่อรับประกันว่าค่า session ไม่เป็น null
  }

  void printSession() async {
    String? session = await getSession();
    print(session);
  }

  Future<String> getid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs
        .getString('ID')!; // ใช้ ! เพื่อรับประกันว่าค่า session ไม่เป็น null
  }

  void printid() async {
    String? id = await getid();
    print(id);
  }

  void removeid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('ID');
  }

  late Future<List<User>> _usersFuture;
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();

    // ดึง session จาก SharedPreferences
    getSession().then((session) {
      setState(() {
        _usersFuture = UserService.getUsers(session);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: _isLoggedIn ? _loggedInView() : _loggedOutView(),
    );
  }

  Widget _loggedInView() {
    return Drawer(
      child: FutureBuilder(
        future: _usersFuture,
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Login_logout_();
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                User user = snapshot.data![index];
                return Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 247, 228, 162),
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage("assets/images/blackground.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Column(
                                      children: [
                                        Text(
                                          "\t\tเมนู",
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.white,
                                            fontWeight: FontWeight
                                                .bold, // น้ำหนักตัวอักษร
                                            fontStyle: FontStyle.normal,
                                            fontFamily: 'CustomFont',
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginApp(),
                                              ),
                                            );
                                            _logout();
                                          },
                                          icon: const Icon(
                                            Icons.logout_outlined,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          label: const Text(""),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 80,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 247, 228, 162),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(70.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: 105,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 20,
                                      left: 30,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                96, 219, 217, 200),
                                            border: Border.all(
                                              width: 5,
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                20,
                                              ),
                                            ),
                                          ),
                                          margin: EdgeInsets.only(right: 40),
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      child: ClipOval(
                                                        child: CircleAvatar(
                                                          child: Image.asset(
                                                            "assets/images/me.jpg",
                                                            width: 80,
                                                            height: 80,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    Text("ID:\t\t\t"),
                                                    Text(user.id),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Name:\t\t\t"),
                                                    Text(user.username),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Email:\t\t\t"),
                                                    Text(user.email),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: const Color.fromARGB(255, 255, 255,
                            255), // Specify the color of the line
                        thickness: 2, // Specify the thickness of the line
                        indent: 20, // Specify the starting padding of the line
                        endIndent: 20, // Specify the ending padding of the line
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          top: 40,
                          right: 10,
                          bottom: 20,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                width: 2,
                                style: BorderStyle.solid,
                                color: const Color.fromARGB(255, 255, 255, 255),
                              )),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                        TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal:
                                                20), // กำหนดระยะห่างของขอบปุ่ม
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0), // กำหนดรูปร่างของปุ่ม
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SettingProfile(),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/user.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text("เเก้ไขโปรไฟล์"),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                        TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal:
                                                20), // กำหนดระยะห่างของขอบปุ่ม
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0), // กำหนดรูปร่างของปุ่ม
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/resume.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text("เเก้ไขข้อมูล"),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                        TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal:
                                                20), // กำหนดระยะห่างของขอบปุ่ม
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0), // กำหนดรูปร่างของปุ่ม
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/payment.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text("ใบเสร็จ"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                        TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal:
                                                20), // กำหนดระยะห่างของขอบปุ่ม
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0), // กำหนดรูปร่างของปุ่ม
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Postui(),
                                        ),
                                      );
                                      saveID(user.id);
                                      printid();
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/post.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text("โพสขายสินค้า"),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                        TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal:
                                                20), // กำหนดระยะห่างของขอบปุ่ม
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0), // กำหนดรูปร่างของปุ่ม
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/shopping-cart.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text("สินค้าของฉัน"),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                        TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal:
                                                20), // กำหนดระยะห่างของขอบปุ่ม
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0), // กำหนดรูปร่างของปุ่ม
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/shop.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text("ร้านสินค้า"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                        TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal:
                                                20), // กำหนดระยะห่างของขอบปุ่ม
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0), // กำหนดรูปร่างของปุ่ม
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/seller.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text("เลือกซื้อสินค้า"),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                        TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal:
                                                25), // กำหนดระยะห่างของขอบปุ่ม
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0), // กำหนดรูปร่างของปุ่ม
                                        ),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/car-dealer.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text("รถที่สนใจ"),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                        TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                        EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal:
                                                10), // กำหนดระยะห่างของขอบปุ่ม
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              15.0), // กำหนดรูปร่างของปุ่ม
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginApp(),
                                        ),
                                      );
                                      _logout();
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          "assets/images/exit.png",
                                          width: 50,
                                          height: 50,
                                        ),
                                        Text("ออกจากระบบ"),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _loggedOutView() {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/blackground.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Column(
                          children: [
                            Text(
                              "เมนู",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold, // น้ำหนักตัวอักษร
                                fontStyle: FontStyle.normal,
                                fontFamily: 'CustomFont',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 105,
                        ),
                        Column(
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginApp(),
                                  ),
                                );
                                _logout();
                              },
                              icon: const Icon(
                                Icons.logout_outlined,
                                size: 40,
                                color: Colors.white,
                              ),
                              label: const Text(""),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 140,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(70.0),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 105,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [Text('Visitor Account')],
                  ),
                  Row(
                    children: [Text('Visitor Email')],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
