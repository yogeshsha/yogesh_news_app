import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../constants/api_constants.dart';
import '../domain/complain_model/complain_model.dart';
import '../domain/repo/complain_repo_interface.dart';


class ComplainRepositoryImpl implements ComplainRepository {
  @override
  Future<ComplainModel> getComplainApi(String id) async {
    try {
      final response = await http.get(Uri.parse("${ApiConstants.detailUrl}$id"));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final agentList = jsonData as Map<String ,dynamic>;
        return ComplainModel.fromJson(agentList);
      }else if(response.statusCode == 401){
        throw('Login Token Expire');
      }  else {
        throw Exception(
            'Failed to fetch complains. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch complains: $e');
    }
  }

}
