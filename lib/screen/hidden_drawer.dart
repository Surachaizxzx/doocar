import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Surachai"),
            accountEmail: const Text("surachaikai2545@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("assets/images/bmw.png"),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 0, 0),
              image: DecorationImage(
                  image: AssetImage("assets/images/2.png"),
                  fit: BoxFit.fitWidth),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Edit Picture"),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      leading: Icon(Icons.edit),
                      title: Text("Edit Profile"),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      shape: Border(bottom: BorderSide.none),
                      leading: Icon(Icons.settings_applications),
                      title: Text("setting"),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      leading: Icon(Icons.logout_sharp),
                      title: Text("Logout"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
