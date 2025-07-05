part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {
  final LoginModel details;

  const LoginLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class OtherStatusCodeLoginLoaded extends LoginState {
  final ApiModel details;

  const OtherStatusCodeLoginLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class LoginError extends LoginState {
  final String message;

  const LoginError({required this.message});

  @override
  List<Object> get props => [message];
}
