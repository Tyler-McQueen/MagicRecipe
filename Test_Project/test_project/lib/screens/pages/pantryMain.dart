import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_project/screens/pages/pantryHome.dart';
import 'package:test_project/screens/pages/pantryAdd.dart';

class Pantry2 extends StatefulWidget {
  @override
  _Pantry2State createState() => _Pantry2State();
}

class _Pantry2State extends State<Pantry2> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: pantryHome(),
    );
  }
}

class pantryHome extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return pantryAdd();
            }),
          );
        },
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          //final DocumentSnapshot<Object?>? document = snapshot.data;
          //final DocumentSnapshot<Object?> documentData = document!;
          //document as Map<String, dynamic>;
          Map<String, dynamic> document =
              snapshot.data!.data() as Map<String, dynamic>;
          final List<Map<String, dynamic>> itemDetailList =
              (document['PantryItem'] as List)
                  .map((itemDetail) => itemDetail as Map<String, dynamic>)
                  .toList();

          return ListView.builder(
            itemCount: itemDetailList.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> itemDetail = itemDetailList[index];
              final String name = itemDetail['name'];
              return Card(
                elevation: 5,
                color: Colors.white,
                //margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  leading: Image(image: NetworkImage(itemDetail['img'])),
                  title: Text('Total price: $name'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add_circle_outline_rounded)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add_circle_outline_rounded)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class pantryAdd extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        actions: [],
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
