import 'package:doocar/Login_logout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Pay_in_installments extends StatelessWidget {
  const Pay_in_installments({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Input',
      home: NumberInputForm(),
      debugShowCheckedModeBanner: false, // เพิ่มบรรทัดนี้เพื่อลบแบนเนอร์ debug
    );
  }
}

class NumberInputForm extends StatefulWidget {
  @override
  _NumberInputFormState createState() => _NumberInputFormState();
}

class _NumberInputFormState extends State<NumberInputForm> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiple Inputs',
      home: MultiInputForm(),
      debugShowCheckedModeBanner: false, 
    );
  }
}

class MultiInputForm extends StatefulWidget {
  @override
  _MultiInputFormState createState() => _MultiInputFormState();
}

class _MultiInputFormState extends State<MultiInputForm> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  String result = '';
  String result2 = '';
  String result3 = '';
  String result4 = '';
  String result5 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
<<<<<<< Updated upstream
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/m.jpg'),
=======
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pay.png'),
>>>>>>> Stashed changes
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
               const SizedBox(height:200),
              TextFormField(
                controller: _controller1,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: const InputDecoration(
                  labelText: 'ราคารถ',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white, 
                  filled: true,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controller2,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: const InputDecoration(
                  labelText: 'ดอกเบี้ย',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white, 
                  filled: true,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controller3,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: const InputDecoration(
                  labelText: 'เงินดาวน์',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white, 
                  filled: true,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _controller4,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                decoration: const InputDecoration(
                  labelText: 'ปี',
                  border: OutlineInputBorder(),
                  fillColor: Colors.white, 
                  filled: true,
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  double price = double.tryParse(_controller1.text) ?? 0;
                  double price2 = double.tryParse(_controller2.text) ?? 0;
                  double price3 = double.tryParse(_controller3.text) ?? 0;
                  double price4 = double.tryParse(_controller4.text) ?? 0;

                  double calculatedResult = price - ((price * price3) / 100);
                  double calculatedResult2 = (calculatedResult * price2) / 100;
                  double calculatedResult3 = calculatedResult2 * price4;
                  double calculatedResult4 = calculatedResult3 + calculatedResult;
                  double calculatedResult5 = calculatedResult4 / (price4 * 12);

                  // แสดงผลลัพธ์เป็น Alert Dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('ผลลัพธ์'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('เงินดาวน์: $calculatedResult บาท'),
                            Text('เงินดอกเบี้ย: $calculatedResult2 บาท/ต่อปี 1'),
                            Text('ราคาดอกเบี้ยต่อปี: $calculatedResult3 บาท/$price4 ปี'),
                            Text('ยอดที่ต้องจ่ายจริง: $calculatedResult4 บาท'),
                            Text('ยอดที่ต้องจ่ายจริง: $calculatedResult5 บาท/เดือน'),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('ปิด'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 0, 0, 0), 
  ),
                child: const Text('คำนวณ',style: TextStyle(
      color: Colors.white,),
                
              ),
              ),
              const SizedBox(height: 50),
              
            ],
          ),
        ),
      ),
    );
  }
}