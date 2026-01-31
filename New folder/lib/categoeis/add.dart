import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/customtextfield.dart';

// ignore: camel_case_types
class addcategoris extends StatefulWidget {
  const addcategoris({super.key});

  @override
  State<addcategoris> createState() => _addcategorisState();
}

// ignore: camel_case_types
class _addcategorisState extends State<addcategoris> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  CollectionReference catigory = FirebaseFirestore.instance.collection(
    'categories',
  );
  bool isloading = false;

  Future<void> addcategoris() async {
    if (formState.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        // ignore: unused_local_variable
        DocumentReference response = await catigory.add({
          'name': name.text,
          'id': FirebaseAuth.instance.currentUser!.uid,
        });
        Navigator.of(context).pushReplacementNamed("homepage");
      } catch (e) {
        print("ERror $e");
      }
      // ignore: unused_local_variable
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        title: Text(
          'Add Categoris',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: formState,
        child: Column(
          children: [
            Container(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              child: customTextFeildadd(
                hintText: "enter name",
                mycontroller: name,
                validator: (val) {
                  if (val == "") {
                    return "please enter name";
                  }
                  return null;
                },
              ),
            ),
            MaterialButton(
              minWidth: 150,
              height: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPressed: () {
                addcategoris();
              },
              color: Colors.amber,
              child: const Text("ADD"),
            ),
          ],
        ),
      ),
    );
  }
}
