import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../component/my_textformfield.dart';

class regisSell extends StatefulWidget {
  regisSell({super.key});

  @override
  State<regisSell> createState() => _regisSellState();
}
  File ?_selectedImage;
class _regisSellState extends State<regisSell> {

    Future pickImage() async {
  final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

  if(returnedImage == null)return;
  setState((){
    _selectedImage = File(returnedImage!.path);
  });

}
  
  final CarnameController = TextEditingController();

  final PriceController = TextEditingController();

  final TypeController = TextEditingController();

  final InfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          //key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //     mainAxisAlignment: MainAxisAlignment.start,
                // children: [

                Text(
                  "กรุณากรอกข้อมูลและรายละเอียดของรถยนต์",
                  style: TextStyle(
                      fontFamily: 'Customfont',
                      fontSize: 34,
                      fontWeight: FontWeight.w900),
                ),
                // MytextField(
                //     Controller: CarnameController,
                //     hintText: 'รุ่นรถยนต์',
                //     obscureText: false,
                //     labelText: 'ใส่ชื่อรุ่นรถยนต์'),
                // const SizedBox(
                //   height: 20,
                // ),
                // MytextField(
                //     Controller: PriceController,
                //     hintText: 'ใส่ราคา',
                //     obscureText: false,
                //     labelText: 'ราคา'),
                // const SizedBox(
                //   height: 20,
                // ),
                // MytextField(
                //     Controller: TypeController,
                //     hintText: 'ประเภทรถ',
                //     obscureText: true,
                //     labelText: 'ประเภทรถ'),
                // const SizedBox(
                //   height: 20,
                // ),
                // MytextField(
                //     Controller: InfoController,
                //     hintText: 'ใส่ข้อมูลรถยนต์',
                //     obscureText: true,
                //     labelText: 'ข้อมูลรถยนต์'),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 550,
                  child: TextFormField(
                    controller: CarnameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณากรอกชื่อบัญชี';
                      }
                      return null;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "รุ่นรถ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: const Color.fromARGB(255, 218, 199, 221)
                          .withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'กรุณากรอกรุ่นรถ',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 550,
                  child: TextFormField(
                    controller: TypeController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณากรอกรุ่นรถยนต์';
                      }
                      return null;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "ประเภทรถ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: const Color.fromARGB(255, 218, 199, 221)
                          .withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'กรุณากรอกประเภทรถ',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 550,
                  child: TextFormField(
                    controller: PriceController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณากรอกประเภท';
                      }
                      return null;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "ราคารถ",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: const Color.fromARGB(255, 218, 199, 221)
                          .withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'กรุณากรอกราคารถ',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 550,
                  child: TextFormField(
                    controller: InfoController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'กรุณากรอกราคา';
                      }
                      return null;
                    },
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "ข้อมูลรถยนต์",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: const Color.fromARGB(255, 218, 199, 221)
                          .withOpacity(0.1),
                      filled: true,
                      prefixIcon: const Icon(Icons.person),
                      labelText: 'กรุณากรอกข้อมูลของรถยนต์',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      pickImage();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: const Color.fromARGB(255, 223, 187, 232),
                    ),
                    child: const Text(
                      "เพิ่มรูปภาพ",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: const Color.fromARGB(255, 223, 187, 232),
                    ),
                    child: const Text(
                      "ลงขายรถยนต์",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
