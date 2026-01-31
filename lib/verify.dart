import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class verifyemail extends StatefulWidget {
  const verifyemail({super.key});

  @override
  State<verifyemail> createState() => _verifyemailState();
}

// ignore: camel_case_types
class _verifyemailState extends State<verifyemail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'verify Email',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: FirebaseAuth.instance.currentUser!.emailVerified
          ? Column(children: [Text('Welcome')])
          : MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.currentUser!.sendEmailVerification();
              },
              color: Colors.red,
              textColor: Colors.white,
              child: Text('verify your Email'),
            ),
    );
  }
}
