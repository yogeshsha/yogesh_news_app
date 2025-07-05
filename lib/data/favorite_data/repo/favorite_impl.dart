import 'package:http/http.dart' as http;
import 'package:newsapp/utils/app.dart';
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../../../constants/app_constant.dart';
import '../domain/favorite_model/favorite_model.dart';
import '../domain/repo/favorite_repo_interface.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  @override
  Future<List<FavoriteModel>> getFavoriteApi() async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.allFavoriteUrl), headers: {
        'Authorization': 'Bearer ${SessionHelper().get(SessionHelper.userId)}',
      } );
      AppHelper.myPrint("------------------- status code -------------------");
      AppHelper.myPrint(response.statusCode);
      AppHelper.myPrint(response.body);
      AppHelper.myPrint("--------------------------------------");
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        AppHelper.myPrint("------------------- Favorite Response -------------------");
        AppHelper.myPrint(jsonData);
        AppHelper.myPrint("--------------------------------------");
        final favoriteList = jsonData as List<dynamic>;

        final infinite = favoriteList.map((favoriteData) {
          try {
            return FavoriteModel.fromJson(favoriteData);
          } catch (e) {
            AppHelper.myPrint("-------------- Error --------------");
            AppHelper.myPrint(e);
            AppHelper.myPrint("----------------------------");
            return null;
          }
        }).toList();
        infinite.removeWhere((infinite) => infinite == null);

        return infinite.cast<FavoriteModel>();
      }else if(response.statusCode == 401){
        throw('Login Token Expire');
      }  else {
        throw '\nStatus code: ${response.statusCode}\nMessage : ${jsonDecode(response.body)['message']}';
      }
    } catch (e) {
      rethrow;
    }
  }

}
