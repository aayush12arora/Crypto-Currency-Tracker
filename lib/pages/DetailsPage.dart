import 'package:cryptotrackerapi/providers/MarketProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cryptocurrency.dart';
class DetailsPage extends StatefulWidget {
  final String id ;
  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {


var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child:  Container(
          child: Consumer<MarketProvider>(
            builder: (context,marketprovider,child){
              Cryptocurrency cryptocurrency = marketprovider.fetchCryptobyId(widget.id);
              return RefreshIndicator(
                onRefresh: () async{
                  marketprovider.fetchData();
                },
                child: ListView(
                  children: [
                    ListTile(
                      leading:CircleAvatar(
                        backgroundImage: NetworkImage(cryptocurrency.image!),
                        backgroundColor: Colors.white,
                      ) ,
                      title: Text(cryptocurrency.name!,style: TextStyle(fontSize: 20),) ,

                        subtitle: Text("₹ "+cryptocurrency.currentPrice.toString(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.blue.shade400),),
                    ),
SizedBox(height: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text("Price Change 24h",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
                        ),
                        Builder(builder:(context){
                          double priceChange = cryptocurrency.priceChange24!;
                          double priceChangePercentage = cryptocurrency.priceChangePercentage24!;
                          if(priceChange<0){
                            return Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text("-${priceChangePercentage.toStringAsFixed(2)}%(-${priceChange.toStringAsFixed(3)})",style: TextStyle(color: Colors.red),),
                            );
                          }
                          else{
                            return Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text("+${priceChangePercentage.toStringAsFixed(2)}%(+${priceChange.toStringAsFixed(3)})",style: TextStyle(color: Colors.green),),
                            );
                          }
                        })
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        details("Market Cap", "₹ "+cryptocurrency.marketCap!.toStringAsFixed(4), CrossAxisAlignment.start,context,width),
                        details("Market Cap Rank", "#"+cryptocurrency.marketCapRank!.toString(), CrossAxisAlignment.end,context,width),
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        details("Low 24h", "₹ "+cryptocurrency.low24!.toStringAsFixed(4), CrossAxisAlignment.start,context,width),
                        details("High 24h","₹ " +cryptocurrency.high24!.toString(), CrossAxisAlignment.end,context,width),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        details("Circulataing Suply", cryptocurrency.circulatingSupply!.toString(), CrossAxisAlignment.start,context,width),

                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Expanded(
                      flex:1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          details("All time low", "₹ "+cryptocurrency.atl!.toStringAsFixed(4), CrossAxisAlignment.start,context,width),
                          details("All time High","₹ " +cryptocurrency.ath!.toString(), CrossAxisAlignment.end,context,width),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

        ),

      ),
    );
  }

  Widget details(String title,String subtitle,CrossAxisAlignment alignment,BuildContext context , var width) {
    Widget child;
    if (width < 522 && width > 380) {
      return Padding(

          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(

            crossAxisAlignment: alignment,
            children: [

              Text(title, style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20,
                  overflow: TextOverflow.ellipsis),),
              Text(subtitle, style: TextStyle(fontSize: 15),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 3,)

            ],
          )
      );
    }
    else if(width<=379){
      return
        Padding(

          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(

            crossAxisAlignment: alignment,
            children: [

              Text(title, style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 15,
                  overflow: TextOverflow.ellipsis),),
              Text(subtitle, style: TextStyle(fontSize: 11),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 3,)

            ],
          )
      );
    }
    return
      Padding(

          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(

            crossAxisAlignment: alignment,
            children: [

              Text(title, style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 25,
                  overflow: TextOverflow.ellipsis),),
              Text(subtitle, style: TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                maxLines: 3,)

            ],
          )
      );
  }
}
