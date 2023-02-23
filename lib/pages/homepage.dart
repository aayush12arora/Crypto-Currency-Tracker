import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cryptotrackerapi/models/cryptocurrency.dart';
import 'package:cryptotrackerapi/pages/DetailsPage.dart';
import 'package:cryptotrackerapi/pages/Favorites.dart';
import 'package:cryptotrackerapi/pages/Markets.dart';
import 'package:cryptotrackerapi/providers/MarketProvider.dart';
import 'package:cryptotrackerapi/providers/theme_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> with TickerProviderStateMixin{
   late TabController viewcontroller ;

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewcontroller = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
ThemeProvider themeProvider =Provider.of<ThemeProvider>(context,listen: false);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
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
TabBar(
    controller: viewcontroller,
    tabs: [
  Tab(
    child: Text("Markets",style: Theme.of(context).textTheme.bodyMedium,),
  ),

  Tab(
    child: Text("Favourites",style: Theme.of(context).textTheme.bodyMedium,),
  ),
]),
            Expanded(
              flex: 1,
              child: TabBarView(
                  controller: viewcontroller,
                  children: [
                Markets(),
                Favorites()

              ]),
            )

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
