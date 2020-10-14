import 'dart:convert';
import 'package:http/http.dart' as http;
import 'unsplash_pictures_inf.dart';

// ignore: camel_case_types
class API_Manager {

  Future<List<UnsplashData>> getPictures() async {
    var data = await http.get("https://api.unsplash.com/photos/?client_id=896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043");
    var jsonData = json.decode(data.body);
    List<UnsplashData> pictures = [];

    for (var u in jsonData) {
      UnsplashData unsplashData = UnsplashData.fromJson(u);
        pictures.add(unsplashData);
    }
    //print(pictures.length);
    return pictures;
  }
}