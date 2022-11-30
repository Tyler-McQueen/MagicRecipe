import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_project/screens/pages/pantryHome.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:test_project/screens/pages/barcodeTest.dart';
import 'package:test_project/screens/pages/barcodeTest2.dart';

class PantryAdd extends StatefulWidget {
  @override
  _PantryAddState createState() => _PantryAddState();
}

class _PantryAddState extends State<PantryAdd> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String search = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Builder(
                    builder: (context) {
                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                      var height = MediaQuery.of(context).size.height;
                      var width = MediaQuery.of(context).size.width;

                      return Container(
                        height: height,
                        width: width,
                        child: BarcodeTest4(),
                      );
                    },
                  ),
                ),
              ),
              icon: const Icon(Icons.search),
            )
          ],
          backgroundColor: Colors.green[400],
          title: Card(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search), hintText: 'Search...'),
              onChanged: (val) {
                setState(() {
                  search = val;
                });
              },
            ),
          )),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("items").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final documentSnapshot = snapshot.data?.docs;
            return ListView.builder(
                itemCount: documentSnapshot?.length,
                itemBuilder: (BuildContext context, int index) {
                  if (search.isEmpty) {
                    return Card(
                      elevation: 5,
                      color: Colors.white,
                      //margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // ignore: sort_child_properties_last
                      child: ListTile(
                          leading: Image(
                              image: NetworkImage(
                                  documentSnapshot![index]['img'])),
                          title: Text(documentSnapshot![index]['Name']),
                          trailing: IconButton(
                            onPressed: () {
                              Map<String, dynamic> map = {
                                'name': documentSnapshot![index]['Name'],
                                'img': documentSnapshot![index]['img']
                              };
                              final User? user = _auth.currentUser;
                              final databaseRef =
                                  db.collection("users").doc(user!.uid);
                              databaseRef.update({
                                "PantryItem": FieldValue.arrayUnion([map]),
                              });
                              print(user.uid);
                              AnimatedSnackBar(
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.green,
                                    height: 40,
                                    child: Text(
                                        '${documentSnapshot![index]['Name']} : Added To Your Pantry'),
                                  );
                                },
                              ).show(
                                context,
                              );
                            },
                            icon: Icon(Icons.add_circle_outline_rounded),
                          )),
                    );
                  }
                  if (documentSnapshot![index]['Name']
                      .toString()
                      .toLowerCase()
                      .startsWith(search.toLowerCase())) {
                    return Card(
                      elevation: 5,
                      color: Colors.white,
                      //margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // ignore: sort_child_properties_last
                      child: ListTile(
                          leading: Image(
                              image: NetworkImage(
                                  documentSnapshot![index]['img'])),
                          title: Text(documentSnapshot![index]['Name']),
                          trailing: IconButton(
                            onPressed: () {
                              Map<String, dynamic> map = {
                                'name': documentSnapshot![index]['Name'],
                                'img': documentSnapshot![index]['img']
                              };
                              final User? user = _auth.currentUser;
                              final databaseRef =
                                  db.collection("users").doc(user!.uid);
                              databaseRef.update({
                                "PantryItem": FieldValue.arrayUnion([map]),
                              });
                              print(user.uid);
                              AnimatedSnackBar(
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.green,
                                    height: 40,
                                    child: Text(
                                        '${documentSnapshot![index]['Name']} : Added To Your Pantry'),
                                  );
                                },
                              ).show(
                                context,
                              );
                            },
                            icon: Icon(Icons.add_circle_outline_rounded),
                          )),
                    );
                  }
                  ;
                  return Container();
                });
          }),
    );
  }
}
