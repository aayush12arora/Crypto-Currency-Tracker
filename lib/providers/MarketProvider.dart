

import 'dart:async';
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
 List<dynamic> _markets  = await API.getMarkets();//  here it get the list of maps
 List<Cryptocurrency> temp =[];
 for(var market in _markets){
Cryptocurrency cryptocurrency = Cryptocurrency.fromJSON(market); // market is map and is coverted to cryptocurrency
temp.add(cryptocurrency);
 }
markets=temp;
 log(isloading.toString());
 isloading=false;
 notifyListeners();
 Timer(const Duration(seconds: 3), () {fetchData(); });
  }
}