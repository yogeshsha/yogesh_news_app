import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../utils/app.dart';


class VideoPlayerComponent extends StatefulWidget {
  final String? url;
  final bool isLocal;
  final EdgeInsets? padding;
  final double? curve;
  final bool? autoPlay;

  const VideoPlayerComponent({super.key,
    required this.url, this.isLocal = false, this.padding, this.curve, this.autoPlay});

  @override
  State<VideoPlayerComponent> createState() => _VideoPlayerComponentState();
}

class _VideoPlayerComponentState extends State<VideoPlayerComponent> {
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;
  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    try {
      videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(AppHelper.createImageBaseUrl(widget.url ?? "")));
      if (widget.isLocal) {
        videoPlayerController =
            VideoPlayerController.file(File(widget.url ?? ""));
      }

      if (videoPlayerController != null) {
        await videoPlayerController!.initialize();

        chewieController = ChewieController(
          videoPlayerController: videoPlayerController!,
          autoPlay: widget.autoPlay ?? false,
          looping: false,
        );
      }
    }catch(e){
      AppHelper.myPrint("-------------------------- Error -------------------");
      AppHelper.myPrint(e.toString());
      AppHelper.myPrint("---------------------------------------------");

    }
    setState(() {});
  }

  @override
  void dispose() {
    if (chewieController != null) {
      chewieController!.dispose();
    }
    if (videoPlayerController != null) {
      videoPlayerController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (chewieController != null) {
      return Padding(
        padding:widget.padding ?? const EdgeInsets.symmetric(vertical: 10),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.curve??15),
              child: Chewie(controller: chewieController!)),
        ),
      );
    }
    return const SizedBox();
  }
}