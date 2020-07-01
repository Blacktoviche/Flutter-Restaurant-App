import 'dart:io';
import 'package:ecommerce/backend/PostResponse.dart';
import 'package:ecommerce/util/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'Exceptions.dart';

Future<dynamic> find(String endPoint) async {
  print('Api Get, url $endPoint');
  try {
    final response = await http.get(Constants.API_CLIENT_DOMAIN(endPoint));
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(utf8.decode(response.bodyBytes));
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        print("error code: ${response.statusCode} : ${response.toString()}");
    //throw FetchDataException(
    //  'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  } on SocketException {
    throw FetchDataException('Error occured while Communication with Server');
  }
}
  Future<dynamic> send(String endPoint, dynamic body) async {
    print('Api Post, url $endPoint');
    String message;
    try {
      final response = await http.post(Constants.API_CLIENT_DOMAIN(endPoint),
          headers: {
            "Content-Type": "application/json"
          }
          ,body: body);
      switch (response.statusCode) {
        case 200:
          var responseJson = json.decode(utf8.decode(response.bodyBytes));
          return responseJson;
        case 400:
        case 401:
        case 404:
          var responseJson = json.decode(utf8.decode(response.bodyBytes));
          message = PostResponse.fromJson(responseJson).message;
          throw FetchDataException(message);
        default: throw FetchDataException("لا يوجد اتصال!");
      }
    } on SocketException {
      if(message == null){
        throw FetchDataException("لا يوجد اتصال!");
      }else{
        throw FetchDataException(message);
      }
    }
  }
