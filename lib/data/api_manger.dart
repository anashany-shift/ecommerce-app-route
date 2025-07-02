import 'package:dio/dio.dart';
import 'package:ecommerce_app/data/model/auth_model/login_request/LoginRequest.dart';
import 'package:flutter/cupertino.dart';

class ApiManger {
  final Dio dio;

  ApiManger(this.dio) {
    dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          debugPrint(object.toString());
        }));
  }
  final _baseUrl = 'https://ecommerce.routemisr.com/';

  //get request

  Future<Map<String, dynamic>> get(
      {required String endPoint, Map<String, dynamic>? queryParam}) async {
    var response =
        await dio.get("$_baseUrl$endPoint", queryParameters: queryParam);
    return response.data;
  }

  //post request

  Future<Map<String, dynamic>> post(
      {required String endPoint, LoginRequest? loginRequest}) async {
    var response =
        await dio.post("$_baseUrl$endPoint", data: loginRequest?.toJson());
    return response.data;
  }
}
