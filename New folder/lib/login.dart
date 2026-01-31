import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/textformfields.dart';

// ignore: camel_case_types
class login extends StatefulWidget {
  const login({super.key});
  @override
  State<login> createState() => _loginState();
}

// ignore: camel_case_types
class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool isloading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                children: [
                  Container(height: 20),
                  Container(
                    width: 150,
                    height: 150,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.grey[300],
                    ),
                    child: Image.asset('images/logo.png', width: 100),
                  ),
                  Column(
                    children: [
                      Container(height: 50),
                      Container(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Login To Continue Using This App',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Container(height: 20),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      customTextFeild(
                        hintText: 'Email',
                        mycontroller: email,
                        // ignore: body_might_complete_normally_nullable
                        validator: (val) {
                          if (val == "") {
                            return "please enter your email";
                          }
                        },
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'password',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      customTextFeild(
                        hintText: 'Password',
                        mycontroller: password,
                        // ignore: body_might_complete_normally_nullable
                        validator: (val) {
                          if (val == "") {
                            return "password mus't at least be 8 Charechters";
                          }
                        },
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ),
                      Container(height: 100),
                      MaterialButton(
                        minWidth: 400,
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        color: Colors.orange,
                        textColor: Colors.white,
                        onPressed: () async {
                          if (formState.currentState!.validate()) {
                            try {
                              isloading = true;
                              // ignore: unused_local_variable
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                    email: email.text,
                                    password: password.text,
                                  );
                              Navigator.of(
                                context,
                              ).pushReplacementNamed('homepage');
                            } on FirebaseAuthException catch (e) {
                              isloading = false;
                              if (e.code == 'user-not-found') {
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                print('Wrong password provided for that user.');
                              }
                            }
                          } else {
                            print('not validate');
                          }
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(height: 30),
                      MaterialButton(
                        minWidth: 375,
                        height: 50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        color: Colors.red[900],
                        textColor: Colors.white,
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login With Google',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Container(width: 10),
                            Image.asset('images/4.png', width: 20),
                          ],
                        ),
                      ),
                      Container(height: 60),
                      // ignore: avoid_unnecessary_containers
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have an Acount?",
                              style: TextStyle(color: Colors.black),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(
                                  context,
                                ).pushReplacementNamed('signup');
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
