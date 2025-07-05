part of 'like_bloc.dart';

// ignore: must_be_immutable
abstract class LikeEvent extends Equatable {
  Map body;
  LikeEvent({required this.body});

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchLike extends LikeEvent {
  FetchLike({required super.body});
}

// ignore: must_be_immutable
class FetchUnLike extends LikeEvent {
  FetchUnLike({required super.body});
}


// ignore: must_be_immutable
class FetchInitialLike extends LikeEvent {
  FetchInitialLike({required super.body});
}
// ignore: must_be_immutable
class FetchInitialUnLike extends LikeEvent {
  FetchInitialUnLike({required super.body});
}


