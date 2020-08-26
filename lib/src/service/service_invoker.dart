import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter_template_project/src/common/app_config.dart';
import 'package:flutter_template_project/src/models/error_handler.dart';
import 'package:flutter_template_project/src/service/service_constants.dart';
import 'package:flutter_template_project/src/service/service_provider.dart';
import 'package:flutter_template_project/src/service/stores/APIStore.dart';

class ServiceInvoker {
  final JsonDecoder _decoder = new JsonDecoder();
  final ServiceProvider _provider = new ServiceProvider();

//GET HTTP CLIENT REQUEST
  Future<HttpClient> _getHttpClientRequest() async {
    var httpClientContext = SecurityContext.defaultContext;

    HttpClient client = HttpClient(context: httpClientContext);
    client.connectionTimeout =
        Duration(seconds: TIMEOUT); //HTTP Request Timeout
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;

    return client;
  }

  //INVOKE SERVICE CALL
  Future<dynamic> makeRequest(String url, REQUESTTYPE requestType,
      {body, encoding}) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.none) {
      // Connected to a mobile network.
      HttpClient client = await _getHttpClientRequest();
      String urlToHit = (AppConfig.BASE_URL as String) +
          _provider
              .resources[url]; //Form the url based on the build configuration

      HttpClientRequest httpClientRequest;
      print(urlToHit);
      switch (requestType) {
        case REQUESTTYPE.GET:
          httpClientRequest = await client.getUrl(Uri.parse(urlToHit));
          break;

        case REQUESTTYPE.POST:
          httpClientRequest = await client.getUrl(Uri.parse(urlToHit));
          httpClientRequest.write(jsonEncode(body));
          break;
      }
      _getHeaders(httpClientRequest);
      return await _invokeService(httpClientRequest);
    } else {
       return ErrorHandler(code: NETWORK_ERROR, message: connectivityResult.toString());
      //Handle Network Error
    }
  }

  //Invoke a service request
  Future<dynamic> _invokeService(HttpClientRequest httpClientRequest) async {
    try {
      HttpClientResponse httpClientResponse = await httpClientRequest.close();
      String res = await httpClientResponse.transform(utf8.decoder).join();

      final int statusCode = httpClientResponse.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        return ErrorHandler(code: statusCode, message: "HTTP Error");
        //Handle this as per your requirement as Generic HTTP exceptions
      }
      return _decoder.convert(res); 
      //Success Response
    } on SocketException {
      return ErrorHandler(code: CONNECTION_TIMEOUT, message: "Connection Timeout");
      //Handle this for API timeout or Socket timeout exceptions
    } on FormatException {
      return ErrorHandler(code: FORMAT_EXCEPTION, message: "Format Exception");
      //Handle this for response format exceptions
    }
  }

//Make HTTP Request Headers
  void _getHeaders(HttpClientRequest request) {
    request.headers.set(ACCEPT, 'application/json');
    // request.headers.set(CONTENT_TYPE, 'application/json');
  }
}
