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
  final itemListText = [];
  docRef.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      final List<Map> itemList = [];
      data.forEach((key, value) { 
        itemList.add({"id": key, "name": "Product $value"});
        itemListText.add('$key: $value');
        print('$key: $value');
      });
    },
    onError: (e) => print("Error getting document: $e"),
  );
  
}


Future<void> _dialogBuilder(BuildContext context) {
  //final List<Map> myProducts =
  //    List.generate(100000, (index) => {"id": index, "name": "Product $index"})
  //        .toList();
    final List<Map> myProducts =  getItemInfo();  
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var data = getItemInfo();
        return AlertDialog(
          title: const Text('Add New Items'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: myProducts.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(myProducts[index]["name"]),
              );
            }),
          ),
        );
      },
    );
}
