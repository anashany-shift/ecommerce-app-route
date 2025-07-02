import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/data/model/auth_model/AuthResponse.dart';
import 'package:ecommerce_app/data/model/auth_model/login_request/LoginRequest.dart';
import 'package:ecommerce_app/domain/repos/AuthRepo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;
  LoginCubit(this.authRepo) : super(LoginInitial());

  Future<void>login(LoginRequest loginRequest)async {
    emit(LoginLoading());

    var result=await authRepo.login(loginRequest);
    result.fold((failure) {
      print("❌ Failed to get Subcategories: ${failure.errorMassage}");
      emit(LoginError(failure.errorMassage));
    }, (authResponse) {

      emit(LoginSuccess(authResponse));
    });
  }
}
