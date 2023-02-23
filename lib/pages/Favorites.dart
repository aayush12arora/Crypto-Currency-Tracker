import 'package:cryptotrackerapi/models/cryptocurrency.dart';
import 'package:cryptotrackerapi/providers/MarketProvider.dart';
import 'package:cryptotrackerapi/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
   return Consumer<MarketProvider>(builder: (context,marketprovider,child){
     List<Cryptocurrency> favorites = marketprovider.markets.where((element) => element.isfavourite==true).toList();
      return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context,index){
            Cryptocurrency currentcryp = favorites[index];
return  Tile(currentcryp);
          });
   });

  }
}
