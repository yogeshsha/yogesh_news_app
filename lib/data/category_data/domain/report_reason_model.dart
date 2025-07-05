class ReportReasonModel {
  List<Reasons>? reasons;

  ReportReasonModel({this.reasons});

  ReportReasonModel.fromJson(Map<String, dynamic> json) {
    if (json['reasons'] != null) {
      reasons = <Reasons>[];
      json['reasons'].forEach((v) {
        reasons!.add(Reasons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reasons != null) {
      data['reasons'] = reasons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reasons {
  String? title;
  String? description;

  Reasons({this.title, this.description});

  Reasons.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
