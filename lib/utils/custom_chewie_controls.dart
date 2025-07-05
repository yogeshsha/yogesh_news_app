import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/constants/api_constants.dart';
import 'package:video_player/video_player.dart';

import 'app_localization.dart';
import 'count_down_timer.dart';

class CustomChewieControls extends StatefulWidget {
  final VideoPlayerController controller;
  final bool showAds;
  final bool allowSkipping;
  final Function callBack;

  const CustomChewieControls(
      {super.key,
      required this.controller,
      this.showAds = false,
      this.allowSkipping = true,
      required this.callBack});

  @override
  State<CustomChewieControls> createState() => _CustomChewieControlsState();
}

class _CustomChewieControlsState extends State<CustomChewieControls> {
  bool check = false;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    widget.controller.pause();
    setPlayer();
    // TODO: implement initState
    super.initState();
  }

  setPlayer() {
    videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(ApiConstants.dummyAdsVideoUrl));
    videoPlayerController!.initialize().then((value) {
      setState(() {
        check = true;
      });
      videoPlayerController!.play();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      chewieController = ChewieController(
          aspectRatio: MediaQuery.of(context).size.width / 250,
          videoPlayerController: videoPlayerController!,
          autoInitialize: true,
          showControls: false);
    });

  }

  @override
  void dispose() {
    if (videoPlayerController != null) {
      videoPlayerController!.dispose();
    }
    if (chewieController != null) {
      chewieController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: check,
      replacement: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withOpacity(0.7),
        child: const Center(
          child: Text(
            'Ad is Loading',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      child: chewieController != null
          ? Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.7),
              child: Stack(
                children: [
                  Chewie(
                    controller: chewieController!,
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      // right: 0,
                      child: Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            color: Colors.black12),
                        child: Text(
                          AppLocalizations.of(context)!
                              .translate("Advertisement"),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      )),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    // right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (check)
                          Container(
                            alignment: Alignment.bottomLeft,
                            decoration: const BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: CountDownTimer(
                              secondsRemaining: videoPlayerController!
                                      .value.duration.inSeconds +
                                  1,
                              whenTimeExpires: () {
                                setState(() {
                                  widget.callBack();
                                });
                              },
                              countDownTimerStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        // VideoProgressIndicator(
                        //   videoPlayerController!,
                        //   colors: const VideoProgressColors(
                        //       backgroundColor: Colors.grey,
                        //       playedColor: Colors.yellow),
                        //   allowScrubbing:
                        //       false, // Allow user to scrub through the video
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
