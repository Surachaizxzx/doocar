import 'package:flutter/material.dart';

import '../component/my_textformfield.dart';

class regisSell extends StatelessWidget {
  regisSell({super.key});
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
                fontSize: 28,
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
            height: 20,
          ),
          SizedBox(
            width: 650,
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
                fillColor:
                    const Color.fromARGB(255, 218, 199, 221).withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.person),
                labelText: 'กรุณากรอกรุ่นรถ',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 350,
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
                fillColor:
                    const Color.fromARGB(255, 218, 199, 221).withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.person),
                labelText: 'กรุณากรอกประเภทรถ',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 350,
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
                fillColor:
                    const Color.fromARGB(255, 218, 199, 221).withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.person),
                labelText: 'กรุณากรอกราคารถ',
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 350,
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
                fillColor:
                    const Color.fromARGB(255, 218, 199, 221).withOpacity(0.1),
                filled: true,
                prefixIcon: const Icon(Icons.person),
                labelText: 'กรุณากรอกข้อมูลของรถยนต์',
              ),
            ),
          ),
            
          
        ],
      ),
        ),
              ),
      ),

      )
    );
  }
}
