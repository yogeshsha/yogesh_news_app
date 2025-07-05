import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/common_model/api_model.dart';
import '../domain/usecases/settings_usecase_interface.dart';





part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsUseCase settingsUseCase;
  SettingsBloc({required this.settingsUseCase}) : super(SettingsInitial()) {
    on<LogoutEvent>((event, emit) async {
      emit(SettingsLoading());
      try {
        Either<String, ApiModel> details = await settingsUseCase.logOutApi(event.body);
        if(details.isLeft){
          emit(LogOutLoaded(details: details.left));
        }else{
          emit(OtherStatusCodeSettingsLoaded(details: details.right));
        }
      } catch (e) {
        emit(SettingsError(message: e.toString()));
      }
    });
    on<FetchInitialSettings>((event, emit) async {
      emit(SettingsInitial());
    });
  }
}
