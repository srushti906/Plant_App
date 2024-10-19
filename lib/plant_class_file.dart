// // // lib/plant_class_file.dart
 import 'package:flutter/material.dart';

// // class Plant {
// //   final String name;
// //   final String scientificName;
// //   final String category;
// //   final String description;
// //   final String imageUrl;
// //   final double price;

// //   Plant({
// //     required this.name,
// //     required this.scientificName,
// //     required this.category,
// //     required this.description,
// //     required this.imageUrl,
// //     required this.price,
// //   });
// // }
// class Plant {
//   final String id;
//   final String name;
//   final String scientificName;
//   final String description;
//   final double price;
//   final String imageUrl;
//   final String category;

//   Plant({
//     required this.id,
//     required this.name,
//     required this.scientificName,
//     required this.description,
//     required this.price,
//     required this.imageUrl,
//     required this.category,
//   });

//   factory Plant.fromDocument(Map<String, dynamic> docData, String docId) {
//     return Plant(
//       id: docId,
//       name: docData['name']??'',
//       scientificName: docData['scientificName']??'',
//       description: docData['description']??'',
//       price: docData['price'].toDouble()??0.0,
//       imageUrl: docData['imageUrl']??'',
//       category: docData['category']??'',
//     );

    
//   }

  
// //   factory Plant.fromDocument(Map<String, dynamic> docData, String docId) {
// //   double price = 0.0;
// //   if (docData['price'] != null) {
// //     if (docData['price'] is int) {
// //       price = docData['price'].toDouble();
// //     } else if (docData['price'] is double) {
// //       price = docData['price'];
// //     } else if (docData['price'] is String) {
// //       try {
// //         price = double.parse(docData['price']);
// //       } catch (e) {
// //         print("Error: unable to parse price string");
// //       }
// //     } else {
// //       print("Error: price is not a number");
// //     }
// //   }

// //   return Plant(
// //     id: docId,
// //     name: docData['name'] ?? '',
// //     scientificName: docData['scientificName'] ?? '',
// //     description: docData['description'] ?? '',
// //     price: price,
// //     imageUrl: docData['imageUrl'] ?? '',
// //     category: docData['category'] ?? '',
// //   );
// // }

// Plant copyWith({
//     String? id,
//     String? name,
//     String? scientificName,
//     double? price,
//     String? imageUrl,
//   }) {
//     return Plant(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       scientificName: scientificName ?? this.scientificName,
//       price: price ?? this.price,
//       imageUrl: imageUrl ?? this.imageUrl,
//       description: description??this.description,
//       category: category??this.category,
//     );
// }
// }
class Plant {
  final String id;
  final String name;
  final String scientificName;
  final String description;
  final double price;
  final String imageUrl;
  final String category;

  Plant({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
  
  // Factory method to create a Plant instance from Firestore document data
  factory Plant.fromDocument(Map<String, dynamic> docData, String docId) {
    return Plant(
      id: docId,
      name: docData['name'] ?? '',
      scientificName: docData['scientificName'] ?? '',
      description: docData['description'] ?? '',
      price: (docData['price'] is int ? (docData['price'] as int).toDouble() : (docData['price'] as double? ?? 0.0)),
      imageUrl: docData['imageUrl'] ?? '',
      category: docData['category'] ?? '',
    );
  }

  // Convert Plant instance to a map for Firestore
 Map<String, dynamic> toMap() {
  return {
    'id': id,
    'name': name,
    'scientificName': scientificName,
    'description': description,
    'price': price,
    'imageUrl': imageUrl,
    'category': category,
  };
}


  // Copy with method
  Plant copyWith({
    String? id,
    String? name,
    String? scientificName,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
    );
  }
}
