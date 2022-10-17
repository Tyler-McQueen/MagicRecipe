import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Shopping3 extends StatefulWidget {
  @override
  _Shopping3State createState() => _Shopping3State();
}

class _Shopping3State extends State<Shopping3> {
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
              crossAxisCount: 3,  
              crossAxisSpacing: 4.0,  
              mainAxisSpacing: 8.0,  
            ),
            children: snapshot.data!.docs.map((document) {
              return Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 6,
                  child: Text("Item Name: " + document['Name']),
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
