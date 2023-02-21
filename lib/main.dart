import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cryptotrackerapi/constants/Theme.dart';
import 'package:cryptotrackerapi/pages/homepage.dart';
import 'package:cryptotrackerapi/providers/MarketProvider.dart';
import 'package:cryptotrackerapi/providers/theme_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<MarketProvider>(create: (context)=> MarketProvider(),),
      ChangeNotifierProvider<ThemeProvider>(create: (context)=>ThemeProvider())
    ],
    child: Consumer<ThemeProvider>(
      builder: (context,provider,child){
        return MaterialApp(
          theme:lighttheme,
          darkTheme: darktheme,
themeMode: provider.themeMode,
          title: 'Flutter Demo',

          debugShowCheckedModeBanner: false,

          home: Homepage(),
        );
      },
    ),

    );
  }



}



