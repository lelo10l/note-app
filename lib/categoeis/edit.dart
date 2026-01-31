import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/components/customtextfield.dart';

// ignore: camel_case_types
class editcategoris extends StatefulWidget {
  final String docid;
  final String oldname;
  const editcategoris({super.key, required this.docid, required this.oldname});

  @override
  State<editcategoris> createState() => _addcategorisState();
}

// ignore: camel_case_types
class _addcategorisState extends State<editcategoris> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  CollectionReference catigory = FirebaseFirestore.instance.collection(
    'categories',
  );
  bool isloading = false;

  Future<void> editcategoris() async {
    if (formState.currentState!.validate()) {
      try {
        isloading = true;
        setState(() {});
        await catigory.doc(widget.docid).update({"name": name.text});
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil("homepage", (Route<dynamic> route) => false);
      } catch (e) {
        print("ERror $e");
      }
      // ignore: unused_local_variable
    }
  }

  @override
  void initState() {
    name.text = widget.oldname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isdark = theme.brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isdark ? Colors.grey[900] : Colors.amber[100],
      appBar: AppBar(
        title: Text(
          'edit Categories',
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
                hintText: "edit name",
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
                editcategoris();
              },
              color: Colors.amber,
              child: const Text(
                "Save",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
