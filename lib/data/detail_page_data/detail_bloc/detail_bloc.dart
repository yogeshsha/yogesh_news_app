import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/detail_model/detail_model.dart';
import '../domain/usecases/detail_usecase_interface.dart';


part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final DetailUseCase detailUseCase;

  DetailBloc({required this.detailUseCase}) : super(DetailInitial()) {
    on<FetchDetail>((event, emit) async {
      emit(DetailLoading());
      try {
        final details = await detailUseCase.getDetailApi(event.id);
        emit(DetailLoaded(details: details));
      } catch (e) {
        emit(DetailError(message: e.toString()));
      }
    });
  }
}
