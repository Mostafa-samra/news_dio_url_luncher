import 'package:dio/dio.dart';
import 'package:news_dio_url_luncher/models/newsresponse.dart';


class NewsApiService {
  static String apiKey = '220df185e3c34419bcce6fb2f20086ac';
  String url =
      'https://newsapi.org/v2/everything?q=tesla&sortBy=publishedAt&apiKey=$apiKey';

  late Dio dio;
  NewsApiService() {
    dio = Dio();
  }
  Future<List<Article>?> getNewsArticales() async {
    try {
      Response response = await dio.get(url);
      NewsResponse newsResponse = NewsResponse.fromJson(response.data);
      return newsResponse.articles;
    } on DioError catch (e) {
      print(e);
    }
    return null;
  }
}
