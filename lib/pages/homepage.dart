import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cryptotrackerapi/models/cryptocurrency.dart';
import 'package:cryptotrackerapi/providers/MarketProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 400,
          padding: EdgeInsets.only(left: 20,top: 20),
          child: Column(children: [
            SizedBox(
              height: 33,
            ),
            buildAnimatedText(),

            Expanded(child: Consumer<MarketProvider>(
              builder: (context,marketProvider,child){
                if(marketProvider.isloading==true){
                  return Center(child: CircularProgressIndicator());
                }
                else {
                  if (marketProvider.markets.length > 0) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: marketProvider.markets.length,
                        itemBuilder: (context,index){
                        Cryptocurrency currentcryp = marketProvider.markets[index];
                        return ListTile(
subtitle:  Text(currentcryp.symbol!.toUpperCase()),
                          trailing: Text(currentcryp.currentPrice.toString()),
                          title: Text(currentcryp.name!),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(currentcryp.image!),
                          ),
                        );
                        });
                  }
                  else{
                    return Text('data not found');
                  }
                }
              },


            ))

          ],
          ),

        ),
      ),
    );
  }


  Widget buildAnimatedText() => AnimatedTextKit(
    animatedTexts: [
      buildText("Welcome Back"),
    ],
    repeatForever: true,
    pause: const Duration(milliseconds: 50),
    displayFullTextOnTap: true,
    stopPauseOnTap: true,
  );

  buildText(String text) {
    return TypewriterAnimatedText(
      text,
      textStyle: const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.pink,
      ),
      speed: const Duration(milliseconds: 100),
    );
  }
}
