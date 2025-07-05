part of 'breaking_bloc.dart';

abstract class BreakingState extends Equatable {
  const BreakingState();

  @override
  List<Object> get props => [];
}

class BreakingInitial extends BreakingState {}

class BreakingLoading extends BreakingState {}

class BreakingLoaded extends BreakingState {
  final List<BreakingNewsModel> details;

  const BreakingLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class BreakingError extends BreakingState {
  final String message;

  const BreakingError({required this.message});

  @override
  List<Object> get props => [message];
}
