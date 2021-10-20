import 'dart:convert';
import 'package:dio/dio.dart';
import 'custom_exception.dart';

dynamic handleDioResponse(Response<dynamic> response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(json.encode(response.data));
      return {'status': 200, 'response': responseJson};
    case 201:
      var responseJson = jsonDecode(response.data.toString());

      return {'status': 201, 'response': responseJson};
    case 400:
      throw BadRequestException(response.data.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.data);
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}