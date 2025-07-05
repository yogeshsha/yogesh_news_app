part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  final bool? isLoading;
  final String? url;
  final Map? body;
  final int? id;
  final String? screenName;
  final List<KeyValueModel>? media;

  const CategoryEvent( {this.media,this.url, this.isLoading, this.body, this.id,this.screenName});

  @override
  List<Object> get props => [];
}

class FetchCategoryEvent extends CategoryEvent {
  const FetchCategoryEvent({super.url,super.isLoading});
}
class AddCategoryEvent extends CategoryEvent {
  const AddCategoryEvent({required super.body});
}
class UpdateMyDetailsEvent extends CategoryEvent {
  const UpdateMyDetailsEvent({required super.body});
}

class FetchNewsEvent extends CategoryEvent {
  const FetchNewsEvent({required super.url, required super.isLoading});
}

class FetchBookmarkNewsEvent extends CategoryEvent {
  const FetchBookmarkNewsEvent({required super.url, required super.isLoading});
}

class FetchYourNewsEvent extends CategoryEvent {
  const FetchYourNewsEvent({required super.url, required super.isLoading});
}

class FetchNewsDetailEvent extends CategoryEvent {
  const FetchNewsDetailEvent({required super.id,required super.screenName});
}

class FetchDeleteNewsEvent extends CategoryEvent {
  const FetchDeleteNewsEvent({required super.id,});
}

class GetLikedNewsEvent extends CategoryEvent {
  const GetLikedNewsEvent({required super.url,required super.isLoading});
}

class FetchFeaturedNewsEvent extends CategoryEvent {
  const FetchFeaturedNewsEvent({required super.url});
}

class GetReportReasonEvent extends CategoryEvent {
  const GetReportReasonEvent();
}

class PostReportReasonEvent extends CategoryEvent {
  const PostReportReasonEvent({required super.body});
}

class FetchInitialCategory extends CategoryEvent {
  const FetchInitialCategory();
}
class BookMarkEvent extends CategoryEvent {
  const BookMarkEvent({required super.url,required super.body});
}
class GenerateDeepLinkUrl extends CategoryEvent {
  const GenerateDeepLinkUrl({required super.url});
}
class PushNewsEvent extends CategoryEvent {
  const PushNewsEvent({required super.body,required super.id,required super.media});
}
