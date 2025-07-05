part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}


class NewsCategoryLoaded extends CategoryState {
  final List<NewsCategoryModel> category;

  const NewsCategoryLoaded({required this.category});

  @override
  List<Object> get props => [category];
}

class FeaturedNewsLoaded extends CategoryState {
  final List<AllNewsModel> featuredNews;

  const FeaturedNewsLoaded({required this.featuredNews});

  @override
  List<Object> get props => [featuredNews];
}
class ReportReasonLoaded extends CategoryState {
  final ReportReasonModel detail;

  const ReportReasonLoaded({required this.detail});

  @override
  List<Object> get props => [detail];
}
class PostReportReasonLoaded extends CategoryState {
  final String message;

  const PostReportReasonLoaded({required this.message});

  @override
  List<Object> get props => [message];
}
class AddCategoryLoaded extends CategoryState {
  final String message;

  const AddCategoryLoaded({required this.message});

  @override
  List<Object> get props => [message];
}
class UpdateUserLoaded extends CategoryState {
  final String message;

  const UpdateUserLoaded({required this.message});

  @override
  List<Object> get props => [message];
}
class AllNewsLoaded extends CategoryState {
  final NewsModel newsList;

  const AllNewsLoaded({required this.newsList});

  @override
  List<Object> get props => [newsList];
}

class AllBookmarkNewsLoaded extends CategoryState {
  final BookMarkModel bookmarkList;

  const AllBookmarkNewsLoaded({required this.bookmarkList});

  @override
  List<Object> get props => [bookmarkList];
}
class AllYourNewsLoaded extends CategoryState {
  final YourNewsModel yourNews;

  const AllYourNewsLoaded({required this.yourNews});

  @override
  List<Object> get props => [yourNews];
}

class GetNewsDetailLoaded extends CategoryState {
  final AllNewsModel details;

  const GetNewsDetailLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class GetLikedNewsLoaded extends CategoryState {
  final NewsModel details;

  const GetLikedNewsLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class BookMarkLoaded extends CategoryState {
  final String message;

  const BookMarkLoaded({required this.message});

  @override
  List<Object> get props => [message];
}
class DeepLinkLoaded extends CategoryState {
  final DeepLinkModel details;

  const DeepLinkLoaded({required this.details});

  @override
  List<Object> get props => [details];
}

class PushNewsLoaded extends CategoryState {
  final String message;

  const PushNewsLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

class DeleteNewsLoaded extends CategoryState {
  final String message;

  const DeleteNewsLoaded({required this.message});

  @override
  List<Object> get props => [message];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError({required this.message});

  @override
  List<Object> get props => [message];
}
class OtherStatusCodeCategoryLoaded extends CategoryState {
  final ApiModel details;

  const OtherStatusCodeCategoryLoaded({required this.details});

  @override
  List<Object> get props => [details];
}