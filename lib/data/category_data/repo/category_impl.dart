import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/data/category_data/domain/category_model/your_news_model.dart';
import 'package:newsapp/data/category_data/domain/report_reason_model.dart';
import 'package:newsapp/utils/app.dart';
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../../../constants/app_constant.dart';
import '../../../constants/common_model/api_model.dart';
import '../../../constants/common_model/deep_link_model.dart';
import '../../../constants/common_model/key_value_model.dart';
import '../domain/category_model/all_news_model.dart';
import '../domain/category_model/bookmark_model.dart';
import '../domain/category_model/news_category_model.dart';
import '../domain/category_model/news_model.dart';
import '../domain/repo/category_repo_interface.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  @override
  Future<Either<List<NewsCategoryModel>, ApiModel>> getCategoryApi(String url) async {
    try {
      String sendUrl = "${ApiConstants.categoryUrl}$url";
      AppHelper.myPrint(
          "------------------ Value Category Api -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("-------------------------------------");

      http.Response response = await AppHelper.callApi(url: sendUrl);
      AppHelper.myPrint(
          "------------------ Response Category Api -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final details = jsonData as List;
        List<NewsCategoryModel> list = [];
        details.map((e) => list.add(NewsCategoryModel.fromJson(e))).toList();

        return Left(list);
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<List<AllNewsModel>, ApiModel>> getFeaturedNewsApi(
      String url) async {
    try {
      String sendUrl = "${ApiConstants.latestNewsUrl}$url";
      AppHelper.myPrint(
          "------------------ Value getFeaturedNewsApi Api -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("-------------------------------------");

      http.Response response = await AppHelper.callApi(url: sendUrl);
      AppHelper.myPrint(
          "------------------ Response getFeaturedNewsApi Api -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final details = jsonData as List;
        List<AllNewsModel> list = [];
        details.map((e) => AllNewsModel.fromJson(e)).toList();
        return Left(list);
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<ReportReasonModel, ApiModel>> getReportReasonApi() async {
    try {
      String sendUrl = ApiConstants.getReportReasonUrl;
      AppHelper.myPrint(
          "------------------ Value getReportReasonApi -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("-------------------------------------");

      http.Response response = await AppHelper.callApi(url: sendUrl);
      AppHelper.myPrint(
          "------------------ Response getReportReasonApi -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final details = jsonData as Map<String, dynamic>;
        return Left(ReportReasonModel.fromJson(details));
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<NewsModel, ApiModel>> getNewsEvent(String url) async {
    try {
      String sendUrl = "${ApiConstants.getNewsUrl}$url";
      AppHelper.myPrint(
          "------------------ Value getNewsEvent Api -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("-------------------------------------");

      http.Response response = await AppHelper.callApi(url: sendUrl);
      AppHelper.myPrint(
          "------------------ Response getNewsEvent Api -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final details = jsonData as Map<String, dynamic>;
        return Left(NewsModel.fromJson(details));
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<BookMarkModel, ApiModel>> getBookmarkNewsApi(String url) async {
    try {
      String sendUrl = "${ApiConstants.getBookmarkListUrl}$url";
      AppHelper.myPrint(
          "------------------ Value getBookmarkNewsApi -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("-------------------------------------");

      http.Response response = await AppHelper.callApi(url: sendUrl);
      AppHelper.myPrint(
          "------------------ Response getBookmarkNewsApi -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final details = jsonData as Map<String, dynamic>;
        return Left(BookMarkModel.fromJson(details));
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<YourNewsModel, ApiModel>> getYourNewsApi(String url) async {
    try {
      String sendUrl = "${ApiConstants.getYourListUrl}$url";
      AppHelper.myPrint(
          "------------------ Value getYourNewsApi -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("-------------------------------------");

      http.Response response = await AppHelper.callApi(
        url: sendUrl,
      );

      AppHelper.myPrint(
          "------------------ Response getYourNewsApi -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final details = jsonData as Map<String, dynamic>;
        return Left(YourNewsModel.fromJson(details));
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<AllNewsModel, ApiModel>> getNewsDetailApi(
      int id, String screenName) async {
    try {
      String sendUrl = "";
      if (screenName == "YourNewsDetail") {
        sendUrl = "${ApiConstants.getUserNewsDetailUrl}/$id";
      } else {
        sendUrl = "${ApiConstants.getNewsDetailUrl}/$id";
      }
      AppHelper.myPrint(
          "------------------- Get getNewsDetailApi --------------------");
      AppHelper.myPrint("ScreenName = $screenName");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("---------------------------------------");
      final response = await http.get(Uri.parse(sendUrl), headers: {
        "content-type": "application/json",
        'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
      });
      AppHelper.myPrint(
          "------------------- Response getNewsDetailApi --------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("---------------------------------------");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final rewards = jsonData as Map<String, dynamic>;
        return Left(AllNewsModel.fromJson(rewards));
      } else {
        return Right(
            ApiModel(statusCode: response.statusCode, message: response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<NewsModel, ApiModel>> getLickedNewsApi(String url) async {
    try {
      String sendUrl = ("${ApiConstants.getLikedNewsUrl}$url");

      AppHelper.myPrint("---------- getLickedNewsApi ---------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("---------------------------------------");
      final response = await http.get(Uri.parse(sendUrl), headers: {
        'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
      });
      AppHelper.myPrint(
          "-------------------- Response getLickedNewsApi ---------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-----------------------------------------");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final rewards = jsonData as Map<String, dynamic>;
        return Left(NewsModel.fromJson(rewards));
      } else {
        return Right(
            ApiModel(statusCode: response.statusCode, message: response.body));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<String, ApiModel>> bookMarkApi(String url, Map body) async {
    try {
      String sendUrl = "${ApiConstants.bookMarkUrl}$url";
      AppHelper.myPrint(
          "------------------ Value bookMarkApi Api -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint(body);
      AppHelper.myPrint("-------------------------------------");
      final response = await AppHelper.callApi(
          url: sendUrl, isJsonEncode: true, apiType: "post", body: body);

      AppHelper.myPrint(
          "------------------ Response bookMarkApi Api -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Left(response.body);
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<Either<DeepLinkModel, ApiModel>> generateDeepLinkUrl(String url) async {
    try {
      String sendUrl = "${ApiConstants.generateDeepLinkUrl}$url";
      AppHelper.myPrint(
          "------------------ Value generateDeepLinkUrl Api -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("-------------------------------------");
      final response = await AppHelper.callApi(
          url: sendUrl);

      AppHelper.myPrint(
          "------------------ Response generateDeepLinkUrl Api -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final data = jsonData as Map<String, dynamic>;
        return Left(DeepLinkModel.fromJson(data));
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<Either<String, ApiModel>> postReportReasonApi(Map body) async {
    try {
      String sendUrl = ApiConstants.submitReportsUrl;
      AppHelper.myPrint(
          "------------------ Value postReportReasonApi -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint(body);
      AppHelper.myPrint("-------------------------------------");
      final response = await AppHelper.callApi(
          url: sendUrl, isJsonEncode: true, apiType: "post", body: body);

      AppHelper.myPrint(
          "------------------ Response postReportReasonApi -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Left(response.body);
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<String, ApiModel>> addCategoryApi(Map body) async {
    try {
      String sendUrl = ApiConstants.updateMyDetailsUrl;
      AppHelper.myPrint(
          "------------------ Value addCategoryApi -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint(body);
      AppHelper.myPrint("-------------------------------------");
      final response = await AppHelper.callApi(
          url: sendUrl, isJsonEncode: true, apiType: "put", body: body);

      AppHelper.myPrint(
          "------------------ Response addCategoryApi -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Left(response.body);
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<String, ApiModel>> updateMyDetailsApi(Map body) async {
    try {
      String sendUrl = ApiConstants.updateMyProfileApi;
      AppHelper.myPrint(
          "------------------ Value updateMyDetailsApi -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint(body);
      AppHelper.myPrint("-------------------------------------");
      final response = await AppHelper.callApi(
          url: sendUrl, isJsonEncode: true, apiType: "put", body: body);

      AppHelper.myPrint(
          "------------------ Response updateMyDetailsApi -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Left(response.body);
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<String, ApiModel>> pushNewsApi(Map body, int id,List<KeyValueModel> media) async {
    try {
      String sendUrl = ApiConstants.pushNewsUrl;
      if (id != 0) {
        sendUrl = "${ApiConstants.updateNewsUrl}/$id";
      }
      AppHelper.myPrint(
          "------------------ Value pushNewsApi -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint(body);
      AppHelper.myPrint(media.length);
      AppHelper.myPrint("-------------------------------------");
      http.Response response = await AppHelper.postApi(
          apiType: id != 0 ? "Put" : "Post", url: sendUrl, body: body, fields: media);

      // final response = await http.post(Uri.parse(sendUrl),
      //     headers: {
      //       'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
      //     });

      AppHelper.myPrint(
          "------------------ Response pushNewsApi -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Left(response.body);
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<String, ApiModel>> deleteNewsApi(int id) async {
    try {
      String sendUrl = "${ApiConstants.deleteNewsUrl}$id";
      AppHelper.myPrint(
          "------------------ Value deleteNewsApi  -------------------");
      AppHelper.myPrint(sendUrl);
      AppHelper.myPrint("-------------------------------------");
      final response = await http.delete(Uri.parse(sendUrl), headers: {
        'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
      });

      AppHelper.myPrint(
          "------------------ Response deleteNewsApi -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("-------------------------------------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Left(response.body);
      } else {
        return Right(
            ApiModel(message: response.body, statusCode: response.statusCode));
      }
    } catch (e) {
      rethrow;
    }
  }
}
