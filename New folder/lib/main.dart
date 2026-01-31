import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/categoeis/add.dart';
import 'package:untitled/homepage.dart';
import 'package:untitled/login.dart';
import 'package:untitled/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/verify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Configure Firebase Auth settings to bypass reCAPTCHA issues
  FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        // ignore: avoid_print
        print('User is currently signed out!');
      } else {
        // ignore: avoid_print
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange[50],
          titleTextStyle: TextStyle(
            color: Colors.orange,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.orange),
        ),
      ),
      home: FirebaseAuth.instance.currentUser == null ? login() : homepage(),
      routes: {
        "signup": (context) => signup(),
        "login": (context) => login(),
        "homepage": (context) => homepage(),
        "verify": (context) => verifyemail(),
        "catigoris": (context) => addcategoris(),
      },
    );
  }
}
