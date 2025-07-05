part of 'infinite_bloc.dart';

// ignore: must_be_immutable
abstract class InfiniteEvent extends Equatable {
  String page;
  String limit;
  InfiniteEvent({required this.page,required this.limit});

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchInfinite extends InfiniteEvent {
  FetchInfinite({required super.page,required super.limit});
}

// ignore: must_be_immutable
class FetchInitialInfinite extends InfiniteEvent {
  FetchInitialInfinite({required super.page,required super.limit});
}