part of 'subscription_bloc.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}
class SubscriptionLoading extends SubscriptionState {}



class SubscriptionLoaded extends SubscriptionState {
  final SubscriptionMainModel details;
  const SubscriptionLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class AddSubscriptionLoaded extends SubscriptionState {
  final String message;
  const AddSubscriptionLoaded({required this.message});

  @override
  List<Object> get props => [message];
}
class AddFreeSubscriptionLoaded extends SubscriptionState {
  final String message;
  const AddFreeSubscriptionLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

class RenewSubscriptionLoaded extends SubscriptionState {
  final String message;
  const RenewSubscriptionLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

class UpgradeSubscriptionLoaded extends SubscriptionState {
  final String message;
  const UpgradeSubscriptionLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

class CurrentSubscriptionLoaded extends SubscriptionState {
  final MyCurrentSubscriptionModel details;
  const CurrentSubscriptionLoaded({required this.details});

  @override
  List<Object> get props => [details];
}



class SubscriptionError extends SubscriptionState {
  final String message;

  const SubscriptionError({required this.message});

  @override
  List<Object> get props => [message];
}
class OtherSubscriptionLoaded extends SubscriptionState {
  final ApiModel details;

  const OtherSubscriptionLoaded({required this.details});

  @override
  List<Object> get props => [details];
}


