

import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../models/API.dart';
import '../models/cryptocurrency.dart';

class MarketProvider with ChangeNotifier{
  bool isloading = true;
  List<Cryptocurrency> markets =[];
  MarketProvider(){
    fetchData();
  }
  void fetchData() async{
 List<dynamic> _markets  = await API.getMarkets();
 List<Cryptocurrency> temp =[];
 for(var market in _markets){
Cryptocurrency cryptocurrency = Cryptocurrency.fromJSON(market);
temp.add(cryptocurrency);
 }
markets=temp;
 log(isloading.toString());
 isloading=false;
 notifyListeners();
  }
}