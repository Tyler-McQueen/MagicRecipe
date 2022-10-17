import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pantry2 extends StatefulWidget {
  @override
  _Pantry2State createState() => _Pantry2State();
  
}

class _Pantry2State extends State<Pantry2> {
  int count = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("PANTRY"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _dialogBuilder(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}

getItemInfo(){
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final docRef = db.collection("items").doc("E5x7qOXHZWQHubo30TKn");
  docRef.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      return data;
    },
    onError: (e) => print("Error getting document: $e"),
  );
}


Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var data = getItemInfo();
        return AlertDialog(
          title: const Text('Add New Items'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[100],
                  child: const Text("Item 1"),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[200],
                  child: const Text('Item 2'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[300],
                  child: const Text('Item 3'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[400],
                  child: const Text('Item 4'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[500],
                  child: const Text('Item 5'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[600],
                  child: const Text('Item 6'),
                ),
              ],
            )
          ),
        );
      },
    );
}
