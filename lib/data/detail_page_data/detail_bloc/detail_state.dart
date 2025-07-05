part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final DetailModel details;

  const DetailLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class DetailError extends DetailState {
  final String message;

  const DetailError({required this.message});

  @override
  List<Object> get props => [message];
}
