import 'package:http/http.dart' as http;

class RepositoryProducts {
  static Future<dynamic> getProductList() async {
    return await http.get(Uri.parse("https://dummyjson.com/products"));
  }
}
