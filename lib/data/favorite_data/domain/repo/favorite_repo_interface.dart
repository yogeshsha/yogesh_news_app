
import '../favorite_model/favorite_model.dart';

abstract class FavoriteRepository {
  Future<List<FavoriteModel>> getFavoriteApi();
}
