import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BarcodeTest4 extends StatefulWidget {
  const BarcodeTest4({Key? key}) : super(key: key);
  @override
  State<BarcodeTest4> createState() => BarcodeTest4State();
}

class BarcodeTest4State extends State<BarcodeTest4> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: MobileScanner(
          allowDuplicates: false,
          onDetect: (barcode, args) async {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;

              debugPrint('Barcode found! $code');

              final itemsRef = db.collection('items');
              var data = await getdata(code).then((value) {
                return (value);
              });
              showDialog<String>(
                  context: context,
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
                                appBar:
                                    AppBar(title: const Text('Mobile Scanner')),
                                body: (Column(
                                  children: [
                                    Image(image: NetworkImage(data['img'])),
                                    Text(data['Name']),
                                    Text(data['UPC']),
                                    Text(data['NetWt']),
                                    // ignore: prefer_const_constructors
                                    Text(
                                        'Is this The Product You Would Like To Add?'),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Map<String, dynamic> map = {
                                                'name': data!['Name'],
                                                'img': data!['img']
                                              };
                                              final User? user =
                                                  _auth.currentUser;
                                              final databaseRef = db
                                                  .collection("users")
                                                  .doc(user!.uid);
                                              databaseRef.update({
                                                "PantryItem":
                                                    FieldValue.arrayUnion(
                                                        [map]),
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Yes')),
                                        const SizedBox(width: 50),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('No')),
                                      ],
                                    )
                                  ],
                                )),
                              ),
                            );
                          },
                        ),
                      ));
            }
          }),
    );
  }
}

getdata(code) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('items')
      .limit(1)
      .where('UPC', isEqualTo: '$code')
      .get();

  for (var doc in querySnapshot.docs) {
    // Getting data directly
    // String name = doc.get('Name');
    // Getting data from map
    Map<String, dynamic> data = doc.data();
    return data;
  }
}
