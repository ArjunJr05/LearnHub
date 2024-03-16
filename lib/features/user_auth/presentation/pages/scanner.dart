// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hackmaster/quiz/screens/quiz/components/quiz_screen.dart';
import 'package:hackmaster/quiz/screens/welcome/welcom.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(
    home: PageScanner(),
  ));
}

class PageScanner extends StatefulWidget {
  const PageScanner({Key? key}) : super(key: key);

  @override
  State<PageScanner> createState() => _PageScannerState();
}

class _PageScannerState extends State<PageScanner> {
  late Future<String> _userNameFuture;

  @override
  void initState() {
    super.initState();
    _userNameFuture = _fetchUserName();
  }

  Future<String> _fetchUserName() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('userProfile')
        .doc(userId)
        .get();

    String userName = userSnapshot.get('name');

    return userName;
  }

  @override
  Widget build(BuildContext context) {
    final double purpleContainerHeight = 130;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: purpleContainerHeight,
              decoration: BoxDecoration(
                color: HexColor('#9F70FD'), // Setting color here
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<String>(
                          future: _userNameFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                !snapshot.hasData) {
                              return CircularProgressIndicator();
                            } else {
                              return Text(
                                '\t\tWelcome ${snapshot.data}!...',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.black, width: 2),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Search...",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => QuizScreen()));
                    },
                    child: Container(
                      height: 250,
                      width: 270,
                      decoration: BoxDecoration(
                        color: HexColor('#E6A4B4'),
                        border: Border.all(color: Colors.black54, width: 1),
                      ),
                      child: buildCourseItem(),
                    ),
                  ),
                  SizedBox(width: 30),
                  Container(
                    height: 250,
                    width: 270,
                    decoration: BoxDecoration(
                      color: HexColor('#E6A4B4'), // Setting color here
                      border: Border.all(color: Colors.black54, width: 1),
                    ),
                    child: buildCourseItem(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 30),
                  Container(
                    height: 250,
                    width: 270,
                    decoration: BoxDecoration(
                      color: HexColor('#E6A4B4'), // Setting color here
                      border: Border.all(color: Colors.black54, width: 1),
                    ),
                    child: buildCourseItem(),
                  ),
                  SizedBox(width: 30),
                  Container(
                    height: 250,
                    width: 270,
                    decoration: BoxDecoration(
                      color: HexColor('#E6A4B4'), // Setting color here
                      border: Border.all(color: Colors.black54, width: 1),
                    ),
                    child: buildCourseItem(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCourseItem() {
    return Column(
      children: [
        SizedBox(height: 15),
        Container(
          alignment: Alignment.topCenter,
          height: 125,
          width: 200,
          color: Colors.white,
          child: Image.asset(
            'images/image.png',
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Introduction to Flutter',
          style: TextStyle(fontSize: 18),
        ),
        Row(
          children: [
            Icon(Icons.book),
            Text('1 chapter'),
            SizedBox(width: 70),
            Icon(Icons.timer_rounded),
            Text('1:00')
          ],
        ),
        Row(
          children: [
            SizedBox(width: 10),
            Text(
              'Free',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(width: 150),
            Icon(
              Icons.school_outlined,
              size: 38,
            ),
          ],
        ),
      ],
    );
  }
}
