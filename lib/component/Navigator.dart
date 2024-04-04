import 'package:doocar/screen/hidden_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:flutter/material.dart';
import '../screen/Pay_screen.dart';
import '../screen/buycar_screen.dart';
import '../screen/home_screen.dart';

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
      body: Expanded(
        child: PageView(
          controller: _pageControlller,
          children: const <Widget>[
            Homescreen(),
            Pay_in_installments(),
            NavBar(),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Expanded(
        child: RollingBottomBar(
          color: Color.fromARGB(255, 255, 202, 57),
          itemColor: Color.fromARGB(255, 0, 0, 0),
          controller: _pageControlller,
          flat: true,
          useActiveColorByDefault: false,
          items: const [
            RollingBottomBarItem(FontAwesomeIcons.bagShopping,
                label: 'หน้าเเรก', activeColor: Colors.redAccent),
            RollingBottomBarItem(Icons.attach_money,
                label: 'ค่างวด', activeColor: Colors.green),
            RollingBottomBarItem(Icons.keyboard_control_sharp,
                label: 'เมนู', activeColor: Color.fromARGB(255, 0, 0, 0)),
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
      ),
    );
  }
}
