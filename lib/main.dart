// ignore_for_file: constant_identifier_names, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackmaster/chat/bloc/bloc.dart';
import 'package:hackmaster/chat/system/auth.dart';
import 'package:hackmaster/features/user_auth/presentation/pages/login_page.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:hackmaster/features/app/splash_screen/splash_screen.dart';
import 'package:hackmaster/features/user_auth/presentation/pages/home_page.dart';
import 'package:hackmaster/features/user_auth/presentation/pages/name_page.dart';
import 'package:hackmaster/features/user_auth/presentation/pages/sign_up.dart';

import 'package:flutter_gemini/flutter_gemini.dart';

const APIKEY = 'AIzaSyBaagmsjX_sdwZuQDjqD1sy414kZnjSbgc';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? savedEmail = prefs.getString('email');
  String? savedPassword = prefs.getString('password');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Hive.initFlutter();
  await Hive.openBox(boxName);
  await Hive.openBox(userData);
  Gemini.init(apiKey: APIKEY);
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyByFHFrXGx_An9v5Q7MywRZ-LGzOd7Mnl8",
        appId: "1:115253835472:web:5b7f9869575e4ac4d210d5",
        messagingSenderId: "115253835472",
        projectId: "hackmaster-7505b",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(ProviderScope(child: MyApp(savedEmail, savedPassword)));
}

class MyApp extends StatelessWidget {
  final String? savedEmail;
  final String? savedPassword;

  MyApp(this.savedEmail, this.savedPassword);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'LearnHub',
        home: SplashScreen(
          child: savedEmail != null && savedPassword != null
              ? AutoLoginScreen(savedEmail, savedPassword)
              : LoginPage(),
        ),
        routes: {
          '/login': (context) => LoginPage(),
          '/signUp': (context) => SignUpPage(),
          '/home': (context) => HomePage(),
          '/name': (context) => NamePage(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 99, 20, 235),
            background: Color.fromARGB(255, 238, 236, 239),
          ),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class AutoLoginScreen extends StatelessWidget {
  final String? email;
  final String? password;

  AutoLoginScreen(this.email, this.password);

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
