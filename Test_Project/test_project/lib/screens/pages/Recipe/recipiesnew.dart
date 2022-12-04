import 'package:animated_snack_bar/animated_snack_bar.dart';
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
      var name = (element['itemID']);
      final recipewithitem = db
          .collection('recipes')
          .where("Items", arrayContains: name)
          .get()
          .then((value) {
        for (var element in value.docs) {
          var list1 = [];
          var list3 = [];
          for (var element in userData.PantryItem!) {
            list1.add(element['itemID']);
            list3.add(element['itemID']);
          }

          var list1Rem = list1.toSet().toList();
          var list3Rem = list3.toSet().toList();

          var list2 = element['Items'];
          var list4 = element['Items'];

          var list2Rem = list2.toSet().toList();
          var list4Rem = list4.toSet().toList();

          list1Rem.removeWhere((item) => !list2Rem.contains(item));
          list4Rem.removeWhere((item) => list3Rem.contains(item));

          print('This is missing: $list4');
          var decimalMatch = (list1Rem.length / list2Rem.length);
          var percentMatch = (decimalMatch * 100);
          var percentMatchRounded = roundDouble(percentMatch, 2);

          Map<String, dynamic> map = {
            'name': element['Name'],
            'ingredients': element['Ingredients'],
            'img': element['img'],
            'percentMatch': percentMatchRounded,
            'itemsHad': list1Rem,
            'missingItems': list4Rem,
            'Directions': element['Directions'],
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
                  child: InkWell(
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
                    onTap: () => showDialog<String>(
                      builder: (BuildContext context) => AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        content: Builder(
                          builder: (context) {
                            // Get available height and width of the build area of this widget. Make a choice depending on the size.
                            var height = MediaQuery.of(context).size.height;
                            var width = MediaQuery.of(context).size.width;
                            return SizedBox(
                                height: height,
                                width: width,
                                child: Scaffold(
                                  appBar: AppBar(
                                    title: Text(name),
                                    backgroundColor: Colors.green[400],
                                  ),
                                  body: Center(
                                      child: SingleChildScrollView(
                                    child: Column(children: [
                                      SizedBox(
                                        height: 200,
                                        width: double.infinity,
                                        child: Image.network(
                                          itemDetail['img'],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 20,
                                          width: double.infinity,
                                          child: Text('Ingredients',
                                              textAlign: TextAlign.center)),
                                      SizedBox(
                                        height: 150,
                                        width: double.infinity,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              itemDetail['ingredients'].length,
                                          itemBuilder: (context, int index) {
                                            return ListTile(
                                                title: Row(
                                              children: [
                                                Text(itemDetail['ingredients']
                                                    [index]['name']),
                                                Text(': '),
                                                Text(itemDetail['ingredients']
                                                    [index]['Qty']),
                                              ],
                                            ));
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                        width: double.infinity,
                                        child: Text('Directions',
                                            textAlign: TextAlign.center),
                                      ),
                                      SizedBox(
                                        height: 300,
                                        width: double.infinity,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              itemDetail['Directions'].length,
                                          itemBuilder: (context, int index) {
                                            return ListTile(
                                              title: Text(
                                                  itemDetail['Directions']
                                                      [index]),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                          height: 20,
                                          width: double.infinity,
                                          child: Text('Items You Have',
                                              textAlign: TextAlign.center)),
                                      SizedBox(
                                        height: 150,
                                        width: double.infinity,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              itemDetail['itemsHad'].length,
                                          itemBuilder: (context, int index) {
                                            return ListTile(
                                              title: Text(itemDetail['itemsHad']
                                                  [index]),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                        width: double.infinity,
                                        child: Text('Items You Dont Have',
                                            textAlign: TextAlign.center),
                                      ),
                                      SizedBox(
                                        height: 150,
                                        width: double.infinity,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount:
                                              itemDetail['missingItems'].length,
                                          itemBuilder: (context, int index) {
                                            return ListTile(
                                                title: Text(
                                                    itemDetail['missingItems']
                                                        [index]),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    Map<String, dynamic> map = {
                                                      'name': itemDetail[
                                                              'missingItems']
                                                          [index],
                                                    };
                                                    final User? user =
                                                        _auth.currentUser;
                                                    final databaseRef = db
                                                        .collection("users")
                                                        .doc(user!.uid);
                                                    databaseRef.update({
                                                      "ShoppingItems":
                                                          FieldValue.arrayUnion(
                                                              [map]),
                                                    });
                                                    AnimatedSnackBar(
                                                      mobileSnackBarPosition:
                                                          MobileSnackBarPosition
                                                              .bottom,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          color: Colors.green,
                                                          //height: 50,
                                                          child: Text(
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                              '${itemDetail['missingItems'][index]} : Added To Your Shopping List'),
                                                        );
                                                      },
                                                    ).show(context);
                                                  },
                                                  icon: const Icon(Icons
                                                      .add_circle_outline_rounded),
                                                ));
                                          },
                                        ),
                                      ),
                                    ]),
                                  )),
                                ));
                          },
                        ),
                      ),
                      context: context,
                    ),
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
