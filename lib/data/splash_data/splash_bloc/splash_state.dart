part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}
class SplashMainLoaded extends SplashState {
  final LoginModel user;
  const SplashMainLoaded({required this.user});

  @override
  List<Object> get props => [user];
}
class SplashError extends SplashState {
  final String message;

  const SplashError({required this.message});

  @override
  List<Object> get props => [message];
}

class OtherStatusCodeSplash extends SplashState {
  final ApiModel details;

  const OtherStatusCodeSplash({required this.details});

  @override
  List<Object> get props => [details];
}
