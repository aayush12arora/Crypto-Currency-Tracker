

import 'dart:async';
import 'dart:developer';

import 'package:cryptotrackerapi/models/Local_Storage.dart';
import 'package:flutter/cupertino.dart';

import '../models/API.dart';
import '../models/cryptocurrency.dart';

class MarketProvider with ChangeNotifier{
  bool isloading = true;
  List<Cryptocurrency> markets =[];
  MarketProvider(){
    fetchData();
  }
  Future<void >fetchData() async{
 List<dynamic> _markets  = await API.getMarkets();//  here it get the list of maps
 List<String>favorites = await LocalStorage.fetchfavourites();
 List<Cryptocurrency> temp =[];
 for(var market in _markets){
Cryptocurrency cryptocurrency = Cryptocurrency.fromJSON(market); // market is map and is coverted to cryptocurrency
if(favorites.contains(cryptocurrency.id!)){
  cryptocurrency.isfavourite= true;
}

temp.add(cryptocurrency);
 }
markets=temp;
 log(isloading.toString());
 isloading=false;
 notifyListeners();
 Timer(const Duration(seconds: 3), () {fetchData(); });
  }

  Cryptocurrency fetchCryptobyId(String id){
    Cryptocurrency crpto =  markets.where((element) => element.id==id).toList()[0];
    return crpto;
  }

  void addFavorites(Cryptocurrency cryptocurrency) async{
    int indexOfCrypto = markets.indexOf(cryptocurrency);
    markets[indexOfCrypto].isfavourite= true;
    await LocalStorage.addfavourites(cryptocurrency.id!);
    notifyListeners();

  }
  void removeFavorites(Cryptocurrency cryptocurrency) async{
    int indexOfCrypto = markets.indexOf(cryptocurrency);
    markets[indexOfCrypto].isfavourite= false;
    await LocalStorage.removefavourites(cryptocurrency.id!);
    notifyListeners();

  }


}