import 'package:either_dart/either.dart';
import 'package:newsapp/constants/common_model/api_model.dart';
import 'package:newsapp/data/login_data/domain/login_model/login_model.dart';

import '../repo/session_repo_interface.dart';


class SessionUseCase {
  final SessionRepository sessionRepository;
  SessionUseCase({required this.sessionRepository});
  Future<Either<LoginModel,ApiModel>> getSessionApi(){
    return sessionRepository.getSessionApi();
  }
}
