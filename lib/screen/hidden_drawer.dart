import 'package:doocar/Login_logout.dart';

import 'package:flutter/material.dart';
import 'package:doocar/service/classuser.dart';

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
              shrinkWrap: false,
              itemCount: snapshot.data!.length,
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
                                  height: 130,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 140),
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
                                      left: 40,
                                    ),
                                    child: Column(
                                      children: [
                                        UserAccountsDrawerHeader(
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
                                          currentAccountPicture: Container(
                                            width: 100,
                                            height: 100,
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
                                                  100,
                                                ),
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              child: ClipOval(
                                                child: Image.asset(
                                                  'assets/images/me.jpg',
                                                  width: 100,
                                                  height: 100,
                                                ),
                                              ),
                                            ),
                                          ),
                                          accountName: Text(user.username),
                                          accountEmail: Text(user.email),
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
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(96, 219, 217, 200),
                            border: Border.all(
                              width: 5,
                              color: Colors.white,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                30,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              96, 219, 217, 200),
                                        ), // สีพื้นหลังของปุ่มเมื่อปุ่มอยู่ในสถานะปกติ
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                18.0), // กำหนดรัศมีของขอบปุ่ม
                                            side: const BorderSide(
                                              color: Colors.white, width: 4,
                                              // กำหนดสีขอบของปุ่ม
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        // โค้ดที่ต้องการให้ทำงานเมื่อปุ่มถูกกด
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/user.png',
                                            width: 70,
                                            height: 50,
                                          ), // รูปภาพของปุ่ม
                                          const Text(
                                              'โปรไฟล์'), // ข้อความบนปุ่ม
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              96, 219, 217, 200),
                                        ), // สีพื้นหลังของปุ่มเมื่อปุ่มอยู่ในสถานะปกติ
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                18.0), // กำหนดรัศมีของขอบปุ่ม
                                            side: const BorderSide(
                                              color: Colors.white, width: 4,
                                              // กำหนดสีขอบของปุ่ม
                                            ),
                                          ),
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
                                          const Text(
                                              'ข้อมูลส่วนตัว'), // ข้อความบนปุ่ม
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              96, 219, 217, 200),
                                        ), // สีพื้นหลังของปุ่มเมื่อปุ่มอยู่ในสถานะปกติ
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                18.0), // กำหนดรัศมีของขอบปุ่ม
                                            side: const BorderSide(
                                              color: Colors.white, width: 4,
                                              // กำหนดสีขอบของปุ่ม
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        // โค้ดที่ต้องการให้ทำงานเมื่อปุ่มถูกกด
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/payment.png',
                                            width: 70,
                                            height: 50,
                                          ), // รูปภาพของปุ่ม
                                          const Text(
                                              'ใบเสร็จ'), // ข้อความบนปุ่ม
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              96, 219, 217, 200),
                                        ), // สีพื้นหลังของปุ่มเมื่อปุ่มอยู่ในสถานะปกติ
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                18.0), // กำหนดรัศมีของขอบปุ่ม
                                            side: const BorderSide(
                                              color: Colors.white, width: 4,
                                              // กำหนดสีขอบของปุ่ม
                                            ),
                                          ),
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
                                          const Text(
                                              'เลือกซื้อสินค้า'), // ข้อความบนปุ่ม
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              96, 219, 217, 200),
                                        ), // สีพื้นหลังของปุ่มเมื่อปุ่มอยู่ในสถานะปกติ
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                18.0), // กำหนดรัศมีของขอบปุ่ม
                                            side: const BorderSide(
                                              color: Colors.white, width: 4,
                                              // กำหนดสีขอบของปุ่ม
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        // โค้ดที่ต้องการให้ทำงานเมื่อปุ่มถูกกด
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/car-dealer.png',
                                            width: 50,
                                            height: 50,
                                          ), // รูปภาพของปุ่ม
                                          const Text(
                                              'รถที่สนใจ'), // ข้อความบนปุ่ม
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          const Color.fromARGB(
                                              96, 219, 217, 200),
                                        ), // สีพื้นหลังของปุ่มเมื่อปุ่มอยู่ในสถานะปกติ
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                18.0), // กำหนดรัศมีของขอบปุ่ม
                                            side: const BorderSide(
                                              color: Colors.white, width: 4,
                                              // กำหนดสีขอบของปุ่ม
                                            ),
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        // โค้ดที่ต้องการให้ทำงานเมื่อปุ่มถูกกด
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Image.asset(
                                            'assets/images/exit.png',
                                            width: 50,
                                            height: 50,
                                          ), // รูปภาพของปุ่ม
                                          const Text(
                                              'ออกจากระบบ'), // ข้อความบนปุ่ม
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/car-insurance.png",
                                  width: 100,
                                  height: 70,
                                ),
                              ],
                            ),
                            const Column(
                              children: [
                                Text(
                                  "ไมล์เดิม 100%",
                                  style: TextStyle(
                                    fontFamily: 'CustomFont',
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Image.asset(
                                      "assets/images/accept.png",
                                      width: 20,
                                      height: 20,
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Image.asset(
                                  "assets/images/car.png",
                                  width: 100,
                                  height: 70,
                                ),
                              ],
                            ),
                            const Column(
                              children: [
                                Text(
                                  "รถคุณภาพดี",
                                  style: TextStyle(
                                    fontFamily: 'CustomFont',
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                TextButton(
                                    onPressed: () {},
                                    child: Image.asset(
                                      "assets/images/accept.png",
                                      width: 20,
                                      height: 20,
                                    ))
                              ],
                            )
                          ],
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
