import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../domain/breaking_model/breaking_model.dart';
import '../domain/repo/breaking_repo_interface.dart';


class BreakingRepositoryImpl implements BreakingRepository {
  @override
  Future<List<BreakingNewsModel>> getBreakingApi() async {
    try {

      final response = await http.get(Uri.parse(ApiConstants.breakingUrl));

      if (response.statusCode == 200) {

        final jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        // final breakingList = jsonData as Map<String, dynamic>;
        // final details = jsonData as Map<String ,dynamic>;
        final breakingList = jsonData as List<dynamic>;

        final infinite = breakingList.map((breakingData) {
          try {
            return BreakingNewsModel.fromJson(breakingData);
          } catch (e) {
            return null;
          }
        }).toList();
        infinite.removeWhere((infinite) => infinite == null);

        return infinite.cast<BreakingNewsModel>();
      } else {
        throw Exception(
            'Failed to fetch details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch details: $e');
    }
  }
}
