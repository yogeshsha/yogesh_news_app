import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/constants/common_model/api_model.dart';
import 'package:newsapp/data/login_data/domain/login_model/login_model.dart';
import '../domain/usecases/splash_usecase_interface.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashUseCase splashUseCase;
  SplashBloc({required this.splashUseCase}) : super(SplashInitial()) {
    on<GetUserDetails>((event, emit) async {
      emit(SplashLoading());
      try {
        Either<LoginModel,ApiModel> details = await splashUseCase.getBasicInfoUser();
        if(details.isLeft){
          emit(SplashMainLoaded(user: details.left));
        }else{
          emit(OtherStatusCodeSplash(details: details.right));
        }
      } catch (e) {
        emit(SplashError(message: e.toString()));
      }
    });
    on<FetchInitialSplash>((event, emit) async {
      emit(SplashInitial());
    });
  }
}
