part of 'session_bloc.dart';

abstract class SessionState extends Equatable {
  const SessionState();

  @override
  List<Object> get props => [];
}

class SessionInitial extends SessionState {}

class SessionLoading extends SessionState {}

class SessionLoaded extends SessionState {

  final LoginModel model;
   const SessionLoaded({required this.model});
}
class SessionError extends SessionState {
  final String message;

  const SessionError({required this.message});

  @override
  List<Object> get props => [message];
}

class OtherStatusCodeSession extends SessionState {
  final ApiModel details;

  const OtherStatusCodeSession({required this.details});

  @override
  List<Object> get props => [details];
}