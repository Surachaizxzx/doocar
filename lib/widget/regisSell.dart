import 'package:doocar/component/my_textformfield.dart';
import 'package:flutter/material.dart';

class regisSell extends StatelessWidget {
  regisSell({super.key});
  final CarnameController = TextEditingController();
  final PriceController = TextEditingController();
  final TypeController = TextEditingController();
  final InfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Form(
          child: Column(
        children: [
          Text(
            "กรุณากรอกข้อมูลและรายละเอียดของรถยนต์",
            style: TextStyle(
                fontFamily: 'Customfont',
                fontSize: 28,
                fontWeight: FontWeight.w900),
          ),
          MytextField(
                controller: CarnameController,
                hintText: 'Enter your name',
                obscureText: false,
                labelText: 'Name'),
            const SizedBox(
              height: 20,
            ),    
            MytextField(
                controller: emailController,
                hintText: 'Enter your email',
                obscureText: false,
                labelText: 'Email'),
            const SizedBox(
              height: 20,
            ),    
            MytextField(
                controller: passwordController,
                hintText: 'Enter your password',
                obscureText: true,
                labelText: 'password'),
            const SizedBox(
              height: 20,
            ),    
            MytextField(
                controller: repasswordController,
                hintText: 'Enter your password again',
                obscureText: true,
                labelText: 'Re-password'),
            const SizedBox(
              height: 20,
            ),
        ],
      )),
    );
  }
}
