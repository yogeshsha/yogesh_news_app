part of 'breaking_bloc.dart';

abstract class BreakingEvent extends Equatable {
  const BreakingEvent();

  @override
  List<Object> get props => [];
}

class FetchBreaking extends BreakingEvent {}
