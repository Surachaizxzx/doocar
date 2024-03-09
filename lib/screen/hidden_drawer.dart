import 'package:doocar/Login_logout.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 90),
      child: Drawer(
        backgroundColor: Color.fromARGB(25, 255, 255, 255),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(
                "Surachai",
                style: TextStyle(
                  fontFamily: 'CustomFont',
                  fontSize: 16,
                  fontWeight: FontWeight
                      .normal, // This can be FontWeight.bold for the bold version
                ),
              ),
              accountEmail: const Text(
                "surachaikai2545@gmail.com",
                style: TextStyle(
                    fontFamily: 'CustomFont',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors
                        .white // This can be FontWeight.bold for the bold version
                    ),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset("assets/images/bmw.png"),
                ),
              ),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 253, 253, 253),
                image: DecorationImage(
                  image: AssetImage("assets/images/2.png"),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Login_logout_(),
          ],
        ),
      ),
    );
  }
}
