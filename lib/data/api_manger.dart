import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiManger {
  final Dio dio;

  ApiManger(this.dio){
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object){
        debugPrint(object.toString());
      }
    ));
  }
  final _baseUrl = 'https://ecommerce.routemisr.com/';

  Future<Map<String, dynamic>> get({required String endPoint}) async {
    var response = await dio.get("$_baseUrl$endPoint");
    return response.data;
  }
}
