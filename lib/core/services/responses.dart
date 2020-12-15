import 'dart:convert';
import 'package:http/http.dart' as http;

import 'custom_exceptions.dart';

class ApiResponses {
  static dynamic apiResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        if (response.body.isNotEmpty) {
          return json.decode(response.body);
        }
        break;
      case 400:
        throw BadRequestException(response.body.toString());
        break;
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
        break;
      case 404:
        throw NotFoundException(response.body.toString());
        break;
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
