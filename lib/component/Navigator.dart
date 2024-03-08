import 'package:doocar/screen/hidden_drawer.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:flutter/material.dart';
import '../screen/Pay_screen.dart';
import '../screen/buycar_screen.dart';
import '../screen/home_screen.dart';
import '../screen/setting_screen.dart';

class Navigatorbar extends StatefulWidget {
  const Navigatorbar({super.key});

  @override
  State<Navigatorbar> createState() => _NavigatorbarState();
}

class _NavigatorbarState extends State<Navigatorbar> {
  final _pageControlller = PageController();
  @override
  void dispose() {
    super.dispose();
    _pageControlller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      body: PageView(
        controller: _pageControlller,
        children: const <Widget>[
          Homescreen(),
          BuyMycar(),
          Pay_in_installments(),
          SettingProfile(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        color: Color.fromARGB(138, 255, 255, 255),
        controller: _pageControlller,
        flat: true,
        useActiveColorByDefault: false,
        items: const [
          RollingBottomBarItem(Icons.shopping_cart,
              label: 'Shop', activeColor: Colors.redAccent),
          RollingBottomBarItem(
            Icons.car_rental,
            label: 'Mycar',
            activeColor: Colors.blueAccent,
          ),
          RollingBottomBarItem(Icons.attach_money,
              label: 'Pay', activeColor: Colors.green),
          RollingBottomBarItem(Icons.attach_money,
              label: 'setting', activeColor: Colors.green),
        ],
        enableIconRotation: true,
        onTap: (index) {
          _pageControlller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
          );
        },
      ),
    );
  }
}
