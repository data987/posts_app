import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';

import 'custom_exceptions.dart';
import 'responses.dart';

class HttpRequests {
  Future<dynamic> get(
      {@required http.Client httpClient,
      @required String url,
      String token,
      String param}) async {
    var response;
    try {
      final request =
          await httpClient.get(param != null ? '$url/$param' : url, headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "Authorization": 'Bearer $token',
      });
      response = ApiResponses.apiResponse(request);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on NotFoundException {
      throw FetchDataException('Endpoint not exists');
    }
    return response;
  }
}
