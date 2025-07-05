part of 'complain_bloc.dart';

abstract class ComplainState extends Equatable {
  const ComplainState();

  @override
  List<Object> get props => [];
}

class ComplainInitial extends ComplainState {}

class ComplainLoading extends ComplainState {}

class ComplainLoaded extends ComplainState {
  final ComplainModel complains;

  const ComplainLoaded({required this.complains});

  @override
  List<Object> get props => [complains];
}

class ComplainError extends ComplainState {
  final String message;

  const ComplainError({required this.message});

  @override
  List<Object> get props => [message];
}
