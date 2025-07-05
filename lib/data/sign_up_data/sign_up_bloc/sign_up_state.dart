part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpLoaded extends SignUpState {
  final LoginModel details;

  const SignUpLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class SignUpError extends SignUpState {
  final String message;

  const SignUpError({required this.message});

  @override
  List<Object> get props => [message];
}
class OtherStatusCodeSignUpLoaded extends SignUpState {
  final ApiModel details;

  const OtherStatusCodeSignUpLoaded({required this.details});

  @override
  List<Object> get props => [details];
}
