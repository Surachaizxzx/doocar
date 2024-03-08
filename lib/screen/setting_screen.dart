import 'package:flutter/material.dart';

import 'login.dart';

class SettingProfile extends StatelessWidget {
  const SettingProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        leading: Image.asset(
          "assets/images/3.png",
          color: const Color.fromARGB(179, 255, 0, 0),
          width: 200,
          height: 100,
        ),
        leadingWidth: 100,
        title: const Text('ตั้งค่าบัญชีผู้ใช้'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 120, vertical: 30),
              child: const Text(
                ' My Profile',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  fontFamily: AutofillHints.birthday,
                ),
              ),
            ),
            Container(
              child: CircleAvatar(
                backgroundColor: Colors.white70,
                child: Image.asset(
                  'assets/images/3.png',
                  width: 30,
                  height: 10,
                ),
                radius: 30,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Surachai Subnalsing',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  fontFamily: AutofillHints.birthday,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(350, 60),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(179, 0, 0, 0),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(350, 60),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Setting",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(179, 0, 0, 0),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginApp(),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    fixedSize: const Size(350, 60),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 250, 0, 0),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
