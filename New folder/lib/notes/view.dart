import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/notes/add.dart';
import 'package:untitled/notes/edit.dart';

// ignore: camel_case_types
class Viewnote extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final String categoryid;
  final String name;
  // ignore: non_constant_identifier_names
  const Viewnote({super.key, required this.categoryid, required this.name});

  @override
  // ignore: library_private_types_in_public_api
  _ViewnoteState createState() => _ViewnoteState();
}

// ignore: camel_case_types
class _ViewnoteState extends State<Viewnote> {
  // ignore: non_constant_identifier_names
  List<QueryDocumentSnapshot> Data = [];
  bool isloading = true;
  getdata() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.categoryid)
        .collection("note")
        .get();
    Data.addAll(querySnapshot.docs);
    isloading = false;
    setState(() {});
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[100],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  addnote(docid: widget.categoryid, name: widget.name),
            ),
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('homepage', (route) => false);
            },
            child: Text(
              "Homepage",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacementNamed('login');
            },
            icon: Icon(Icons.exit_to_app, size: 25),
          ),
        ],
      ),
      body: isloading == true
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: Data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, i) {
                return InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          actions: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'please choose:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                              Colors.amber[100],
                                            ),
                                      ),
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('categories')
                                            .doc(widget.categoryid)
                                            .collection("note")
                                            .doc(Data[i].id)
                                            .delete();
                                        Navigator.of(
                                          context,
                                        ).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => Viewnote(
                                              categoryid: widget.categoryid,
                                              name: widget.name,
                                            ),
                                          ),
                                          (Route<dynamic> route) => false,
                                        );
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      label: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                              Colors.amber[100],
                                            ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) => editnotes(
                                              notedocid: Data[i].id,
                                              oldname: Data[i]["note"],
                                              categoryid: widget.categoryid,
                                              namepage: widget.name,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.orange,
                                      ),
                                      label: Text(
                                        'Edit',
                                        style: TextStyle(color: Colors.orange),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    color: Colors.amber[50],
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(
                            "${Data[i]["note"]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
