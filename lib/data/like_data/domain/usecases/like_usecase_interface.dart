

import '../like_model/like_model.dart';
import '../like_model/unlike_model.dart';
import '../repo/like_repo_interface.dart';

class LikeUseCase {
  final LikeRepository likeRepository;
  LikeUseCase({required this.likeRepository});
  Future<LikeModel> getLikeApi(Map body) {
    return likeRepository.getLikeApi(body);
  }
  Future<UnLikeModel> getUnLikeApi(Map body) {
    return likeRepository.getUnLikeApi(body);
  }
}
