

import '../repo/terms_repo_interface.dart';
import '../terms_model/terms_model.dart';

class TermsUseCase {
  final TermsRepository termsRepository;
  TermsUseCase({required this.termsRepository});
  Future<TermsModel> getTermsApi() {
    return termsRepository.getTermsApi();
  }
}
