import 'package:flutter/material.dart';
import 'package:newsapp/constants/api_constants.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../../../constants/ads_helps.dart';
import '../../../constants/app_constant.dart';
import '../../../utils/app_localization.dart';
import '../../widgets/ads_widget.dart';
import '../setting/component/common_app_bar_component.dart';


class LiveTvScreen extends StatefulWidget {
  final Function navigateToHome;
  const LiveTvScreen({super.key, required this.navigateToHome});

  @override
  State<LiveTvScreen> createState() => LiveTvScreenState();
}

class LiveTvScreenState extends State<LiveTvScreen> {
  static VideoPlayerController? videoPlayerController;
  late ChewieController chewieController;
  bool check2 = false;
  SessionHelperForVideo? sessionHelper;
  SessionHelper? sessionHelper1;
  // AdManagerBannerAd? _ads;
  // AdManagerBannerAd? _ads2;
  bool ad1 = false;
  bool ad2 = false;

  @override
  void initState() {
    // initAds();

    super.initState();
    initSession();
  }
  // void initAds(){
  //   _ads = AdsHelper.homeAds;
  //   _ads!.load();
  //   setState(() {
  //     ad1  = true;
  //   });
  //   _ads2 = AdsHelper.adsShow2;
  //   _ads2!.load();
  //   setState(() {
  //     ad2  = true;
  //   });
  // }
  void initSession() async {
    sessionHelper = await SessionHelperForVideo.getInstance(context);
    if(mounted) {
      sessionHelper1 = await SessionHelper.getInstance(context);
    }
    setPlayer();
  }

  setPlayer() {
    videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
        ApiConstants.dummyVideoUrl));
    if(sessionHelper != null) {
      videoPlayerController!.setVolume(
          double.parse(sessionHelper!.get(SessionHelperForVideo.isMuted) ?? "1"));
    }
    videoPlayerController!.initialize().then((value) {
      setState(() {
        check2 = true;
      });
    });
    videoPlayerController!.setVolume(0);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      chewieController = ChewieController(
          aspectRatio: MediaQuery.of(context).size.width / 250,
          videoPlayerController: videoPlayerController!,
          autoInitialize: true,
          autoPlay: true,
          looping: true,
          isLive: true);
    });
  }
  @override
  void dispose() {
    super.dispose();

    if (videoPlayerController != null) {
      videoPlayerController!.pause();
    }
    videoPlayerController!.dispose();
    chewieController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   elevation: 0,
      //   title: Text(
      //     AppLocalizations.of(context)!.translate("Live TV"),
      //     style:
      //     TextStyle(color: Theme.of(context).textTheme.displayLarge!.color),
      //   ),
      // ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: CommonAppBarComponent(
                  title: "Live TV",
                  onTapBackArrow: () {
                    widget.navigateToHome();
                  },
                ),
              ),
              // if (sessionHelper != null)
              //   if (sessionHelper!.get(SessionHelper.isShowAds) == "true")
              //     if (_ads != null)
              //       Container(
              //         alignment: Alignment.center,
              //         width: MediaQuery.of(context).size.width,
              //         height: 50,
              //         child: AdsHelper.home,
              //       ),
              const TestBanner(adId: AdWidgetUrls.fixedSizeBannerAd,),
              //
              // if(ad1)
              // AdsWidget(ad: AdsHelper.home!,sessionHelper: sessionHelper1 ,),
        
              check2
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: AspectRatio(
                            aspectRatio: MediaQuery.of(context).size.width / 250,
                            child: Chewie(
                              controller: chewieController,
                            )),
                      ),
                    )
                  : const SizedBox(),
              const TestBanner(adId: AdWidgetUrls.fixedSizeBannerAd,),
        
              // if(ad2)
              // AdsWidget(ad: AdsHelper.ads2!,sessionHelper: sessionHelper1 ,)
        
            ],
          ),
        ),
      ),
    );
  }
}
