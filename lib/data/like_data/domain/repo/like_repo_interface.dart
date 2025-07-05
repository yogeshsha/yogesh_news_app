

import '../like_model/like_model.dart';
import '../like_model/unlike_model.dart';

abstract class LikeRepository {
  Future<LikeModel> getLikeApi(Map body);
  Future<UnLikeModel> getUnLikeApi(Map body);
}
