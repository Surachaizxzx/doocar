import 'package:doocar/Login_logout.dart';
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
    setState(() {
      _isLoggedIn = false;
    });
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
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                User user = snapshot.data![index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Column(
                                      children: [
                                        Text(
                                          "เมนู",
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
                                  height: 160,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 140),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(70.0),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                      left: 40,
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 40,
                                          child: ClipOval(
                                            child: Image.network(
                                                "https://media.discordapp.net/attachments/937958580357853215/1218464834547486811/image.png?ex=6607c2ce&is=65f54dce&hm=7ce9e3d5a6b4fb98d8eefa13a7338fbf24058e8d310d8618ab51ea3ab863c491&=&format=webp&quality=lossless&width=381&height=385"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                    ),
                                    onPressed: () {
                                      // โค้ดที่ต้องการให้ทำงานเมื่อปุ่มถูกกด
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/profile.png',
                                          width: 50,
                                          height: 50,
                                        ), // รูปภาพของปุ่ม
                                        Text('โปรไฟล์'), // ข้อความบนปุ่ม
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                    ),
                                    onPressed: () {
                                      // โค้ดที่ต้องการให้ทำงานเมื่อปุ่มถูกกด
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/resume.png',
                                          width: 50,
                                          height: 50,
                                        ), // รูปภาพของปุ่ม
                                        Text('ข้อมูลส่วนตัว'), // ข้อความบนปุ่ม
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // โค้ดที่ต้องการให้ทำงานเมื่อปุ่มถูกกด
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/bill.png',
                                          width: 50,
                                          height: 50,
                                        ), // รูปภาพของปุ่ม
                                        Text('ใบเสร็จ'), // ข้อความบนปุ่ม
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
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                    ),
                                    onPressed: () {
                                      // โค้ดที่ต้องการให้ทำงานเมื่อปุ่มถูกกด
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/seller.png',
                                          width: 50,
                                          height: 50,
                                        ), // รูปภาพของปุ่ม
                                        Text(
                                            'เลือกซื้อสินค้า'), // ข้อความบนปุ่ม
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                    ),
                                    onPressed: () {
                                      // โค้ดที่ต้องการให้ทำงานเมื่อปุ่มถูกกด
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/resume.png',
                                          width: 50,
                                          height: 50,
                                        ), // รูปภาพของปุ่ม
                                        Text('ข้อมูลส่วนตัว'), // ข้อความบนปุ่ม
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // โค้ดที่ต้องการให้ทำงานเมื่อปุ่มถูกกด
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/bill.png',
                                          width: 50,
                                          height: 50,
                                        ), // รูปภาพของปุ่ม
                                        Text('ใบเสร็จ'), // ข้อความบนปุ่ม
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
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                    ),
                                    onPressed: () {
                                      // โค้ดที่ต้องการให้ทำงานเมื่อปุ่มถูกกด
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/profile.png',
                                          width: 50,
                                          height: 50,
                                        ), // รูปภาพของปุ่ม
                                        Text('โปรไฟล์'), // ข้อความบนปุ่ม
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                    ),
                                    onPressed: () {
                                      // โค้ดที่ต้องการให้ทำงานเมื่อปุ่มถูกกด
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/resume.png',
                                          width: 50,
                                          height: 50,
                                        ), // รูปภาพของปุ่ม
                                        Text('ข้อมูลส่วนตัว'), // ข้อความบนปุ่ม
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // โค้ดที่ต้องการให้ทำงานเมื่อปุ่มถูกกด
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/bill.png',
                                          width: 50,
                                          height: 50,
                                        ), // รูปภาพของปุ่ม
                                        Text('ใบเสร็จ'), // ข้อความบนปุ่ม
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
