import 'package:http/http.dart' as http;
import 'package:newsapp/data/category_data/domain/category_model/category_model.dart';
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../domain/repo/infinite_repo_interface.dart';



class InfiniteRepositoryImpl implements InfiniteRepository {
  @override
  Future<List<LatestNews>> getInfiniteApi(String page,String limit) async {
    try {
      final response = await http.get(Uri.parse("${ApiConstants.detailUrl}?page=$page&limit=$limit"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // final details = jsonData as Map<String ,dynamic>;
        final infiniteList = jsonData as List<dynamic>;
        final infinite = infiniteList.map((infiniteData) {
          try {
            return LatestNews.fromJson(infiniteData);
          } catch (e) {
            return null;
          }
        }).toList();
        infinite.removeWhere((infinite) => infinite == null);

        return infinite.cast<LatestNews>();
        
      } else {
        throw Exception(
            'Failed to fetch infinite. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch infinite: $e');
    }
  }

}
