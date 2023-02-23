import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
 static Future<bool>saveTheme (String theme) async {
SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
bool result = await sharedPreferences.setString("theme", theme);
return result;
  }

 static Future<String?>getTheme () async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? result = await sharedPreferences.getString("theme");
    return result;
  }

  static Future<bool> addfavourites(String id )async{
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   List<String> favorites = await sharedPreferences.getStringList("favorites")?? [];
   favorites.add(id);
   return await sharedPreferences.setStringList("favorites", favorites);

  }

 static Future<bool> removefavourites(String id )async{
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   List<String> favorites = await sharedPreferences.getStringList("favorites")?? [];
   favorites.remove(id);
   return await sharedPreferences.setStringList("favorites", favorites);

 }


 static Future<List<String>> fetchfavourites( )async{
   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   List<String> favorites = await sharedPreferences.getStringList("favorites")?? [];
  // favorites.remove(id);
   return await favorites;

 }
}