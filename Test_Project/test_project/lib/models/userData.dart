import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final Timestamp? DateCreated;
  final String? email;
  final List<dynamic>? PantryItem;
  final List<dynamic>? ShoppingItems;

  UserData({
    this.DateCreated,
    this.email,
    this.PantryItem,
    this.ShoppingItems,
  });

  factory UserData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return UserData(
      DateCreated: data?['DateCreated'],
      email: data?['email'],
      PantryItem: data?['PantryItem'] as List<dynamic>,
      ShoppingItems: data?['ShoppingItems'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (DateCreated != null) "DateCreated": DateCreated,
      if (email != null) "email": email,
      if (PantryItem != null) "PantryItem": PantryItem,
      if (ShoppingItems != null) "ShoppingItems": ShoppingItems,
    };
  }
}
