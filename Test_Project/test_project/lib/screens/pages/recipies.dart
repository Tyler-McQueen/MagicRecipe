import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Recipies1 extends StatefulWidget {
  @override
  _Recipies1State createState() => _Recipies1State();
}

class _Recipies1State extends State<Recipies1> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  height: double.infinity,
                  child: Text(
                  document['Name'],
                  textAlign: TextAlign.center),
                  color: Colors.green[200],
                ),
              );
            }).toList(),
          );
        }
      ),

    );
  }
}

