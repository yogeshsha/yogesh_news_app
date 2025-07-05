

import '../favorite_model/favorite_model.dart';
import '../repo/favorite_repo_interface.dart';

class FavoriteUseCase {
  final FavoriteRepository favoriteRepository;
  FavoriteUseCase({required this.favoriteRepository});
  Future<List<FavoriteModel>> getFavoriteApi() {
    return favoriteRepository.getFavoriteApi();
  }
}
