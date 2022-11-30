import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeData {
  final String? name;

  RecipeData({
    this.name,
  });

  factory RecipeData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return RecipeData(name: data?['name']);
  }

  Map<String, dynamic> toFirestore() {
    return {if (name != null) "name": name};
  }
}
