// import 'package:admanager_web/admanager_web.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:newsapp/utils/app.dart';

// // ignore: must_be_immutable
// class AdsWidget extends StatelessWidget {
//   AdWidget ad;
//
//   SessionHelper? sessionHelper;
//   AdsWidget({super.key, required this.ad,required this.sessionHelper});
//   @override
//   Widget build(BuildContext context) {
//     if (sessionHelper != null) {
//       if (sessionHelper!.get(SessionHelper.isShowAds) == "true") {
//
//           Container(
//             alignment: Alignment.center,
//             width: MediaQuery.of(context).size.width,
//             height: 50,
//             child: ad,
//           );
//
//       }
//     }
//     return const SizedBox();
//   }
// }

class TestBanner extends StatefulWidget {
  final int height;
  final int width;
  final String adId;

  final String? type;
  const TestBanner(
      {super.key, required this.adId, this.width = 320, this.height = 50, this.type});

  @override
  State<TestBanner> createState() => _TestBannerState();
}

class _TestBannerState extends State<TestBanner> {
  // BannerAd? _bannerAd;/**/
  bool ad = false;
  dynamic _bannerAd;

  @override
  void initState() {
    super.initState();
    if (!AppHelper.checkIsWeb()) {
        _bannerAd = createBannerAd(widget.adId, widget.height, widget.width);

      // if(widget.type == "native"){
      //   _bannerAd = nativeAd(widget.adId, widget.height, widget.width);
      //
      // }else if(widget.type == "manager"){
      //   _bannerAd = adManagerBannerAd(widget.adId, widget.height, widget.width);
      // }else{
      //   _bannerAd = createBannerAd(widget.adId, widget.height, widget.width);
      // }

      // _bannerAd = createBannerAd(widget.adId);
      _bannerAd.load();
      setState(() {
        ad = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // if(checkIsWeb()){
    //   return AdBlock(
    //     size: [AdBlockSize(height: widget.height,width: widget.width)],
    //     // adUnitId: test,
    //     adUnitId: "/6355419/Travel/Europe",
    //   );
    // }
    if (ad) {
      final AdWidget adWidget = AdWidget(ad: _bannerAd);
      return Container(
        alignment: Alignment.center,

        width: _bannerAd.size.width.toDouble(),
        height: _bannerAd.size.height.toDouble(),
        child: adWidget,
      );
    }
    return const SizedBox();
  }

  @override
  void dispose() {
    super.dispose();
    if (!AppHelper.checkIsWeb()) {
      _bannerAd.dispose();
    }
  }

  BannerAd createBannerAd(String adUnitId, int height, int width) {
    return BannerAd(
      adUnitId: adUnitId,

      size: AdSize(width: width, height: height), // or another AdSize if needed

      listener: BannerAdListener(
        onAdLoaded: (ad) {
          AppHelper.myPrint("------------- Success in Load Ads ${ad.adUnitId} -------------");

          // Ad has loaded successfully.
        },
        onAdFailedToLoad: (adInfo, error) {
          ad = false;
          setState(() {});
          AppHelper.myPrint("------------- Error in Load Ads -------------");
          AppHelper.myPrint(adInfo.adUnitId);
          AppHelper.myPrint(error.message);
          AppHelper.myPrint("--------------------------");
          // Ad failed to load.
        },
      ),
      request: const AdRequest(),
    );
  }

  AdManagerBannerAd adManagerBannerAd(String adUnitId, int height, int width) {
    return AdManagerBannerAd(
      sizes: [AdSize(width: width, height: height)],
      adUnitId: adUnitId,

      // size: AdSize(width: width, height: height), // or another AdSize if needed

      listener: AdManagerBannerAdListener(
        onAdLoaded: (ad) {
          AppHelper.myPrint("------------- Success in Load Ads ${ad.adUnitId} -------------");

          // Ad has loaded successfully.
        },
        onAdFailedToLoad: (adInfo, error) {
          ad = false;
          setState(() {});
          AppHelper.myPrint("------------- Error in Load Ads -------------");
          AppHelper.myPrint(adInfo.adUnitId);
          AppHelper.myPrint(error.message);
          AppHelper.myPrint("--------------------------");
          // Ad failed to load.
        },
      ),
      request: const AdManagerAdRequest(),
    );
  }


  NativeAd nativeAd(String adUnitId, int height, int width) {
    return NativeAd(


      adUnitId: adUnitId,

      listener: NativeAdListener(
        onAdLoaded: (ad) {
          AppHelper.myPrint("------------- Success in Load Ads ${ad.adUnitId} -------------");

          // Ad has loaded successfully.
        },
        onAdFailedToLoad: (adInfo, error) {
          ad = false;
          setState(() {});
          AppHelper.myPrint("------------- Error in Load Ads -------------");
          AppHelper.myPrint(adInfo.adUnitId);
          AppHelper.myPrint(error.message);
          AppHelper.myPrint("--------------------------");
          // Ad failed to load.
        },
      ),
      request: const AdManagerAdRequest(),
    );
  }
}
