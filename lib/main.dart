import 'package:app02/Provider/item_provider.dart';
import 'package:flutter/material.dart';

import 'Widget/body_swiper.dart';
import 'model/Item_model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(ChangeNotifierProvider(
      create: (_) => itemProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      )));
}

// MaterialApp(
// debugShowCheckedModeBanner: false,
// home:  MyApp())
enum fillterOptions { all, favourite }

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFavourite = false;
  @override
  void initState() {
    super.initState();
    Provider.of<itemProvider>(context, listen: false).readJson();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Favorite images'),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(12),
            child: Consumer<itemProvider>(
              builder: (context, itemProvider, child) => badges.Badge(
                badgeContent: Text(
                  itemProvider.countItemFavourite
                      .toString(), // Use null-aware operator to handle null value
                  style: TextStyle(color: Colors.white),
                ),
                child: Icon(Icons.favorite),
              ),
            ),
          ),
          actions: [
            PopupMenuButton(
              onSelected: (value) {
                setState(() {
                  if (value == fillterOptions.all) {
                    isFavourite = false;
                  } else {
                    isFavourite = true;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: fillterOptions.all,
                  child: Text('Show all'),
                ),
                const PopupMenuItem(
                  value: fillterOptions.favourite,
                  child: Text('Favourite'),
                ),
              ],
            )
          ],
        ),
        body: SwipeBody(
          isFavourite: isFavourite,
        ));
  }
}
