import 'package:http/http.dart' as http;
import 'package:http/http.dart';

/// Http service interface
abstract class HttpInterface {
  /// Init services and others things to http service works
  void initClient();

  /// Get data from [link] using http client
  Future<http.Response> getData(String link);
}

/// Http service to manage http client
class HttpService implements HttpInterface {
  Client _httpClient;

  @override
  void initClient() {
    _httpClient = http.Client();
  }

  @override
  Future<http.Response> getData(String link) async {
    return _httpClient.get(Uri.parse(link));
  }
}
