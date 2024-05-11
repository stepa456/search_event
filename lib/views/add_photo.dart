import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Photo extends StatefulWidget {
  const Photo({Key? key}) : super(key: key);

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  late File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1D1E22),
        title: const Text(''),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.blue,
              child: const Text(
                "Выбрать изображение из галереи",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                pickImageForGallery(context);
              },
            ),
            const SizedBox(height: 20),
            MaterialButton(
              color: Colors.blue,
              child: const Text(
                "Сфотографировать",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                pickImageForCamera(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImageForCamera(BuildContext context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _selectedImage = File(pickedImage!.path);
    });
  }

  Future<void> pickImageForGallery(BuildContext context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(pickedImage!.path);
    });
  }
}
