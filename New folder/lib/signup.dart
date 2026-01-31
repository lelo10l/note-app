import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/textformfields.dart';

// ignore: camel_case_types
class signup extends StatefulWidget {
  const signup({super.key});
  @override
  State<signup> createState() => _loginState();
}

// ignore: camel_case_types
class _loginState extends State<signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: ListView(
          children: [
            Column(
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
                        'Register',
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
                        'Register with Our App',
                        style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                      ),
                    ),
                    Container(height: 20),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    customTextFeild(
                      hintText: 'Enter your Username',
                      mycontroller: username,
                      // ignore: body_might_complete_normally_nullable
                      validator: (val) {
                        if (val == "") {
                          return "please enter your username";
                        }
                      },
                    ),
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
                          return "password must at least be 8 Characters";
                        }
                      },
                    ),
                    Container(height: 150),
                    MaterialButton(
                      minWidth: 400,
                      height: 50,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      color: Colors.orange,
                      textColor: Colors.white,
                      onPressed: () async {
                        try {
                          // ignore: unused_local_variable
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                email: email.text,
                                password: password.text,
                              );
                          Navigator.of(
                            // ignore: use_build_context_synchronously
                            context,
                          ).pushReplacementNamed('homepage');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            // ignore: avoid_print
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            // ignore: avoid_print
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          // ignore: avoid_print
                          print(e);
                        }
                      },
                      child: Text(
                        'Signup',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(height: 40),
                    // ignore: avoid_unnecessary_containers
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already Have an Acount? ",
                            style: TextStyle(color: Colors.black),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(
                                context,
                              ).pushReplacementNamed('login');
                            },
                            child: Text(
                              "Login",
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
          ],
        ),
      ),
    );
  }
}
