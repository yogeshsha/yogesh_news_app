


import '../complain_model/complain_model.dart';
import '../repo/complain_repo_interface.dart';

class ComplainUseCase {
  final ComplainRepository complainRepository;
  ComplainUseCase({required this.complainRepository});
  Future<ComplainModel> getComplainApi(String id) {
    return complainRepository.getComplainApi(id);
  }
}
