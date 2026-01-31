import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:untitled/categoeis/add.dart';
import 'package:untitled/homepage.dart';
import 'package:untitled/login.dart';
import 'package:untitled/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/verify.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // initialize analytics to ensure native analytics lib is included
  // this prevents FCM warning about missing analytics library
  try {
    FirebaseAnalytics.instance;
  } catch (_) {}
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
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    final ThemeMode nextMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    setState(() {
      _themeMode = nextMode;
    });
    _saveTheme(nextMode);
  }

  Future<void> _loadTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isDark = prefs.getBool('isDarkMode') ?? false;
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', mode == ThemeMode.dark);
  }

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
    _loadTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // light theme colors
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        primaryColor: Colors.orange,
        scaffoldBackgroundColor: Colors.amber[100],
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.orangeAccent,
          foregroundColor: Colors.white,
        ),
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
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          titleTextStyle: const TextStyle(
            color: Colors.orange,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: Colors.orange),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.orangeAccent,
          foregroundColor: Colors.white,
        ),
      ),
      themeMode: _themeMode,
      home: FirebaseAuth.instance.currentUser == null
          ? login()
          : homepage(onToggleTheme: _toggleTheme),
      routes: {
        "signup": (context) => signup(),
        "login": (context) => login(),
        "homepage": (context) => homepage(onToggleTheme: _toggleTheme),
        "verify": (context) => verifyemail(),
        "catigoris": (context) => addcategoris(),
      },
    );
  }
}
