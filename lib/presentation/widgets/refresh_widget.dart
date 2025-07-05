import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/constants/images_constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';



class RefreshComponent extends StatefulWidget {
  final Widget child;
  final Function onRefresh;
  final ScrollController? scrollController;

  const RefreshComponent(
      {super.key,
      required this.child,
      required this.onRefresh,
      this.scrollController});

  @override
  State<RefreshComponent> createState() => _RefreshComponentState();
}

class _RefreshComponentState extends State<RefreshComponent> {
  final RefreshController _refreshController = RefreshController();

  void _onLoading() async {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      if (mounted) {
        _refreshController.loadComplete();
      }
    });
  }

  Future<void> _onRefresh() async {
    Future.delayed(const Duration(milliseconds: 1500)).then((value) {
      if (mounted) {
        widget.onRefresh();
        _refreshController.refreshCompleted();
      }
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      scrollController: widget.scrollController,
      physics: const BouncingScrollPhysics(),

      controller: _refreshController,
      header: ClassicHeader(
        textStyle: Theme.of(context).textTheme.titleSmall ?? GoogleFonts.poppins(),
        refreshingIcon: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Image.asset(ImagesConstants.load),
          // child: const CustomCircularLoader(width: 30,height: 30),
        ),
      ),
      onLoading: _onLoading,
      enablePullDown: true,
      onRefresh: _onRefresh,
      child: widget.child,
    );
  }
}
