import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  
  


  File? _image1;
  File? _image2;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
  final Color lightGrey = Color(0xFFBDBDBD);
  final Color accentBlue = Color.fromARGB(255, 35, 106, 172);
  // final Color accentBlue = Color.fromARGB(255, 219, 122, 31);
  final Color darkGrey = Color.fromARGB(255, 128, 127, 127);
  final Color mintGreen = Color(0xFF4DB6AC);
  final Color vibrantOrange = Color(0xFFFFA726);
    final Color teal = Color.fromARGB(255, 35, 129, 172);
  // final Color darkGrey = Color(0xFF616161);
  // final Color mintGreen = Color(0xFF4DB6AC);
  // final Color vibrantOrange = Color(0xFFFFA726);
  // final Color teal = Colors.teal;

    return Scaffold(
      appBar: AppBar(
        title: Text("Check Signature"),
        centerTitle: true,
        // backgroundColor: mintGreen,
        backgroundColor: teal,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: lightGrey,
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  // Image 1 Section
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Image 1\n"),
                            Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                color: darkGrey,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: EdgeInsets.all(4.0),
                              child: _image1 != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.file(
                                        _image1!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(Icons.add,
                                      size: 50, color: Colors.white),
                            ),
                            SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                pickImage(ImageSource.gallery, 1);
                              },
                              child: Text("Gallery"),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                pickImage(ImageSource.camera, 1);
                              },
                              child: Text("Camera"),
                            ),
                            SizedBox(height: 16),
                            Text("\nImage Uploaded\n    Successfully"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Image 2 Section
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentBlue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Image 2\n"),
                            Container(
                              width: 200,
                              height: 180,
                              decoration: BoxDecoration(
                                color: darkGrey,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: EdgeInsets.all(4.0),
                              child: _image2 != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.file(
                                        _image2!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Icon(Icons.add,
                                      size: 50, color: Colors.white),
                            ),
                            SizedBox(height: 12),
                            ElevatedButton(
                              onPressed: () {
                                pickImage(ImageSource.gallery, 2);
                              },
                              child: Text("Gallery"),
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                pickImage(ImageSource.camera, 2);
                              },
                              child: Text("Camera"),
                            ),
                            SizedBox(height: 16),
                            Text("\nWaiting For image \n"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Output place As Text"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentBlue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Check Signature"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentBlue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source, int imageNumber) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          if (imageNumber == 1) {
            _image1 = File(pickedFile.path);
          } else {
            _image2 = File(pickedFile.path);
          }
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
