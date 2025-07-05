part of 'like_bloc.dart';

abstract class LikeState extends Equatable {
  const LikeState();

  @override
  List<Object> get props => [];
}

class LikeInitial extends LikeState {}

class LikeLoading extends LikeState {}

class LikeLoaded extends LikeState {
  final LikeModel details;

  const LikeLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class LikeError extends LikeState {
  final String message;

  const LikeError({required this.message});

  @override
  List<Object> get props => [message];
}

class UnLikeInitial extends LikeState {}

class UnLikeLoading extends LikeState {}

class UnLikeLoaded extends LikeState {
  final UnLikeModel details;

  const UnLikeLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class UnLikeError extends LikeState {
  final String message;

  const UnLikeError({required this.message});

  @override
  List<Object> get props => [message];
}
