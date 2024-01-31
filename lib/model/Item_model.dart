import 'dart:convert';
import 'package:flutter/material.dart';

class Item extends ChangeNotifier {
  String id;
  String name;
  String image;
  bool isFavourite = false;

  Item({
    required this.id,
    required this.name,
    required this.image,
  });

  void toggleIsFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'image': image};
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    print('Creating Item: $map');
    return Item(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());
  factory Item.fromJson(String source) =>
      Item.fromMap(json.decode(source) as Map<String, dynamic>);
}
