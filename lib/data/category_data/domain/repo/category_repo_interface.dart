import 'package:either_dart/either.dart';
import 'package:newsapp/data/category_data/domain/category_model/your_news_model.dart';
import 'package:newsapp/data/category_data/domain/report_reason_model.dart';

import '../../../../constants/common_model/api_model.dart';
import '../../../../constants/common_model/deep_link_model.dart';
import '../../../../constants/common_model/key_value_model.dart';
import '../category_model/all_news_model.dart';
import '../category_model/bookmark_model.dart';
import '../category_model/news_category_model.dart';
import '../category_model/news_model.dart';
abstract class CategoryRepository {
  Future<Either<List<NewsCategoryModel>, ApiModel>> getCategoryApi(String url);
  Future<Either<List<AllNewsModel>, ApiModel>> getFeaturedNewsApi(String url);
  Future<Either<ReportReasonModel, ApiModel>> getReportReasonApi();
  Future<Either<String, ApiModel>> postReportReasonApi(Map body);
  Future<Either<String, ApiModel>> addCategoryApi(Map body);
  Future<Either<String, ApiModel>> updateMyDetailsApi(Map body);
  Future<Either<NewsModel, ApiModel>> getNewsEvent(String url);
  Future<Either<BookMarkModel, ApiModel>> getBookmarkNewsApi(String url);
  Future<Either<YourNewsModel, ApiModel>> getYourNewsApi(String url);
  Future<Either<AllNewsModel, ApiModel>> getNewsDetailApi(int id,String screenName);
  Future<Either<NewsModel, ApiModel>> getLickedNewsApi(String url);
  Future<Either<String, ApiModel>> bookMarkApi(String url,Map body);
  Future<Either<DeepLinkModel, ApiModel>> generateDeepLinkUrl(String url);
  Future<Either<String, ApiModel>> pushNewsApi(Map body,int id,List<KeyValueModel> media);
  Future<Either<String, ApiModel>> deleteNewsApi(int id);
}