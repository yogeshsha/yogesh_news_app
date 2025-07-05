import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../domain/detail_model/detail_model.dart';
import '../domain/repo/detail_repo_interface.dart';

class DetailRepositoryImpl implements DetailRepository {
  @override
  Future<DetailModel> getDetailApi(String id) async {
    try {
      final response = await http.get(Uri.parse("${ApiConstants.detailUrl}$id"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final agentList = jsonData as Map<String ,dynamic>;
        return DetailModel.fromJson(agentList);
      } else {
        throw Exception(
            'Failed to fetch details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch details: $e');
    }
  }

}
