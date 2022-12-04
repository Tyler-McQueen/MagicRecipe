// ignore: file_names
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:test_project/screens/pages/Barcode/barcodeTest2.dart';

// ignore: use_key_in_widget_constructors
class PantryAdd extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
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
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  content: Builder(
                    builder: (context) {
                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                      var height = MediaQuery.of(context).size.height;
                      var width = MediaQuery.of(context).size.width;

                      return SizedBox(
                        height: height,
                        width: width,
                        child: const BarcodeTest4(),
                      );
                    },
                  ),
                ),
              ),
              icon: const Icon(Icons.barcode_reader),
            )
          ],
          backgroundColor: Colors.green[400],
          title: Card(
            child: TextField(
              decoration: const InputDecoration(
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
              return const Center(
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
                                'itemID': documentSnapshot![index]['itemID'],
                                'img': documentSnapshot![index]['img'],
                              };
                              final User? user = _auth.currentUser;
                              final databaseRef =
                                  db.collection("users").doc(user!.uid);
                              databaseRef.update({
                                "PantryItem": FieldValue.arrayUnion([map]),
                              });
                              AnimatedSnackBar(
                                mobileSnackBarPosition:
                                    MobileSnackBarPosition.bottom,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.green,
                                    //height: 50,
                                    child: Text(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        '${documentSnapshot![index]['Name']} : Added To Your Pantry'),
                                  );
                                },
                              ).show(context);
                            },
                            icon: const Icon(Icons.add_circle_outline_rounded),
                          )),
                    );
                  }
                  if (documentSnapshot![index]['Name']
                      .toString()
                      .toLowerCase()
                      .contains(search.toLowerCase())) {
                    return Card(
                      elevation: 5,
                      color: Colors.white,
                      //margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      // ignore: sort_child_properties_last
                      child: ListTile(
                          onTap: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  content: Builder(
                                    builder: (context) {
                                      // Get available height and width of the build area of this widget. Make a choice depending on the size.
                                      var height =
                                          MediaQuery.of(context).size.height;
                                      var width =
                                          MediaQuery.of(context).size.width;
                                      return SizedBox(
                                          height: height,
                                          width: width,
                                          child: Column(children: [
                                            Image(
                                                image: NetworkImage(
                                                    documentSnapshot![index]
                                                        ['img'])),
                                            Text(documentSnapshot![index]
                                                ['Name']),
                                            Text(documentSnapshot![index]
                                                ['NetWt']),
                                            Text(documentSnapshot![index]
                                                ['UPC']),
                                          ]));
                                    },
                                  ),
                                ),
                              ),
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
                              AnimatedSnackBar(
                                mobileSnackBarPosition:
                                    MobileSnackBarPosition.bottom,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(8),
                                    color: Colors.green,
                                    //height: 50,
                                    child: Text(
                                        style: const TextStyle(
                                            color: Colors.white),
                                        '${documentSnapshot[index]['Name']} : Added To Your Pantry'),
                                  );
                                },
                              ).show(context);
                            },
                            icon: const Icon(Icons.add_circle_outline_rounded),
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
