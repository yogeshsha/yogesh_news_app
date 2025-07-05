import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/constants/api_constants.dart';
import 'package:video_player/video_player.dart';

import '../../../utils/app_localization.dart';

class DummySplashScreen extends StatefulWidget {
  const DummySplashScreen({super.key});

  @override
  State<DummySplashScreen> createState() => _DummySplashScreenState();
}

class _DummySplashScreenState extends State<DummySplashScreen>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<Offset>? offset;
  // FlutterGifController? controller2;

  @override
  void initState() {

    // controller2 = FlutterGifController(vsync: this);
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    offset = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1))
        .animate(controller!);
    navigate();
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    // controller2!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: SlideTransition(
                position: offset!,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.translate("Trade Link India"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontSize: 50),
                  ),
                ),
              ),
            ),
          ],
        ),
        // child: Image.asset(imagesConstants.splash,fit: BoxFit.fill),
      ),
    );
  }

  void navigate() async {
    Future.delayed(const Duration(seconds: 1))
        .then((value) => controller!.forward());
    // Future.delayed(const Duration(seconds: 1))
    //     .then((value) => controller2!.repeat(
    //           min: 0,
    //           max: 13,
    //           period: const Duration(seconds: 4),
    //         ));
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      VideoPlayerController videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(ApiConstants.dummyVideoUrl));
      ChewieController chewieController = ChewieController(
        aspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.height,
        showControls: false,
        showOptions: false,
        videoPlayerController: videoPlayerController,
        autoInitialize: true,
        autoPlay: true,);
      Future.delayed(const Duration(seconds: 3)).then((value) =>
          Navigator.pushNamedAndRemoveUntil(context, "/breakingNewsTv", (route) => false,arguments: chewieController));
    });

    // Future.delayed(const Duration(seconds: 4)).then((value) =>
    //     Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false));
  }
}
