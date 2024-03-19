import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class name extends StatefulWidget {
  const name({super.key});

  @override
  State<name> createState() => _nameState();
}
    File ?_selectedImage;

class _nameState extends State<name> {
    Future pickImage() async {
  final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

  if(returnedImage == null)return;
  setState((){
    _selectedImage = File(returnedImage!.path);
  });

}
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}