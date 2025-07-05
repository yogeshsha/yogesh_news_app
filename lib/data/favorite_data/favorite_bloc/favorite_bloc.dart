import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/favorite_model/favorite_model.dart';
import '../domain/usecases/favorite_usecase_interface.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteUseCase favoriteUseCase;

  FavoriteBloc({required this.favoriteUseCase}) : super(FavoriteInitial()) {
    on<FetchFavorite>((event, emit) async {
      emit(FavoriteLoading());
      try {
        final details = await favoriteUseCase.getFavoriteApi();
        emit(FavoriteLoaded(details: details));
      } catch (e) {
        emit(FavoriteError(message: e.toString()));
      }
    });
    on<FetchInitialFavorite>((event, emit) async {
      emit(FavoriteInitial());
    });
  }
}
