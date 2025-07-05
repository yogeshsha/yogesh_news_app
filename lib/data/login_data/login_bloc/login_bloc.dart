import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/common_model/api_model.dart';
import '../domain/login_model/login_model.dart';
import '../domain/usecases/login_usecase_interface.dart';





part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;
  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<FetchLogin>((event, emit) async {
      emit(LoginLoading());
      try {
        Either<LoginModel, ApiModel> details = await loginUseCase.getLoginApi(event.body ?? {});

        if(details.isLeft){
          emit(LoginLoaded(details: details.left));
        }else{
          emit(OtherStatusCodeLoginLoaded(details: details.right));
        }
      } catch (e) {
        emit(LoginError(message: e.toString()));
      }
    });
    on<FetchInitialLogin>((event, emit) async {
      emit(LoginInitial());
    });
  }
}
