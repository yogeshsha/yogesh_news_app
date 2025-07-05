
import '../breaking_model/breaking_model.dart';

abstract class BreakingRepository {
  Future<List<BreakingNewsModel>> getBreakingApi();
}
