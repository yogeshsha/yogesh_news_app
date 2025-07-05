part of 'terms_bloc.dart';

abstract class TermsEvent extends Equatable {
  const TermsEvent();

  @override
  List<Object> get props => [];
}

class FetchTerms extends TermsEvent {}
