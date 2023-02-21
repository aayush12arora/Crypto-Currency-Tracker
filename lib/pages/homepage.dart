import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cryptotrackerapi/models/cryptocurrency.dart';
import 'package:cryptotrackerapi/providers/MarketProvider.dart';
import 'package:cryptotrackerapi/providers/theme_Provider.dart';
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
ThemeProvider themeProvider =Provider.of<ThemeProvider>(context,listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 400,
          padding: EdgeInsets.only(left: 20,top: 20),
          child: Column(children: [
            SizedBox(
              height: 33,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildAnimatedText(),
                IconButton(onPressed: (){
themeProvider.toggleTheme();
                }, icon: (themeProvider.themeMode==ThemeMode.dark)?Icon(Icons.dark_mode):Icon(Icons.light_mode))
              ],
            ),

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
