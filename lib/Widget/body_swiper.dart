import 'package:app02/Provider/item_provider.dart';
import 'package:app02/model/Item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe/flutter_swipe.dart';
import 'package:provider/provider.dart';

class SwipeBody extends StatelessWidget {
  const SwipeBody({Key? key, required this.isFavourite}) : super(key: key);

  final isFavourite;

  @override
  Widget build(BuildContext context) {
    final dataItem = Provider.of<itemProvider>(context);
    final items = isFavourite ? dataItem.showFavourite() : dataItem.items;
    return items.isNotEmpty
        ? Swiper(
            layout: SwiperLayout.STACK,
            itemWidth: 350,
            itemHeight: 650,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ChangeNotifierProvider.value(
                value: items[index],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GridTile(
                    footer: GridTileBar(
                      backgroundColor: Colors.white12,
                      title: Consumer<Item>(
                        builder: (context, item, child) {
                          return InkWell(
                            onTap: () {
                              item.toggleIsFavourite();
                              Provider.of<itemProvider>(context, listen: false)
                                  .handleCountItemFav();
                            },
                            child: Icon(
                              Icons.favorite,
                              size: 30,
                              color:
                                  item.isFavourite ? Colors.red : Colors.white,
                            ),
                          );
                        },
                      ),
                      subtitle: Text(items[index].name),
                      trailing: Text(
                        items[index].name,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    child: Image.asset(
                      items[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            })
        : Container(
            child: Center(child: Text('no image found')),
          );
  }
}
