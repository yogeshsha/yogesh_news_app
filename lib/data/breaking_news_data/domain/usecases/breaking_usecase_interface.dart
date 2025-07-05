
import '../breaking_model/breaking_model.dart';
import '../repo/breaking_repo_interface.dart';

class BreakingUseCase {
  final BreakingRepository breakingRepository;
  BreakingUseCase({required this.breakingRepository});
  Future<List<BreakingNewsModel>> getBreakingApi() {
    return breakingRepository.getBreakingApi();
  }
}
