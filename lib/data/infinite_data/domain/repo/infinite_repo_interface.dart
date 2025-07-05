

import '../../../category_data/domain/category_model/category_model.dart';

abstract class InfiniteRepository {
  Future<List<LatestNews>> getInfiniteApi(String page,String limit);
}
