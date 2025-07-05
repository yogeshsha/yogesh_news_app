import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/data/category_data/domain/category_model/category_model.dart';
import '../domain/usecases/infinite_usecase_interface.dart';
part 'infinite_event.dart';
part 'infinite_state.dart';

class InfiniteBloc extends Bloc<InfiniteEvent, InfiniteState> {
  final InfiniteUseCase infiniteUseCase;

  InfiniteBloc({required this.infiniteUseCase}) : super(InfiniteInitial()) {
    on<FetchInfinite>((event, emit) async {
      emit(InfiniteLoading());
      try {
        final infinite = await infiniteUseCase.getInfiniteApi(event.page,event.limit);
        emit(InfiniteLoaded(infinite: infinite));
      } catch (e) {
        emit(InfiniteError(message: e.toString()));
      }
    });
    on<FetchInitialInfinite>((event, emit) async {
      emit(InfiniteLoading());
    });
  }
}
