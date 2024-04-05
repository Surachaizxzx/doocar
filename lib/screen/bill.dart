import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textController = TextEditingController();
  String _qrData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              height: 400,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                  fit: BoxFit.cover,
                  "https://media.discordapp.net/attachments/1209129164204937296/1225599796849410159/qr-code-generated-7.png?ex=6621b7c2&is=660f42c2&hm=2b6e359c8612a63e7674269761ce0308558fa2c1ee480c6926cbf93ea1ddb5cd&=&format=webp&quality=lossless&width=216&height=385"),
            )
          ],
        ),
      ),
    );
  }
}
