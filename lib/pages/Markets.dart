import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cryptocurrency.dart';
import '../providers/MarketProvider.dart';
import 'DetailsPage.dart';
class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return
      Consumer<MarketProvider>(
        builder: (context,marketProvider,child){
          if(marketProvider.isloading==true){
            return Center(child: CircularProgressIndicator());
          }
          else {
            if (marketProvider.markets.length > 0) {
              return RefreshIndicator(
                onRefresh: () async{
                  marketProvider.fetchData();

                },
                child: ListView.builder(
                    physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: marketProvider.markets.length,
                    itemBuilder: (context,index){
                      Cryptocurrency currentcryp = marketProvider.markets[index];
                      return ListTile(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(id: currentcryp.id!,)));
                        },
                        subtitle:  Text(currentcryp.symbol!.toUpperCase()),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("₹ "+currentcryp.currentPrice!.toStringAsFixed(4),style: TextStyle(color: Colors.black87,fontSize: 18,fontWeight: FontWeight.bold),),
                            Builder(builder:(context){
                              double priceChange = currentcryp.priceChange24!;
                              double priceChangePercentage = currentcryp.priceChangePercentage24!;
                              if(priceChange<0){
                                return Text("-${priceChangePercentage.toStringAsFixed(2)}%(-${priceChange.toStringAsFixed(3)})",style: TextStyle(color: Colors.red),);
                              }
                              else{
                                return Text("+${priceChangePercentage.toStringAsFixed(2)}%(+${priceChange.toStringAsFixed(3)})",style: TextStyle(color: Colors.green),);
                              }
                            })
                          ],
                        ),
                        title: Row(
                          children: [
                            Flexible(child: Text(currentcryp.name!,overflow: TextOverflow.ellipsis,),),
                            SizedBox(width: 10,),
                            (currentcryp.isfavourite==true)? GestureDetector(
                              onTap: (){
                                 marketProvider.removeFavorites(currentcryp);
                              },
                              child: Icon(CupertinoIcons.heart_fill,size: 20,color: Colors.red,),
                            ):GestureDetector(
                              onTap: (){
                                marketProvider.addFavorites(currentcryp);
                              },
                              child: Icon(CupertinoIcons.heart,size: 20,),
                            )
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(currentcryp.image!),
                        ),
                      );
                    }),
              );
            }
            else{
              return Text('data not found');
            }
          }
        },


      );
  }
}
