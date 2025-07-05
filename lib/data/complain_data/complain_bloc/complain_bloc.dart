import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/complain_model/complain_model.dart';
import '../domain/usecases/complain_usecase_interface.dart';



part 'complain_event.dart';
part 'complain_state.dart';

class ComplainBloc extends Bloc<ComplainEvent, ComplainState> {
  final ComplainUseCase complainUseCase;

  ComplainBloc({required this.complainUseCase}) : super(ComplainInitial()) {
    on<FetchComplain>((event, emit) async {
      emit(ComplainLoading());
      try {
        final complains = await complainUseCase.getComplainApi(event.id);
        emit(ComplainLoaded(complains: complains));
      } catch (e) {
        emit(ComplainError(message: e.toString()));
      }
    });
  }
}
