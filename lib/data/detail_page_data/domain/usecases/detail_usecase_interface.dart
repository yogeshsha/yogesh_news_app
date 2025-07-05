
import '../detail_model/detail_model.dart';
import '../repo/detail_repo_interface.dart';

class DetailUseCase {
  final DetailRepository detailRepository;
  DetailUseCase({required this.detailRepository});
  Future<DetailModel> getDetailApi(String id) {
    return detailRepository.getDetailApi(id);
  }
}
