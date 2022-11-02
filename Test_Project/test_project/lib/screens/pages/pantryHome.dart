import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class pantryAddItem extends StatefulWidget {
  @override
  _pantryAddItem4State createState() => _pantryAddItem4State();
}

class _pantryAddItem4State extends State<pantryAddItem> {
  int count = 0;
  String name = "";
  String search = "";

  @override  
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    return Scaffold(
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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
        builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          Map<String, dynamic> document = snapshot.data!.data() as Map<String, dynamic>;
          final List<Map<String, dynamic>> itemDetailList = (document['PantryItem'] as List).map((itemDetail) => itemDetail as Map<String, dynamic>).toList();
          
          return ListView.builder(
            itemCount: itemDetailList.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> itemDetail = itemDetailList[index];
              final String name = itemDetail['name'];

              if(search.isEmpty){
                return Card(
                elevation: 5,
                color: Colors.white,
                //margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  leading: Image(image: NetworkImage(itemDetail['img'])),
                  title: Text('$name'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            final User? user = _auth.currentUser;
                            final databaseRef =
                                db.collection("users").doc(user!.uid);
                            databaseRef.update({
                              "PantryItem":
                                  FieldValue.arrayRemove([itemDetail]),
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
              }
              if(itemDetail['name'].toString().toLowerCase().startsWith(search.toLowerCase())){
                return Card(
                elevation: 5,
                color: Colors.white,
                //margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  leading: Image(image: NetworkImage(itemDetail['img'])),
                  title: Text('$name'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            final User? user = _auth.currentUser;
                            final databaseRef =
                                db.collection("users").doc(user!.uid);
                            databaseRef.update({
                              "PantryItem":
                                  FieldValue.arrayRemove([itemDetail]),
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
              }
              return Container();
            },
          );
        },
      ),
    );
  }
}