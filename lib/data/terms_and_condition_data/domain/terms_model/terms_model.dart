class TermsModel {
  List<LatestNews>? latestNews;
  List<NewsTerms>? newsTerms;
  List<LatestNews>? featuredNews;

  TermsModel({this.latestNews, this.newsTerms, this.featuredNews});

  TermsModel.fromJson(Map<String, dynamic> json) {
    if (json['latestNews'] != null) {
      latestNews = <LatestNews>[];
      json['latestNews'].forEach((v) {
        latestNews!.add(LatestNews.fromJson(v));
      });
    }
    if (json['newsTerms'] != null) {
      newsTerms = <NewsTerms>[];
      json['newsTerms'].forEach((v) {
        newsTerms!.add(NewsTerms.fromJson(v));
      });
    }
    if (json['featuredNews'] != null) {
      featuredNews = <LatestNews>[];
      json['featuredNews'].forEach((v) {
        featuredNews!.add(LatestNews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (latestNews != null) {
      data['latestNews'] = latestNews!.map((v) => v.toJson()).toList();
    }
    if (newsTerms != null) {
      data['newsTerms'] = newsTerms!.map((v) => v.toJson()).toList();
    }
    if (featuredNews != null) {
      data['featuredNews'] = featuredNews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LatestNews {
  int? id;
  int? termsId;
  String? title;
  String? shortDescription;
  List<Description>? description;
  String? posterImage;
  String? createdAt;
  String? updatedAt;
  NewsTerms? newsTerms;

  LatestNews(
      {this.id,
        this.termsId,
        this.title,
        this.shortDescription,
        this.description,
        this.posterImage,
        this.createdAt,
        this.updatedAt,
        this.newsTerms});

  LatestNews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    termsId = json['TermsId'];

    title = json['title'];
    shortDescription = json['shortDescription'];
    if (json['description'] != null) {
      description = <Description>[];
      json['description'].forEach((v) {
        description!.add(Description.fromJson(v));
      });
    }
    posterImage = json['posterImage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    newsTerms = json['NewsTerms'] != null
        ? NewsTerms.fromJson(json['NewsTerms'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['TermsId'] = termsId;
    data['title'] = title;
    data['shortDescription'] = shortDescription;
    if (description != null) {
      data['description'] = description!.map((v) => v.toJson()).toList();
    }
    data['posterImage'] = posterImage;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (newsTerms != null) {
      data['NewsTerms'] = newsTerms!.toJson();
    }
    return data;
  }
}

class Description {
  String? val;
  String? type;

  Description({this.val, this.type});

  Description.fromJson(Map<String, dynamic> json) {
    val = json['val'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['val'] = val;
    data['type'] = type;
    return data;
  }
}

class NewsTerms {
  int? id;
  int? templateId;
  String? name;

  NewsTerms(
      {this.id,
        this.templateId,
        this.name,});

  NewsTerms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    templateId = json['templateId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['templateId'] = templateId;
    data['name'] = name;
    return data;
  }
}
