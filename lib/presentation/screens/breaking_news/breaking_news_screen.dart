import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/breaking_news_data/breaking_bloc/breaking_bloc.dart';
import '../../widgets/banner_widget.dart';

class BreakingNewsScreen extends StatefulWidget {
  final Function before;
 final  Function(bool) after;

  const BreakingNewsScreen({super.key,required this.after,required this.before});

  @override
  State<BreakingNewsScreen> createState() => _BreakingNewsScreenState();
}

class _BreakingNewsScreenState extends State<BreakingNewsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BreakingBloc, BreakingState>
        (builder: (context, state) {
        if (state is BreakingLoaded) {
          return  bannerWidget(
              context,
              "https://static.toiimg.com/thumb/imgsize-37494,msid-101650517,width-400,resizemode-4/101650517.jpg",
              state.details.first.shortDescription!,
              onTap: () {
                Map map = {};
                map['list'] = state.details;
                map['image'] =
                "https://static.toiimg.com/thumb/imgsize-37494,msid-101650517,width-400,resizemode-4/101650517.jpg";
                bool check = widget.before();
                Navigator.pushNamed(context, "/bannerExpanded", arguments: map)
                    .then((value) {
                  widget.after(check);
                });
              });
        }
        return const SizedBox();
      });
  }
}
