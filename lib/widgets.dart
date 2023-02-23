import 'package:cryptotrackerapi/models/cryptocurrency.dart';
import 'package:cryptotrackerapi/pages/DetailsPage.dart';
import 'package:cryptotrackerapi/providers/MarketProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tile extends StatelessWidget {

final Cryptocurrency currentcryp ;

  Tile(@required this.currentcryp);

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider = Provider.of<MarketProvider>(context,listen: false);

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
          SizedBox(width: 15,),
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
  }
}
