import 'package:http/http.dart' as http;
import 'package:http/http.dart';

abstract class HttpInterface {
  void initClient();
  Future<http.Response> getData(String link);
}

class HttpService implements HttpInterface {
  Client httpClient;

  @override
  void initClient() {
    httpClient = http.Client();
  }

  @override
  Future<http.Response> getData(String link) async {
    return httpClient.get(link);
  }
}
