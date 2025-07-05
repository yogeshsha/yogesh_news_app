



import '../complain_model/complain_model.dart';

abstract class ComplainRepository {
  Future<ComplainModel> getComplainApi(String id);
}
