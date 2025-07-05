

import 'package:newsapp/data/category_data/domain/category_model/category_model.dart';

import '../repo/infinite_repo_interface.dart';

class InfiniteUseCase {
  final InfiniteRepository infiniteRepository;
  InfiniteUseCase({required this.infiniteRepository});
  Future<List<LatestNews>> getInfiniteApi(String page,String limit) {
    return infiniteRepository.getInfiniteApi(page,limit);
  }
}
