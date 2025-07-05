part of 'favorite_bloc.dart';

// ignore: must_be_immutable
abstract class FavoriteEvent extends Equatable {

  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchFavorite extends FavoriteEvent {}


// ignore: must_be_immutable
class FetchInitialFavorite extends FavoriteEvent {
  const FetchInitialFavorite();
}
