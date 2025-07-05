import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/constants/app_constant.dart';

import '../../../constants/colors_constants.dart';
import '../../../data/like_data/domain/usecases/like_usecase_interface.dart';
import '../../../data/like_data/like_bloc/like_bloc.dart';
import '../../../data/like_data/repo/like_impl.dart';
import '../../../utils/app.dart';

class LikeUnlikeWidget extends StatefulWidget {
  final String id;
  final  List<String> isLiked;
  final  Function(String)? remove;

  const LikeUnlikeWidget({super.key, required this.isLiked, required this.id,required this.remove});

  @override
  State<LikeUnlikeWidget> createState() => _LikeUnlikeWidgetState();
}

class _LikeUnlikeWidgetState extends State<LikeUnlikeWidget> {
  bool isLikedCheck = true;
  bool isUnLikedCheck = true;
  late LikeUseCase likeUseCase;
  bool errorEmitted = true;
  bool errorEmitted1 = true;

  @override
  void initState() {
    likeUseCase =
        LikeUseCase(likeRepository: LikeRepositoryImpl());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LikeBloc>(
        create: (context) => LikeBloc(likeUseCase: likeUseCase),
        child: BlocBuilder<LikeBloc, LikeState>(builder: (context, state) {
          if (state is LikeLoaded) {
            if (mounted) {
              context.read<LikeBloc>().add(FetchInitialLike(body: const {}));
            }
            widget.isLiked.add("123");
          } else if (state is LikeError) {
            if(state.message =="Login Token Expire"){
              SessionHelper().clear();
            }
            if(errorEmitted) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                AppHelper.showSnakeBar(context, state.message);
                errorEmitted = false;
              });
            }
            context.read<LikeBloc>().add(FetchInitialLike(body: const {}));
            widget.isLiked.add("123");
          } else if (state is UnLikeLoaded) {
            if(widget.remove != null){

              widget.remove!(widget.id);
            }else {
              widget.isLiked.clear();
            }
            context.read<LikeBloc>().add(FetchInitialUnLike(body: const {}));
          } else if (state is UnLikeError) {
            if(state.message =="Login Token Expire"){
              SessionHelper().clear();
            }
            if(errorEmitted1) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                AppHelper.showSnakeBar(context, state.message);
                errorEmitted1 = false;
              });
            }
            context.read<LikeBloc>().add(FetchInitialUnLike(body: const {}));
          } else if (state is LikeLoading) {
            return CircularProgressIndicator(
              color: ColorsConstants.heartColor,
            );
          } else if (state is UnLikeLoading) {
            return CircularProgressIndicator(
              color: ColorsConstants.heartColor,
            );
          }
          return IconButton(
              onPressed: () {
                if (widget.isLiked.isNotEmpty) {
                  setState(() {
                    errorEmitted1 = true;
                  });
                  context.read<LikeBloc>.call().add(FetchUnLike(body: {
                    "newsId": widget.id,
                  }));
                } else {
                  setState(() {
                    errorEmitted = true;
                  });
                  context.read<LikeBloc>.call().add(FetchLike(body: {
                    "newsId": widget.id,
                  }));
                }
              },
              icon: Icon(
                widget.isLiked.isNotEmpty
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: ColorsConstants.heartColor,
              ));
        }));
  }
}
