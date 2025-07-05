import 'package:http/http.dart' as http;
import 'package:newsapp/constants/app_constant.dart';
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../../../utils/app.dart';
import '../domain/like_model/like_model.dart';
import '../domain/like_model/unlike_model.dart';
import '../domain/repo/like_repo_interface.dart';




class LikeRepositoryImpl implements LikeRepository {
  @override
  Future<LikeModel> getLikeApi(Map body) async {
    try {
      AppHelper.myPrint("------------------ Token ------------");
      AppHelper.myPrint(SessionHelper().get(SessionHelper.userId));
      AppHelper.myPrint(body);
      AppHelper.myPrint("------------------------------");
      final response = await http.post(Uri.parse(ApiConstants.likeUrl),body: body, headers: {
      'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
      } );
      AppHelper.myPrint("------------------ Response ------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("------------------------------");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final details = jsonData as List<dynamic>;
        AppHelper.myPrint("------------------- like Response -------------------");
        AppHelper.myPrint(details);
        AppHelper.myPrint("--------------------------------------");
        return LikeModel.fromJson(details.first);
      }else if(response.statusCode == 401){
        throw('Login Token Expire');
      }else {
        throw '\ncode: ${response.statusCode}\nmessage : ${jsonDecode(response.body)['message']}';
      }
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<UnLikeModel> getUnLikeApi(Map body) async {
    try {
      AppHelper.myPrint("------------------ Token ------------");
      AppHelper.myPrint(body);

      AppHelper.myPrint(SessionHelper().get(SessionHelper.userId));
      AppHelper.myPrint("------------------------------");
      final response = await http.post(Uri.parse(ApiConstants.unLikeUrl),body: body, headers: {
        'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
      } );
      AppHelper.myPrint("------------------ Response ------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("------------------------------");

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        final details = jsonData as Map<String,dynamic>;
        AppHelper.myPrint("------------------- un like Response -------------------");
        AppHelper.myPrint(details);
        AppHelper.myPrint("--------------------------------------");
        return UnLikeModel.fromJson(details);
      }else if(response.statusCode == 401){
        throw('Login Token Expire');
      } else {
        throw '\nStatus code: ${response.statusCode}\nMessage : ${jsonDecode(response.body)['message']}';
      }
    } catch (e) {
      rethrow;
    }
  }

}
