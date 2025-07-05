import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/like_model/like_model.dart';
import '../domain/like_model/unlike_model.dart';
import '../domain/usecases/like_usecase_interface.dart';
part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  final LikeUseCase likeUseCase;
  LikeBloc({required this.likeUseCase}) : super(LikeInitial()) {
    on<FetchLike>((event, emit) async {
      emit(LikeLoading());
      try {
        final details = await likeUseCase.getLikeApi(event.body);
        emit(LikeLoaded(details: details));
      } catch (e) {
        emit(LikeError(message: e.toString()));
      }
    });
    on<FetchUnLike>((event, emit) async {
      emit(UnLikeLoading());
      try {
        final details = await likeUseCase.getUnLikeApi(event.body);
        emit(UnLikeLoaded(details: details));
      } catch (e) {
        emit(UnLikeError(message: e.toString()));
      }
    });
    on<FetchInitialLike>((event, emit) async {
      emit(LikeInitial());
    });
    on<FetchInitialUnLike>((event, emit) async {

      emit(UnLikeInitial());
    });
  }
}
