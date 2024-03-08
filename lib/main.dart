import 'package:flutter/material.dart';

import 'component/Navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeAnimationCurve: Curves.bounceIn,
      theme: ThemeData.light(),
      home: Navigatorbar(),
    );
  }
}
