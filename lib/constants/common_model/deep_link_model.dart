class DeepLinkModel {
  String? message;
  String? deepLinkUrl;
  String? hindiTitle;
  String? hindiDes;
  String? englishTitle;
  String? englishDes;

  DeepLinkModel({this.message, this.deepLinkUrl, this.hindiTitle, this.englishTitle, this.englishDes, this.hindiDes});

  DeepLinkModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    deepLinkUrl = json['deepLinkUrl'];
    hindiTitle = json['hindiTitle'];
    englishTitle = json['englishTitle'];
    englishDes = json['englishDes'];
    hindiDes = json['hindiDes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['deepLinkUrl'] = deepLinkUrl;
    data['hindiTitle'] = hindiTitle;
    data['englishDes'] = englishDes;
    data['hindiDes'] = hindiDes;
    data['englishTitle'] = englishTitle;
    return data;
  }
}
