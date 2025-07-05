part of 'terms_bloc.dart';

abstract class TermsState extends Equatable {
  const TermsState();

  @override
  List<Object> get props => [];
}

class TermsInitial extends TermsState {}

class TermsLoading extends TermsState {}

class TermsLoaded extends TermsState {
  final TermsModel details;

  const TermsLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class TermsError extends TermsState {
  final String message;

  const TermsError({required this.message});

  @override
  List<Object> get props => [message];
}
