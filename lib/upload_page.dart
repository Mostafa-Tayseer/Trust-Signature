import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Signature"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.amber,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  //     Expanded(
                  //   child: Container(
                  //     height: double.infinity,
                  //     child: Icon(Icons.add),
                  //     color: Colors.green,
                  //   ),
                  // ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Image 1\n"),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              width: 200,
                              height: 200,
                              color: Colors.purple,
                              child: _image1 != null
                                  ? Image.file(_image1!, fit: BoxFit.cover)
                                  : Icon(Icons.add,
                                      size: 50, color: Colors.white),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                pickImage(ImageSource.gallery,
                                    1); // للمعرض والصورة الأولى
                              },
                              child: Text("Gallary"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                pickImage(ImageSource.camera,
                                    1); // للكاميرا والصورة الأولى
                              },
                              child: Text("Camera"),
                            ),
                            Text("\nImage Uploaded\n    successfuly"),
                          ],
                        ),
                      ),
                      color: Colors.greenAccent,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Image 2\n"),
                            Container(
                              padding: EdgeInsets.all(4.0),
                              width: 200,
                              height: 200,
                              color: Colors.brown,
                              child: _image2 != null
                                  ? Image.file(_image2!, fit: BoxFit.cover)
                                  : Icon(Icons.add,
                                      size: 50, color: Colors.white),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                pickImage(ImageSource.gallery,
                                    2); // للمعرض والصورة التانية
                              },
                              child: Text("Gallary"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                pickImage(ImageSource.camera,
                                    2); // للكاميرا والصورة التانية
                              },
                              child: Text("Camera"),
                            ),
                            Text("\nWiating For image \n"),
                          ],
                        ),
                      ),
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("Output place As Text"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            // Container(
            //   alignment: Alignment(0.0, 0.0),
            //   height: 40,
            //   width: double.infinity,
            //   color: Colors.red,
            //   child: ElevatedButton(onPressed: (){}, child: Text("Check")),
            // ),
            SizedBox(
              height: 10,
            ),
            //   Container(
            //     alignment: Alignment.center,
            //     height: 40,
            //     width: double.infinity,
            //     color: Colors.red,
            //     child: ElevatedButton(
            //       onPressed: (){},
            //        child: Text("Check"),
            //        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(
            // Colors.yellow,),),
            //   ),
            //   ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text("check signature"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
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
