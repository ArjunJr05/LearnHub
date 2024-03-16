// ignore_for_file: prefer_const_constructors, use_super_parameters

import 'dart:io';
import 'package:hackmaster/features/user_auth/presentation/pages/image%20display.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class ImageBot extends StatefulWidget {
  const ImageBot({Key? key}) : super(key: key);

  @override
  State<ImageBot> createState() => _ImageBotState();
}

class _ImageBotState extends State<ImageBot> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#ffebe3'),
      appBar: AppBar(
        title: Text(
          '     EmpowerWaste',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: HexColor('#ea6c69'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/image.gif',
                width: 230,
                height: 230,
              ),
              SizedBox(height: 20),
              _selectedImage != null
                  ? Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor('#ea6c69'),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            _showImageSelectionOptions();
                          },
                          child: Text(
                            'Scan Prescription',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                        color: HexColor('#ea6c69'),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            _showImageSelectionOptions();
                          },
                          child: Text(
                            'Scan',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImageSelectionOptions() {
    showModalBottomSheet(
      backgroundColor: HexColor('##fed8bf'),
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              onTap: () {
                _pickImageFromCamera();
                Navigator.pop(context);
              },
              leading: Icon(Icons.camera_alt),
              title: Text('Select by Camera'),
            ),
            ListTile(
              onTap: () {
                _pickImageFromGallery();
                Navigator.pop(context);
              },
              leading: Icon(Icons.photo),
              title: Text('Select by Gallery'),
            ),
          ],
        );
      },
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _navigateToImageDisplay(returnedImage);
  }

  Future _pickImageFromCamera() async {
    final XFile? returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      _navigateToImageDisplay(returnedImage);
    }
  }

  void _navigateToImageDisplay(XFile? pickedImage) {
    if (pickedImage == null) return;
    setState(() {
      _selectedImage = File(pickedImage.path);
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageDisplayPage(selectedImage: _selectedImage!),
      ),
    );
  }
}
