import 'package:app02/model/Item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class itemProvider extends ChangeNotifier {
  // int _favourite = 1;
  // int get favourite => _favourite;
  // void updateFavourite() {
  //   _favourite++;
  //   notifyListeners();
  // }
  List<Item> _items = [];

  int _countItemFavourite = 0;

  List<Item> get items {
    return [..._items];
  }

  int get countItemFavourite {
    return _countItemFavourite;
  }

  List<Item> showFavourite() {
    List<Item> data = _items.where((element) => element.isFavourite).toList();
    return data.isEmpty ? [] : data;
  }

  void handleCountItemFav() {
    _countItemFavourite = _items.where((element) => element.isFavourite).length;
    notifyListeners();
  }

  void readJson() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/items.json');
      print('Loaded JSON: $response'); // Add this line to print the loaded JSON
      final List<dynamic> parsedList = json.decode(response);
      List<Item> listData =
          parsedList.map((data) => Item.fromMap(data)).toList();
      _items = listData;
      notifyListeners();
    } catch (e) {
      print('Error reading JSON: $e');
      // Handle the error appropriately, e.g., show an error message
    }
  }
}
