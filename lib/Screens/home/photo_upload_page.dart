import 'package:flutter/material.dart';
import 'package:autism_detection/Screens/home/result_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({super.key});

  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text(
                'اضافة صورة',
                style: TextStyle(
                  
                fontFamily: "Alexandria",
                  color: Colors.blue,
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 120),

            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.grey),
                ),
                child: _image == null
                    ? const Icon(Icons.add_a_photo, size: 50)
                    : Image.file(
                        File(_image!.path),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 100),
            if (_image != null) // يظهر زر الإرسال فقط عند اختيار صورة
              ElevatedButton(
              onPressed: () {
              Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return const ResultPage();
                          }),
                        );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              child: const Text(
                ' ارسال',
                style: TextStyle(
                fontFamily: "Alexandria",
                          color: Colors.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
