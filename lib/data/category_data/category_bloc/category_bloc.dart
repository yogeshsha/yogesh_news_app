import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/constants/common_model/key_value_model.dart';
import 'package:newsapp/data/category_data/domain/category_model/your_news_model.dart';

import '../../../constants/common_model/api_model.dart';
import '../../../constants/common_model/deep_link_model.dart';
import '../domain/category_model/all_news_model.dart';
import '../domain/category_model/bookmark_model.dart';
import '../domain/category_model/news_category_model.dart';
import '../domain/category_model/news_model.dart';
import '../domain/report_reason_model.dart';
import '../domain/usecases/category_usecase_interface.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUseCase categoryUseCase;

  CategoryBloc({required this.categoryUseCase}) : super(CategoryInitial()) {
    on<FetchCategoryEvent>((event, emit) async {
      if(event.isLoading ?? true){
        emit(CategoryLoading());
      }
      try {
        Either<List<NewsCategoryModel>, ApiModel> details = await categoryUseCase.getCategoryApi(event.url ?? "");
        if(details.isLeft){
          emit(NewsCategoryLoaded(category: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
    on<FetchFeaturedNewsEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        Either<List<AllNewsModel>, ApiModel> details = await categoryUseCase.getFeaturedNewsApi(event.url ?? "");
        if(details.isLeft){
          emit(FeaturedNewsLoaded(featuredNews: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
    on<GetReportReasonEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        Either<ReportReasonModel, ApiModel> details = await categoryUseCase.getReportReasonApi();
        if(details.isLeft){
          emit(ReportReasonLoaded(detail: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
    on<PostReportReasonEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        Either<String, ApiModel> details = await categoryUseCase.postReportReasonApi(event.body??{});
        if(details.isLeft){
          emit(PostReportReasonLoaded(message: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
    on<AddCategoryEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        Either<String, ApiModel> details = await categoryUseCase.addCategoryApi(event.body??{});
        if(details.isLeft){
          emit(AddCategoryLoaded(message: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
    on<UpdateMyDetailsEvent>((event, emit) async {
      emit(CategoryLoading());
      try {
        Either<String, ApiModel> details = await categoryUseCase.updateMyDetailsApi(event.body??{});
        if(details.isLeft){
          emit(UpdateUserLoaded(message: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
    on<FetchNewsEvent>((event, emit) async {
      if(event.isLoading ?? true){
        emit(CategoryLoading());
      }
      try {
        Either<NewsModel, ApiModel> details = await categoryUseCase.getNewsEvent(event.url ?? "");
        if(details.isLeft){
          emit(AllNewsLoaded(newsList: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
    on<FetchBookmarkNewsEvent>((event, emit) async {
      if(event.isLoading ?? true){
        emit(CategoryLoading());
      }
      try {
        Either<BookMarkModel, ApiModel> details = await categoryUseCase.getBookmarkNewsApi(event.url ?? "");
        if(details.isLeft){
          emit(AllBookmarkNewsLoaded(bookmarkList: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
    on<FetchYourNewsEvent>((event, emit) async {
      if(event.isLoading ?? true){
        emit(CategoryLoading());
      }
      try {
        Either<YourNewsModel, ApiModel> details = await categoryUseCase.getYourNewsApi(event.url ?? "");
        if(details.isLeft){
          emit(AllYourNewsLoaded(yourNews: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });

    on<FetchNewsDetailEvent>((event, emit) async {
        emit(CategoryLoading());
      try {
        Either<AllNewsModel, ApiModel> details = await categoryUseCase.getNewsDetailApi(event.id ??0,event.screenName??"");
        if(details.isLeft){
          emit(GetNewsDetailLoaded(details: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });

    on<GetLikedNewsEvent>((event, emit) async {
      if(event.isLoading ?? true){
        emit(CategoryLoading());
      }
      try {
        Either<NewsModel, ApiModel> details = await categoryUseCase.getLikedNewsApi(event.url ??"");
        if(details.isLeft){
          emit(GetLikedNewsLoaded(details: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });

    on<BookMarkEvent>((event, emit) async {
        emit(CategoryLoading());
      try {
        Either<String, ApiModel> details = await categoryUseCase.bookMarkApi(event.url ?? "",event.body ?? {});
        if(details.isLeft){
          emit(BookMarkLoaded(message: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });

    on<GenerateDeepLinkUrl>((event, emit) async {
        emit(CategoryLoading());
      try {
        Either<DeepLinkModel, ApiModel> details = await categoryUseCase.generateDeepLinkUrl(event.url ?? "");
        if(details.isLeft){
          emit(DeepLinkLoaded(details: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });

    on<PushNewsEvent>((event, emit) async {
        emit(CategoryLoading());
      try {
        Either<String, ApiModel> details = await categoryUseCase.pushNewsApi(event.body ?? {},event.id ?? 0,event.media ?? []);
        if(details.isLeft){
          emit(PushNewsLoaded(message: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });

    on<FetchDeleteNewsEvent>((event, emit) async {
        emit(CategoryLoading());
      try {
        Either<String, ApiModel> details = await categoryUseCase.deleteNewsApi(event.id ?? 0);
        if(details.isLeft){
          emit(DeleteNewsLoaded(message: details.left));
        }else{
          emit(OtherStatusCodeCategoryLoaded(details: details.right));
        }
      } catch (e) {
        emit(CategoryError(message: e.toString()));
      }
    });
    on<FetchInitialCategory>((event, emit) async {
      emit(CategoryInitial());
    });
  }
}
