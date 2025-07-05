import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/breaking_model/breaking_model.dart';
import '../domain/usecases/breaking_usecase_interface.dart';
part 'breaking_event.dart';
part 'breaking_state.dart';

class BreakingBloc extends Bloc<BreakingEvent, BreakingState> {
  final BreakingUseCase breakingUseCase;

  BreakingBloc({required this.breakingUseCase}) : super(BreakingInitial()) {
    on<FetchBreaking>((event, emit) async {
      emit(BreakingLoading());
      try {
        final details = await breakingUseCase.getBreakingApi();
        emit(BreakingLoaded(details: details));
      } catch (e) {
        emit(BreakingError(message: e.toString()));
      }
    });
  }
}
