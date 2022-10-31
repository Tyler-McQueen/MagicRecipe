import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_project/screens/pages/pantryHome.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';

class PantryAdd extends StatefulWidget {
  @override
  _PantryAddState createState() => _PantryAddState();
}

class _PantryAddState extends State<PantryAdd> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Container(
          width: double.infinity,
          height: 40,
          color: Colors.white,
          child: const Center(
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search for something',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.barcode_reader)),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("items").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              shrinkWrap: true,
              children: snapshot.data!.docs.map((document) {
                return Card(
                  elevation: 5,
                  color: Colors.white,
                  //margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // ignore: sort_child_properties_last
                  child: ListTile(
                      leading: Image(image: NetworkImage(document['img'])),
                      title: Text(document['Name']),
                      trailing: IconButton(
                        onPressed: () {
                          Map<String, dynamic> map = {
                            'name': document['Name'],
                            'img': document['img']
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
                                    '${document['Name']} : Added To Your Pantry'),
                              );
                            },
                          ).show(
                            context,
                          );
                        },
                        icon: Icon(Icons.add_circle_outline_rounded),
                      )),
                );
              }).toList(),
            );
          }),
    );
  }
}
