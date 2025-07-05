
import '../terms_model/terms_model.dart';

abstract class TermsRepository {
  Future<TermsModel> getTermsApi();
}
