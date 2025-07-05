import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../domain/repo/terms_repo_interface.dart';
import '../domain/terms_model/terms_model.dart';

class TermsRepositoryImpl implements TermsRepository {
  @override
  Future<TermsModel> getTermsApi() async {
    try {
      final response = await http.get(Uri.parse(ApiConstants.detailUrl));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final agentList = jsonData as Map<String ,dynamic>;
        return TermsModel.fromJson(agentList);
      } else {
        throw Exception(
            'Failed to fetch details. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch details: $e');
    }
  }

}
