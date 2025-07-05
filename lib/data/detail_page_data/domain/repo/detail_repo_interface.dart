


import '../detail_model/detail_model.dart';

abstract class DetailRepository {
  Future<DetailModel> getDetailApi(String id);
}
