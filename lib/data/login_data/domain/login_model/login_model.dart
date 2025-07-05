class LoginModel {
  User? user;
  Tokens? tokens;
  String? baseUrl;
  String? imageUrl;


  LoginModel({this.user, this.tokens, this.baseUrl, this.imageUrl});

  LoginModel.fromJson(Map<String, dynamic> json) {
    baseUrl =  json['baseUrl'];
    imageUrl =  json['imageUrl'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    tokens =
    json['tokens'] != null ? Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['baseUrl'] = baseUrl ;
    data['imageUrl'] = imageUrl ;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (tokens != null) {
      data['tokens'] = tokens!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? profileImage;
  UserDetail? userDetail;

  User({this.id, this.name, this.email, this.profileImage, this.userDetail});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userDetail = json['UserDetail'] != null
        ? UserDetail.fromJson(json['UserDetail'])
        : null;
    name = json['name'];
    email = json['email'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;

    if (userDetail != null) {
      data['UserDetail'] = userDetail!.toJson();
    }
    data['email'] = email;
    data['profileImage'] = profileImage;
    return data;
  }
}

class UserDetail {
  int? profileStatus;

  UserDetail({this.profileStatus});

  UserDetail.fromJson(Map<String, dynamic> json) {
    profileStatus = json['profileStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profileStatus'] = profileStatus;
    return data;
  }
}

class Tokens {
  Access? access;
  Access? refresh;

  Tokens({this.access, this.refresh});

  Tokens.fromJson(Map<String, dynamic> json) {
    access =
    json['access'] != null ? Access.fromJson(json['access']) : null;
    refresh =
    json['refresh'] != null ? Access.fromJson(json['refresh']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (access != null) {
      data['access'] = access!.toJson();
    }
    if (refresh != null) {
      data['refresh'] = refresh!.toJson();
    }
    return data;
  }
}

class Access {
  String? token;
  String? expires;

  Access({this.token, this.expires});

  Access.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['expires'] = expires;
    return data;
  }
}
