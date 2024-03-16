// ignore_for_file: prefer_const_constructors, file_names, unused_element, use_super_parameters

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'dart:async';

class ImageDisplayPage extends StatelessWidget {
  final File selectedImage;

  const ImageDisplayPage({Key? key, required this.selectedImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#ffebe3'),
        appBar: _appBar(context),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
                Image.file(
                  selectedImage,
                  width: 300,
                  height: 300,
                ),
                SizedBox(height: 10),
                Text(
                  'Non-Biodegradable',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15),
                FutureBuilder(
                  future: Future.delayed(Duration(seconds: 2)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return Center(
                        child: Text(
                            '       Plastic-to-energy conversion typically involves a process called pyrolysis, where plastic is heated in the absence of oxygen to break it down into smaller molecules, producing a mixture of gases, liquids (pyrolysis oil), and char. This mixture can then be used to generate electrical energy through various methods such as combustion, gasification, or direct use in fuel cells. This process helps to mitigate plastic waste while simultaneously generating electricity, contributing to both waste management and energy production goals.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontSize: 12,
                            )),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
        backgroundColor: HexColor('#ea6c69'),
        title: Padding(
          padding: EdgeInsets.only(left: 70),
          child: SafeArea(
            child: Text(
              'EmpowerWaste',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
