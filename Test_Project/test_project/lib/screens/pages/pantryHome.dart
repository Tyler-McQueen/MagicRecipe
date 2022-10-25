import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class pantryAddItem extends StatefulWidget {
  @override
  _pantryAddItem4State createState() => _pantryAddItem4State();
}

class _pantryAddItem4State extends State<pantryAddItem> {
  @override
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: null,
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        actions: [
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("items").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,  
              crossAxisSpacing: 4.0,  
              mainAxisSpacing: 4.0,  
            ),
            children: snapshot.data!.docs.map((document) {
              return Card(
                elevation:5,
                color: Colors.green[200],
                margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(children: <Widget>[
                  Text(document['Name']),
                  Image.network(
                    document['img'],
                    fit: BoxFit.fill,
                  ),
                ]),
              );
            }).toList(),
          );

          /*
          return GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,  
              crossAxisSpacing: 4.0,  
              mainAxisSpacing: 4.0,  
            ),
            children: snapshot.data!.docs.map((document) {
              return Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  height: double.infinity,
                  child: InkWell(
                    child: Column(children: <Widget>[
                        Flexible(
                          flex: 8,
                          fit: FlexFit.tight,
                          child: Image.network(
                            document['img'],
                            fit: BoxFit.fill,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(document['Name'],textAlign: TextAlign.center,),
                        ),
                    ]),
                    onTap: (){
                      final User? user = _auth.currentUser;
                      final databaseRef = db.collection("users").doc(user!.uid);
                      databaseRef.update({
                        "pantryItems": FieldValue.arrayUnion([document['Name']]),
                      });
                      print(user.uid);
                    },
                    ),
                  ),
                );
            }).toList(),
          );*/
        }
      ),

    );
  }
}

