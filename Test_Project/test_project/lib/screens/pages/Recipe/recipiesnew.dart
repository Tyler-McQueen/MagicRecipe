import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_project/models/userData.dart';
import 'dart:math';

double roundDouble(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

getEmail() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final User? user = auth.currentUser;
  final ref = db.collection("users").doc(user!.uid).withConverter(
        fromFirestore: UserData.fromFirestore,
        toFirestore: (UserData city, _) => city.toFirestore(),
      );

  var databaseRef = db.collection("users").doc(user!.uid);
  final updates = <String, dynamic>{
    "Recipes": [],
  };
  databaseRef.update(updates);

  final docSnap = await ref.get();
  final userData = docSnap.data();
  if (userData != null) {
    for (var element in userData.PantryItem!) {
      var name = (element['name']);
      final recipewithitem = db
          .collection('recipes')
          .where("Ingredients", arrayContains: name)
          .get()
          .then((value) {
        for (var element in value.docs) {
          var list1 = [];
          for (var element in userData.PantryItem!) {
            list1.add(element['name']);
          }
          var list2 = element['Ingredients'];

          list1.removeWhere((item) => !list2.contains(item));

          var decimalMatch = (list1.length / list2.length);
          var percentMatch = (decimalMatch * 100);
          var percentMatchRounded = roundDouble(percentMatch, 2);

          Map<String, dynamic> map = {
            'name': element['Name'],
            'ingredients': element['Ingredients'],
            'img': element['img'],
            'percentMatch': percentMatchRounded,
          };
          final User? user = auth.currentUser;
          final databaseRef = db.collection("users").doc(user!.uid);
          databaseRef.update({
            "Recipes": FieldValue.arrayUnion([map]),
          });
        }
      });
    }
  } else {}
}

// ignore: use_key_in_widget_constructors
class RecipiesNew1 extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _Recipies1NewState createState() => _Recipies1NewState();
}

class _Recipies1NewState extends State<RecipiesNew1> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String search = "";

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          getEmail();
        },
        label: const Text('Generate'),
        icon: const Icon(Icons.create),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          Map<String, dynamic> document =
              snapshot.data!.data() as Map<String, dynamic>;
          final List<Map<String, dynamic>> itemDetailList =
              (document['Recipes'] as List)
                  .map((itemDetail) => itemDetail as Map<String, dynamic>)
                  .toList();
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: itemDetailList.length,
            itemBuilder: (BuildContext context, int index) {
              final Map<String, dynamic> itemDetail = itemDetailList[index];
              final String name = itemDetail['name'];
              if (search.isEmpty) {
                return Card(
                  elevation: 5,
                  color: Colors.white,
                  // ignore: sort_child_properties_last
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(children: [
                      Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Image.network(
                          itemDetail['img'],
                          fit: BoxFit.fill,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Text(
                          name,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                );
              }
              if (itemDetail['name']
                  .toString()
                  .toLowerCase()
                  .contains(search.toLowerCase())) {
                return Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(children: [Text(name)]),
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
