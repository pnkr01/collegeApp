import 'dart:convert';
import 'package:http/http.dart' as https;

import '../model/article_model.dart';

//Now let's make the HTTP request services
// this class will alows us to make a simple get http request
// from the API and get the Articles and then return a list of Articles

class News {
  List<ArticalModel> news = [];
  Future<void> getNews() async {
    // ignore: unused_local_variable
    String url =
        "https://newsapi.org/v2/top-headlines?category=Science&country=in&apiKey=c02ff216548c439181e1871d08293edd";
    // ignore: unused_local_variable
    var response = await https.get(Uri.parse(url));
    // ignore: unused_local_variable
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          // ignore: unused_local_variable
          ArticalModel articalModel = ArticalModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(articalModel);
        }
      });
    }
  }
}

class CategoryNews {
  List<ArticalModel> news = [];
  Future<void> getNews(String category) async {
    // ignore: unused_local_variable
    String url =
        "https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=c02ff216548c439181e1871d08293edd";
    // ignore: unused_local_variable
    var response = await https.get(Uri.parse(url));

    // ignore: unused_local_variable
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          // ignore: unused_local_variable
          ArticalModel articalModel = ArticalModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(articalModel);
        }
      });
    }
  }
}
