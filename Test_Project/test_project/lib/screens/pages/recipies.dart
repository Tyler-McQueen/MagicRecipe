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
  final itemList = [];
  final itemListText = [];
  docRef.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      data.forEach((key, value) { 
        itemList.add(Container(
          padding: const EdgeInsets.all(8),
          color: Colors.teal[100],
          child: Text('$key: $value'),
        ));
        itemListText.add('$key: $value');
        print('$key: $value');
      });
    },
    onError: (e) => print("Error getting document: $e"),
  );
  return itemList;
}


Future<void> _dialogBuilder(BuildContext context) {
    var itemlist = getItemInfo();
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
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
              children: itemlist,
            )
          ),
        );
      },
    );
}
