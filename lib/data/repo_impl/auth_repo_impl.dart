import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce_app/data/api_manger.dart';
import 'package:ecommerce_app/domain/repos/AuthRepo/auth_repo.dart';

import '../../core/errors/failuer.dart';
import '../model/auth_model/AuthResponse.dart';
import '../model/auth_model/login_request/LoginRequest.dart';

class AuthRepoImpl implements AuthRepo{

  final ApiManger apiManger;

  AuthRepoImpl(this.apiManger);
  @override
  Future<Either<Failure, AuthResponse>> login(LoginRequest loginRequest)async {
   try {
     var response=await apiManger.post(endPoint:"api/v1/auth/signin",loginRequest: loginRequest);
     var authResponse=AuthResponse.fromJson(response);
     return right(authResponse);
   }  catch (e) {
     if(e is DioException){
       return left(ServerFailure.fromDioError(e));
     }else{
       return left(ServerFailure(e.toString()));
     }

   }
  }
}