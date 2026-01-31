import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/categoeis/edit.dart';
import 'package:untitled/notes/view.dart';

// ignore: camel_case_types
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

// ignore: camel_case_types
class _homepageState extends State<homepage> {
  // ignore: non_constant_identifier_names
  List<QueryDocumentSnapshot> Data = [];
  bool isloading = true;
  getdata() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
          Navigator.of(context).pushNamedAndRemoveUntil(
            'catigoris',
            (Route<dynamic> route) => false,
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        title: const Text(
          'Homepage',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushReplacementNamed('login');
            },
            icon: Icon(Icons.exit_to_app),
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
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Viewnote(
                          categoryid: Data[i].id,
                          name: Data[i]["name"],
                        ),
                      ),
                    );
                  },
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
                                            .doc(Data[i].id)
                                            .delete();
                                        Navigator.of(
                                          context,
                                        ).pushNamedAndRemoveUntil(
                                          'homepage',
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
                                            builder: (context) => editcategoris(
                                              docid: Data[i].id,
                                              oldname: Data[i]["name"],
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
                          Icon(Icons.folder, size: 120, color: Colors.amber),
                          Text(
                            "${Data[i]["name"]}",
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
