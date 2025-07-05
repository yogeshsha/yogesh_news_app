part of 'complain_bloc.dart';

// ignore: must_be_immutable
abstract class ComplainEvent extends Equatable {
  String id;
  String complain;
  ComplainEvent({required this.id,required this.complain});

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchComplain extends ComplainEvent {
  FetchComplain({required super.id,required super.complain});
}
