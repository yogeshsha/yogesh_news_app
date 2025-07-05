import 'all_news_model.dart';

class NewsModel {
  int? count;
  String? imageUrl;
  List<AllNewsModel>? newsList;

  NewsModel({this.count, this.newsList});

  NewsModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    imageUrl = json['imageUrl'];
    if (json['rows'] != null) {
      newsList = <AllNewsModel>[];
      json['rows'].forEach((v) {
        newsList!.add(AllNewsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['imageUrl'] = imageUrl;
    if (newsList != null) {
      data['rows'] = newsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
