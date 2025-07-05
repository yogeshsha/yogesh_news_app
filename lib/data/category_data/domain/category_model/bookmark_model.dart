import 'all_news_model.dart';

class BookMarkModel {
  int? count;
  List<BookMark>? rows;

  BookMarkModel({this.count, this.rows});

  BookMarkModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <BookMark>[];
      json['rows'].forEach((v) {
        rows!.add(BookMark.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookMark {
  int? newsId;
  AllNewsModel? news;

  BookMark({this.newsId, this.news});

  BookMark.fromJson(Map<String, dynamic> json) {
    newsId = json['newsId'];
    news = json['News'] != null ? AllNewsModel.fromJson(json['News']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newsId'] = newsId;
    if (news != null) {
      data['News'] = news!.toJson();
    }
    return data;
  }
}

