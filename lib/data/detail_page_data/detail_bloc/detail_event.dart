part of 'detail_bloc.dart';

// ignore: must_be_immutable
abstract class DetailEvent extends Equatable {
  String id;
  DetailEvent({required this.id});

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchDetail extends DetailEvent {
  FetchDetail({required super.id});
}
