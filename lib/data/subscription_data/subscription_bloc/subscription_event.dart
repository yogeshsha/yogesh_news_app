part of 'subscription_bloc.dart';

abstract class SubscriptionEvent extends Equatable {
  final String? url;
  final bool? isLoading;
  final Map? body;
  const SubscriptionEvent({this.url, this.isLoading,this.body});

  @override
  List<Object> get props => [];
}
class FetchInitialSubscription extends SubscriptionEvent {
  const FetchInitialSubscription();
}

class GetAllSubscriptionEvent extends SubscriptionEvent {
  const GetAllSubscriptionEvent({required super.url,required super.isLoading});
}

class FetchAddSubscription extends SubscriptionEvent {
  const FetchAddSubscription({required super.body});
}

class AddFreeSubscriptionEvent extends SubscriptionEvent {
  const AddFreeSubscriptionEvent();
}

class GetCurrentSubscription extends SubscriptionEvent {
  const GetCurrentSubscription();
}

class RenewSubscription extends SubscriptionEvent {
  const RenewSubscription({required super.body});
}

class UpgradeSubscription extends SubscriptionEvent {
  const UpgradeSubscription({required super.body});
}


