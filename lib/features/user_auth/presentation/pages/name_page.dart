// ignore_for_file: prefer_const_constructors, sort_child_properties_last, no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously, use_super_parameters

import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hackmaster/features/user_auth/presentation/pages/home_page.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class NamePage extends StatefulWidget {
  const NamePage({Key? key}) : super(key: key);

  @override
  State<NamePage> createState() => _NamePageState();
}

class _NamePageState extends State<NamePage> {
  Uint8List _image = Uint8List(0);
  late TextEditingController _nameController;
  late TextEditingController _collegeController;
  late TextEditingController _departmentController;
  late TextEditingController _yearController;
  late TextEditingController _sectionController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _collegeController = TextEditingController();
    _departmentController = TextEditingController();
    _yearController = TextEditingController();
    _sectionController = TextEditingController(); // Added
  }

  Future<Uint8List> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Images Selected');
      return Uint8List(0);
    }
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    _navigateToImageDisplay(img);
  }

  void _navigateToImageDisplay(Uint8List pickedImage) {
    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> saveProfileAndNavigate() async {
    setState(() {
      _isLoading = true;
    });

    String name = _nameController.text;
    String college = _collegeController.text;
    String department = _departmentController.text;
    String year = _yearController.text;
    String section = _sectionController.text; // Added

    if (name.isEmpty ||
        _image.isEmpty ||
        college.isEmpty ||
        department.isEmpty ||
        year.isEmpty ||
        section.isEmpty) {
      // Modified
      _showErrorPopup(
          "Name, image, college, department, year, and section are required."); // Modified
      setState(() {
        _isLoading = false;
      });
      return;
    }

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;

      await saveProfile(
          userId, name, college, department, year, section, _image); // Modified

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> saveProfile(String userId, String name, String college,
      String department, String year, String section, Uint8List image) async {
    // Modified
    try {
      String imagePath = 'images/$userId/profile.jpg';
      await firebase_storage.FirebaseStorage.instance
          .ref(imagePath)
          .putData(image);

      String imageUrl = await firebase_storage.FirebaseStorage.instance
          .ref(imagePath)
          .getDownloadURL();

      await FirebaseFirestore.instance
          .collection('userProfile')
          .doc(userId)
          .set({
        'name': name,
        'college': college,
        'department': department,
        'year': year,
        'section': section, // Added
        'imageLink': imageUrl,
      });
    } catch (error) {
      print('Error saving profile: $error');
    }
  }

  void _showErrorPopup(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  _image.isNotEmpty
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(_image),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          child: Icon(
                            Icons.person,
                            size: 64,
                            color: Colors.black,
                          ),
                        ),
                  Positioned(
                    child: IconButton(
                      onPressed: selectImage,
                      icon: const Icon(Icons.add_a_photo),
                    ),
                    bottom: -10,
                    left: 80,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your Name',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _collegeController,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your College',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _departmentController,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your Department',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _yearController,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your Year',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _sectionController, // Added
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your Section', // Added
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                ),
                onPressed: () {
                  saveProfileAndNavigate();
                },
                child: _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: HexColor('#FDBF60'),
      title: Padding(
        padding: const EdgeInsets.only(left: 70),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: NamePage(),
  ));
}
