import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:test_project/screens/pages/pantryHome.dart';
import 'package:test_project/screens/pages/pantryAdd.dart';

class Pantry2 extends StatefulWidget {
  @override
  _Pantry2State createState() => _Pantry2State();
}

class _Pantry2State extends State<Pantry2> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: pantryHome(),
    );
  }
}

class pantryHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return pantryAdd();
              }),
            );
          },
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('View Details'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return pantryAdd();
              }),
            );
          },
        ),
      ),
    );
  }
}

class pantryAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.white,
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
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs.map((document) {
              return Card(
                elevation:5,
                color: Colors.white,
                //margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                // ignore: sort_child_properties_last
                child: ListTile(
                  leading: Image(
                    image: NetworkImage(document['img'])
                  ),
                  title: Text(document['Name']),
                  trailing:IconButton(
                    onPressed: (){

                    },
                    icon: Icon(Icons.add_circle_outline_rounded),
                  )
                ),
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