// ignore_for_file: camel_case_types, prefer_const_constructors, unnecessary_import, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_string_interpolations, sort_child_properties_last, prefer_interpolation_to_compose_strings, unused_import, use_key_in_widget_constructors, unused_local_variable, non_constant_identifier_names, avoid_unnecessary_containers, use_super_parameters, unused_field, library_private_types_in_public_api

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackmaster/features/user_auth/presentation/pages/home_page.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<DocumentSnapshot> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _fetchUserData();
  }

  Future<DocumentSnapshot> _fetchUserData() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('userProfile')
        .doc(userId)
        .get();

    return userSnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: HexColor('#9F70FD')),
      body: FutureBuilder<DocumentSnapshot>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            final userData = snapshot.data!;
            return ListView(
              children: [
                Container(
                  height: 200,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(color: HexColor('#ffe8e8')),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 110,
                        child: CircleAvatar(
                          radius: 80,
                          // Use user's profile image from Firestore
                          backgroundImage:
                              NetworkImage(userData.get('imageLink')),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(userData.get('name')),
                ),
                ListTile(
                  leading: Icon(Icons.email_outlined),
                  title: Text(FirebaseAuth.instance.currentUser?.email ??
                      'arjunfree256@gmail.com'),
                ),
                ListTile(
                  leading: Icon(Icons.school_outlined),
                  title: Text(userData.get('college')),
                ),
                ListTile(
                  leading: Icon(Icons.stacked_bar_chart_outlined),
                  title: Text(userData.get('department')),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_month_outlined),
                  title: Text(userData.get('year')),
                ),
                ListTile(
                  leading: Icon(Icons.grade_outlined),
                  title: Text(userData.get('section')),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  late SharedPreferences _prefs;
  bool _notificationsEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = _prefs.getBool('notificationsEnabled') ?? false;
    });
  }

  Future<void> _saveSettings() async {
    await _prefs.setBool('notificationsEnabled', _notificationsEnabled);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HexColor('#9F70FD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Notification',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
                Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                    _saveSettings();
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              _notificationsEnabled ? 'Enabled' : 'Disabled',
              style: TextStyle(
                fontSize: 16,
                color: _notificationsEnabled ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NotificationSettingsPage(),
  ));
}

class ThemeSelectionPage extends StatefulWidget {
  @override
  _ThemeSelectionPageState createState() => _ThemeSelectionPageState();
}

class _ThemeSelectionPageState extends State<ThemeSelectionPage> {
  ThemeMode _selectedTheme = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#9F70FD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: Text('Light Mode'),
              leading: Radio(
                value: ThemeMode.light,
                groupValue: _selectedTheme,
                onChanged: (value) {
                  setState(() {
                    _selectedTheme = value as ThemeMode;
                  });
                },
              ),
            ),
            ListTile(
              title: Text('Dark Mode'),
              leading: Radio(
                value: ThemeMode.dark,
                groupValue: _selectedTheme,
                onChanged: (value) {
                  setState(() {
                    _selectedTheme = value as ThemeMode;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_selectedTheme == ThemeMode.dark) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    result: (route) => false,
                  );
                } else {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    result: (route) => false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: _selectedTheme == ThemeMode.light
                    ? Colors.orange
                    : Colors.orange,
              ),
              child: Text(
                'Apply Theme',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageSettingsPage extends StatefulWidget {
  @override
  _LanguageSettingsPageState createState() => _LanguageSettingsPageState();
}

class _LanguageSettingsPageState extends State<LanguageSettingsPage> {
  String _selectedLanguage = 'english';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HexColor('#9F70FD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Language:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: 'english',
                  child: Text('English'),
                ),
                DropdownMenuItem<String>(
                  value: 'தமிழ்',
                  child: Text('தமிழ்'),
                ),
              ],
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  await _saveSettings();
                  _showSuccessMessage(_selectedLanguage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  'Apply Language',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveSettings() async {
    // You can add logic here to save the selected language preference.
    // For simplicity, let's assume the language is saved successfully.
    // Now, navigate to the appropriate home page based on the selected language.
    if (_selectedLanguage == 'english') {
      Navigator.pushReplacementNamed(context, '/home');
    } else if (_selectedLanguage == 'தமிழ்') {
      Navigator.pushReplacementNamed(context, '/tamil');
    }
  }

  void _showSuccessMessage(String selectedLanguage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Language Applied'),
          content: Text('Selected Language: $selectedLanguage'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class HousePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#ffebe3'),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            backgroundColor: HexColor('#9F70FD'),
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '\tLearnHub',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              background: Container(
                color: HexColor('#9F70FD'),
                child: Image.asset(
                  'images/learnhub.png',
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 20,
              right: 20,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  color: HexColor('#edb0ab'),
                  height: 250,
                  child: Column(children: [
                    Text(
                      '\nWaste Energy Calculation',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        '\n\t•	Predict the energy potential of waste, offering insights into sustainable energy production methods.\n\t•	Visualize the environmental impact, motivating users to reduce waste and harness renewable resources.')
                  ])),
            ),
          )),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 20,
              right: 20,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  color: HexColor('#edb0ab'),
                  height: 250,
                  child: Column(children: [
                    Text(
                      '\nElectricity Bill Calculation',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        '\n\t•	Provide real-time estimates of electricity bills based on consumption patterns.\n\t•	Offer personalized suggestions for energy-saving practices to lower bills and reduce carbon footprint.')
                  ])),
            ),
          )),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 20,
              right: 20,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  color: HexColor('#edb0ab'),
                  height: 250,
                  child: Column(children: [
                    Text(
                      '\nWallet',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        '\n\t•	Seamlessly track expenses related to waste management and energy usage.\n\t•	Enable budget management and financial transparency for sustainable living.')
                  ])),
            ),
          )),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
              left: 20,
              right: 20,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  color: HexColor('#edb0ab'),
                  height: 250,
                  child: Column(children: [
                    Text(
                      '\nImage Segregation with Gemini AI',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        '\n\t•	Utilize cutting-edge AI to accurately classify waste images into biodegradable and non-biodegradable categories.\n\t•	Educate users on proper disposal methods, promoting responsible recycling and waste reduction efforts.')
                  ])),
            ),
          )),
        ],
      ),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 25, 201, 204),
          title: Text(
            '         Health Lens',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'For inquiries, please contact us at:',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 12.0),
                Text(
                  'health.lens.offi@gmail.com',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}

class GetHelp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 25, 201, 204),
          title: Text(
            '         Health Lens',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'For inquiries, please contact us at:',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 12.0),
                Text(
                  'health.lens.offi@gmail.com',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
