import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/constants/common_model/api_model.dart';
import 'package:newsapp/data/login_data/domain/login_model/login_model.dart';
import '../domain/usecases/session_usecase_interface.dart';

part 'session_event.dart';

part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final SessionUseCase sessionUseCase;

  SessionBloc({required this.sessionUseCase}) : super(SessionInitial()) {
    on<FetchInitialSession>((event, emit) async {
      emit(SessionInitial());
    });
    on<GetSessionEvent>((event, emit) async {
      if (event.isLoading ?? true) {
        emit(SessionLoading());
      }
      try {
        Either<LoginModel,ApiModel> details =
            await sessionUseCase.getSessionApi();
        if (details.isLeft) {
          emit(SessionLoaded(model: details.left));
        } else {
          emit(OtherStatusCodeSession(details: details.right));
        }
      } catch (e) {
        emit(SessionError(message: e.toString()));
      }
    });
  }
}
