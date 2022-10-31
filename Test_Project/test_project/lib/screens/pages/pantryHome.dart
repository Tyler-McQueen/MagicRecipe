import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class pantryAddItem extends StatefulWidget {
  @override
  _pantryAddItem4State createState() => _pantryAddItem4State();
}

class _pantryAddItem4State extends State<pantryAddItem> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
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
      /*
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
      ),*/
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
                          onPressed: () {
                            final User? user = _auth.currentUser;
                            final databaseRef = db.collection("users").doc(user!.uid);
                            databaseRef.update({
                              "PantryItem": FieldValue.arrayRemove([itemDetail]),
                            });
                            print(user.uid);
                          },
                          icon: Icon(Icons.remove_circle_outline_rounded)),
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