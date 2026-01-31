import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/customtextfield.dart';
import 'package:untitled/notes/view.dart';

// ignore: camel_case_types
class addnote extends StatefulWidget {
  final String docid;
  final String name;
  const addnote({super.key, required this.docid, required this.name});

  @override
  State<addnote> createState() => _addnoteState();
}

// ignore: camel_case_types
class _addnoteState extends State<addnote> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController note = TextEditingController();

  bool isloading = false;

  Future<void> addnote() async {
    CollectionReference notesCollection = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.docid)
        .collection("note");
    if (formState.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        // ignore: unused_local_variable
        DocumentReference response = await notesCollection.add({
          'note': note.text,
        });
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                Viewnote(categoryid: widget.docid, name: widget.name),
          ),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        // ignore: avoid_print
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
          'Add notes',
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
                hintText: "enter your note",
                mycontroller: note,
                validator: (val) {
                  if (val == "") {
                    return "please enter note";
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
                addnote();
              },
              color: Colors.amber,
              child: const Text(
                "ADD",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
