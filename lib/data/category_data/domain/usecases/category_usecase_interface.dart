import 'package:either_dart/either.dart';
import 'package:newsapp/constants/common_model/key_value_model.dart';
import 'package:newsapp/data/category_data/domain/category_model/news_model.dart';
import 'package:newsapp/data/category_data/domain/category_model/your_news_model.dart';
import 'package:newsapp/data/category_data/domain/report_reason_model.dart';

import '../../../../constants/common_model/api_model.dart';
import '../../../../constants/common_model/deep_link_model.dart';
import '../category_model/all_news_model.dart';
import '../category_model/bookmark_model.dart';
import '../category_model/news_category_model.dart';
import '../repo/category_repo_interface.dart';

class CategoryUseCase {
  final CategoryRepository categoryRepository;
  CategoryUseCase({required this.categoryRepository});
  Future<Either<List<NewsCategoryModel>, ApiModel>> getCategoryApi(String url) {
    return categoryRepository.getCategoryApi(url);
  }
  Future<Either<List<AllNewsModel>, ApiModel>> getFeaturedNewsApi(String url) {
    return categoryRepository.getFeaturedNewsApi(url);
  }
  Future<Either<ReportReasonModel, ApiModel>> getReportReasonApi() {
    return categoryRepository.getReportReasonApi();
  }
  Future<Either<String, ApiModel>> postReportReasonApi(Map body) {
    return categoryRepository.postReportReasonApi(body);
  }
  Future<Either<String, ApiModel>> addCategoryApi(Map body) {
    return categoryRepository.addCategoryApi(body);
  }
  Future<Either<String, ApiModel>> updateMyDetailsApi(Map body) {
    return categoryRepository.updateMyDetailsApi(body);
  }
  Future<Either<NewsModel, ApiModel>> getNewsEvent(String url) {
    return categoryRepository.getNewsEvent(url);
  }
  Future<Either<BookMarkModel, ApiModel>> getBookmarkNewsApi(String url) {
    return categoryRepository.getBookmarkNewsApi(url);
  }
  Future<Either<YourNewsModel, ApiModel>> getYourNewsApi(String url) {
    return categoryRepository.getYourNewsApi(url);
  }
  Future<Either<AllNewsModel, ApiModel>> getNewsDetailApi(int id,String screenName) {
    return categoryRepository.getNewsDetailApi(id,screenName);
  }
  Future<Either<NewsModel, ApiModel>> getLikedNewsApi(String url) {
    return categoryRepository.getLickedNewsApi(url);
  }
  Future<Either<String, ApiModel>> bookMarkApi(String url,Map body) {
    return categoryRepository.bookMarkApi(url,body);
  }
  Future<Either<DeepLinkModel, ApiModel>> generateDeepLinkUrl(String url) {
    return categoryRepository.generateDeepLinkUrl(url);
  }
  Future<Either<String, ApiModel>> pushNewsApi(Map body, int id,List<KeyValueModel> media) {
    return categoryRepository.pushNewsApi(body,id,media);
  }

  Future<Either<String, ApiModel>> deleteNewsApi(int id) {
    return categoryRepository.deleteNewsApi(id);
  }
}
