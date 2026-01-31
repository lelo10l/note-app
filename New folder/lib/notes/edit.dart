import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/customtextfield.dart';
import 'package:untitled/notes/view.dart';

// ignore: camel_case_types
class editnotes extends StatefulWidget {
  final String notedocid;
  final String oldname;
  final String categoryid;
  final String namepage;
  const editnotes({
    super.key,
    required this.notedocid,
    required this.oldname,
    required this.categoryid,
    required this.namepage,
  });

  @override
  State<editnotes> createState() => _addnotesState();
}

// ignore: camel_case_types
class _addnotesState extends State<editnotes> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController note = TextEditingController();
  bool isloading = false;

  Future<void> editnotes() async {
    CollectionReference name = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.categoryid)
        .collection("note");
    if (formState.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        await name.doc(widget.notedocid).update({"note": note.text});
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                Viewnote(categoryid: widget.categoryid, name: widget.namepage),
          ),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        print("ERror $e");
      }
      // ignore: unused_local_variable
    }
  }

  @override
  void initState() {
    note.text = widget.oldname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      appBar: AppBar(
        title: Text(
          'edit note',
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
                mycontroller: note,
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
                editnotes();
              },
              color: Colors.amber,
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
