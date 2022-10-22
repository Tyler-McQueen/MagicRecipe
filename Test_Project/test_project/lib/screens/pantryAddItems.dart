import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class pantryAddItem extends StatefulWidget {
  @override
  _pantryAddItem4State createState() => _pantryAddItem4State();
}

class _pantryAddItem4State extends State<pantryAddItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      floatingActionButton: null,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("items").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
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
                    borderRadius: BorderRadius.only(
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
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  height: double.infinity,
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
                ),
              );
            }).toList(),
          );
        }
      ),

    );
  }
}

