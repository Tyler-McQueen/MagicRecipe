import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class Recipies1 extends StatefulWidget {
  @override
  _Recipies1State createState() => _Recipies1State();
}

class _Recipies1State extends State<Recipies1> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String search = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
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
        body: Column(children: <Widget>[
          Container(
            child: Text('Pantry'),
          ),
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("items")
                      .snapshots(),
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
                                  title: Text(documentSnapshot[index]['Name']),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Map<String, dynamic> map = {
                                        'name': documentSnapshot[index]['Name'],
                                        'img': documentSnapshot[index]['img']
                                      };
                                      final User? user = _auth.currentUser;
                                      final databaseRef =
                                          db.collection("users").doc(user!.uid);
                                      databaseRef.update({
                                        "PantryItem":
                                            FieldValue.arrayUnion([map]),
                                      });
                                      print(user.uid);
                                      AnimatedSnackBar(
                                        builder: (BuildContext context) {
                                          return Container(
                                            padding: const EdgeInsets.all(8),
                                            color: Colors.green,
                                            height: 40,
                                            child: Text(
                                                '${documentSnapshot[index]['Name']} : Added To Your Pantry'),
                                          );
                                        },
                                      ).show(
                                        context,
                                      );
                                    },
                                    icon:
                                        Icon(Icons.add_circle_outline_rounded),
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
                                          documentSnapshot[index]['img'])),
                                  title: Text(documentSnapshot[index]['Name']),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Map<String, dynamic> map = {
                                        'name': documentSnapshot[index]['Name'],
                                        'img': documentSnapshot[index]['img']
                                      };
                                      final User? user = _auth.currentUser;
                                      final databaseRef =
                                          db.collection("users").doc(user!.uid);
                                      databaseRef.update({
                                        "PantryItem":
                                            FieldValue.arrayUnion([map]),
                                      });
                                      print(user.uid);
                                      AnimatedSnackBar(
                                        builder: (BuildContext context) {
                                          return Container(
                                            padding: const EdgeInsets.all(8),
                                            color: Colors.green,
                                            height: 40,
                                            child: Text(
                                                '${documentSnapshot[index]['Name']} : Added To Your Pantry'),
                                          );
                                        },
                                      ).show(
                                        context,
                                      );
                                    },
                                    icon:
                                        Icon(Icons.add_circle_outline_rounded),
                                  )),
                            );
                          }
                          ;
                          return Container();
                        });
                  }))
        ]));
  }
}
