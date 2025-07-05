part of 'infinite_bloc.dart';

abstract class InfiniteState extends Equatable {
  const InfiniteState();

  @override
  List<Object> get props => [];
}

class InfiniteInitial extends InfiniteState {}

class InfiniteLoading extends InfiniteState {}

class InfiniteLoaded extends InfiniteState {
  final List<LatestNews> infinite;

  const InfiniteLoaded({required this.infinite});

  @override
  List<Object> get props => [infinite];
}

class InfiniteError extends InfiniteState {
  final String message;

  const InfiniteError({required this.message});

  @override
  List<Object> get props => [message];
}
