import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/constants/common_model/api_model.dart';

import '../../login_data/domain/login_model/login_model.dart';
import '../domain/usecases/sign_up_usecase_interface.dart';



part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpBloc({required this.signUpUseCase}) : super(SignUpInitial()) {
    on<FetchSignUp>((event, emit) async {
      emit(SignUpLoading());
      try {
        Either<LoginModel, ApiModel> details = await signUpUseCase.getSignUpApi(event.body);

        if(details.isLeft){
          emit(SignUpLoaded(details: details.left));
        }else{
          emit(OtherStatusCodeSignUpLoaded(details: details.right));
        }
      } catch (e) {
        emit(SignUpError(message: e.toString()));
      }
    });
    on<FetchInitialSignUp>((event, emit) async {

    });
  }
}
